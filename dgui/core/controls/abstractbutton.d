﻿/** DGui project file.

Copyright: Trogu Antonio Davide 2011-2013

License: $(HTTP boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors: Trogu Antonio Davide
*/
module dgui.core.controls.abstractbutton;

public import dgui.core.dialogs.dialogresult;
public import dgui.core.controls.ownerdrawcontrol;

/**
  Enum that contain the check state of a _CheckBox or similar component
  */
enum CheckState: uint
{
	CHECKED = BST_CHECKED, 				///Checked State
	UNCHECKED = BST_UNCHECKED,			///Unchecked State
	INDETERMINATE = BST_INDETERMINATE,	///Indeterminate State
}

/// Abstract class of a _Button/_CheckBox/_RadioButton
abstract class AbstractButton: OwnerDrawControl
{
	protected DialogResult _dr = DialogResult.NONE;

	protected override void createControlParams(ref CreateControlParams ccp)
	{
		AbstractButton.setBit(cast(ulong)(this._cBits), cast(ulong)(ControlBits.OWN_CLICK_MSG), true); // Let Button to handle Click Event itself

		ccp.SuperclassName = WC_BUTTON;
		this.setStyle(WS_TABSTOP, true);

		super.createControlParams(ccp);
	}

	protected override void onReflectedMessage(ref Message m)
	{
		switch(m.Msg)
		{
			case WM_COMMAND:
			{
				switch(HIWORD(m.wParam))
				{
					 case BN_CLICKED:
					 {
						MouseKeys mk = MouseKeys.NONE;

						if(GetAsyncKeyState(MK_LBUTTON))
						{
							mk |= MouseKeys.LEFT;
						}

						if(GetAsyncKeyState(MK_MBUTTON))
						{
							mk |= MouseKeys.MIDDLE;
						}

						if(GetAsyncKeyState(MK_RBUTTON))
						{
							mk |= MouseKeys.RIGHT;
						}

						Point p = Point(LOWORD(m.lParam), HIWORD(m.lParam));
						scope MouseEventArgs e = new MouseEventArgs(p, mk);
						this.onClick(EventArgs.empty);

						if(this._dr !is DialogResult.NONE)
						{
							Control c = this.topLevelControl;

							if(c)
							{
								c.sendMessage(DGUI_SETDIALOGRESULT, this._dr, 0);
							}
						}
					 }
					 break;

					default:
						break;
				}
			}
			break;

			default:
				break;
		}

		super.onReflectedMessage(m);
	}
}

/// Abstract class of a checkable button (_CheckBox, _RadioButton, ...)
abstract class CheckedButton: AbstractButton
{
	public Event!(Control, EventArgs) checkChanged; ///Checked Changed Event of a Checkable _Button

	private CheckState _checkState = CheckState.UNCHECKED;

	/**
	 Returns:
		True if the _Button is _checked otherwise False.

	 See_Also:
		checkState() property below.
	 */
	@property public bool checked()
	{
		return this.checkState is CheckState.CHECKED;
	}

	/**
	  Sets the checked state of a checkable _button

	  Params:
		True checks the _button, False unchecks it.
	  */
	@property public void checked(bool b)
	{
		this.checkState = b ? CheckState.CHECKED : CheckState.UNCHECKED;
	}

	/**
	  Returns:
		A CheckState enum that returns the state of the checkable button (it includes the indeterminate state too)
	  */
	@property public CheckState checkState()
	{
		if(this.created)
		{
			return cast(CheckState)this.sendMessage(BM_GETCHECK, 0, 0);
		}

		return this._checkState;
	}

	/**
	  Sets the check state of a checkable button
	  */
	@property public void checkState(CheckState cs)
	{
		this._checkState = cs;

		if(this.created)
		{
			this.sendMessage(BM_SETCHECK, cs, 0);
		}
	}

	protected override void onHandleCreated(EventArgs e)
	{
		this.sendMessage(BM_SETCHECK, this._checkState, 0);
		super.onHandleCreated(e);
	}

	protected override void onReflectedMessage(ref Message m)
	{
		switch(m.Msg)
		{
			case WM_COMMAND:
			{
				switch(HIWORD(m.wParam))
				{
					 case BN_CLICKED:
					 {
						if(this._checkState !is this.checkState) //Is Check State Changed?
						{
							this._checkState = this.checkState;
							this.onCheckChanged(EventArgs.empty);
						}
					 }
					 break;

					default:
						break;
				}
			}
			break;

			default:
				break;
		}

		super.onReflectedMessage(m);
	}

	protected void onCheckChanged(EventArgs e)
	{
		this.checkChanged(this, e);
	}
}
