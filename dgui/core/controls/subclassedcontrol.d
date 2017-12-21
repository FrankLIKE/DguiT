﻿/** DGui project file.

Copyright: Trogu Antonio Davide 2011-2013

License: $(HTTP boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors: Trogu Antonio Davide
*/
module dgui.core.controls.subclassedcontrol;

public import dgui.core.controls.reflectedcontrol;

abstract class SubclassedControl: ReflectedControl
{
	private WNDPROC _oldWndProc; // Original Window Procedure

	protected override void createControlParams(ref CreateControlParams ccp)
	{
		this._oldWndProc = WindowClass.superclass(ccp.SuperclassName, ccp.ClassName, cast(WNDPROC) /*FIXME may throw*/ &Control.msgRouter);
	}

	protected override uint originalWndProc(ref Message m)
	{
		if(IsWindowUnicode(this._handle))
		{
			m.Result = CallWindowProcW(this._oldWndProc, this._handle, m.Msg, m.wParam, m.lParam);
		}
		else
		{
			m.Result = CallWindowProcA(this._oldWndProc, this._handle, m.Msg, m.wParam, m.lParam);
		}

		return cast(uint)m.Result;
	}

	protected override void wndProc(ref Message m)
	{
		switch(m.Msg)
		{
			case WM_ERASEBKGND:
			{
				if(SubclassedControl.hasBit(cast(ulong)this._cBits, cast(ulong)ControlBits.DOUBLE_BUFFERED))
				{
					Rect r = void;
					GetUpdateRect(this._handle, &r.rect, false);

					scope Canvas orgCanvas = Canvas.fromHDC(cast(HDC)m.wParam, false); //Don't delete it, it's a DC from WM_ERASEBKGND or WM_PAINT
					scope Canvas memCanvas = orgCanvas.createInMemory(); // Off Screen Canvas

					Message rm = m;

					rm.Msg = WM_ERASEBKGND;
					rm.wParam = cast(WPARAM)memCanvas.handle;
					this.originalWndProc(rm);

					rm.Msg = WM_PAINT;
					//rm.wParam = cast(WPARAM)memCanvas.handle;
					this.originalWndProc(rm);

					scope PaintEventArgs e = new PaintEventArgs(memCanvas, r);
					this.onPaint(e);

					memCanvas.copyTo(orgCanvas, r, r.position);
					SubclassedControl.setBit(cast(ulong)this._cBits, cast(ulong)ControlBits.ERASED, true);
					m.Result = 0;
				}
				else
				{
					this.originalWndProc(m);
				}
			}
			break;

			case WM_PAINT:
			{
				if(SubclassedControl.hasBit(cast(ulong)this._cBits, cast(ulong)ControlBits.DOUBLE_BUFFERED) && SubclassedControl.hasBit(cast(ulong)this._cBits,cast(ulong)ControlBits.ERASED))
				{
					SubclassedControl.setBit(cast(ulong)this._cBits, cast(ulong)ControlBits.ERASED, false);
					m.Result = 0;
				}
				else
				{
					/* *** Not double buffered *** */
					Rect r = void;
					GetUpdateRect(this._handle, &r.rect, false); //Keep drawing area
					this.originalWndProc(m);

					scope Canvas c = Canvas.fromHDC(m.wParam ? cast(HDC)m.wParam : GetDC(this._handle), m.wParam ? false : true);
					HRGN hRgn = CreateRectRgnIndirect(&r.rect);
					SelectClipRgn(c.handle, hRgn);
					DeleteObject(hRgn);

					SetBkColor(c.handle, this.backColor.colorref);
					SetTextColor(c.handle, this.foreColor.colorref);

					scope PaintEventArgs e = new PaintEventArgs(c, r);
					this.onPaint(e);
				}
			}
			break;

			case WM_CREATE:
				this.originalWndProc(m);
				super.wndProc(m);
				break;

			default:
				super.wndProc(m);
				break;
		}
	}
}
