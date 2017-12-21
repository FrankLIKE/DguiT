﻿/** DGui project file.

Copyright: Trogu Antonio Davide 2011-2013

License: $(HTTP boost.org/LICENSE_1_0.txt, Boost License 1.0).

Authors: Trogu Antonio Davide
*/
module dgui.textbox;

import dgui.core.controls.textcontrol;

enum CharacterCasing
{
	NORMAL = 0,
	UPPERCASE = ES_UPPERCASE,
	LOWERCASE = ES_LOWERCASE,
}

class TextBox: TextControl
{
	private CharacterCasing _chChasing  = CharacterCasing.NORMAL;
	private uint _maxLength = 0;

	@property public final bool multiline()
	{
		return cast(bool)(this.getStyle() & ES_MULTILINE);
	}

	@property public final void multiline(bool b)
	{
		this.setStyle(ES_MULTILINE, b);
	}

	@property public final uint maxLength()
	{
		if(!this._maxLength)
		{
			if(this.getStyle() & ES_MULTILINE)
			{
				return 0xFFFFFFFF;
			}
			else
			{
				return 0xFFFFFFFE;
			}
		}

		return this._maxLength;
	}

	@property public final void maxLength(uint len)
	{
		this._maxLength = len;

		if(!len)
		{
			if(this.getStyle() & ES_MULTILINE)
			{
				len = 0xFFFFFFFF;
			}
			else
			{
				len = 0xFFFFFFFE;
			}
		}

		if(this.created)
		{
			this.sendMessage(EM_SETLIMITTEXT, len, 0);
		}
	}

	@property public final CharacterCasing characterCasing()
	{
		return this._chChasing;
	}

	@property public final void characterCasing(CharacterCasing ch)
	{
		this._chChasing = ch;

		if(this.created)
		{
			this.setStyle(this._chChasing, false); //Remove Old Style
			this.setStyle(ch, true); //Add New Style
		}
	}

	@property public final void numbersOnly(bool b)
	{
		this.setStyle(ES_NUMBER, b);
	}

	@property public final void passwordText(bool b)
	{
		this.setStyle(ES_PASSWORD, b);
	}

	protected override void createControlParams(ref CreateControlParams ccp)
	{
		this.setExStyle(WS_EX_CLIENTEDGE, true);
		this.setStyle(this._chChasing, true);
		ccp.SuperclassName = WC_EDIT;
		ccp.ClassName = WC_DEDIT;

		this.height = 20; //E questo cos'è?
		super.createControlParams(ccp);
	}

	protected override void onHandleCreated(EventArgs e)
	{
		if(this._maxLength)
		{
			this.sendMessage(EM_SETLIMITTEXT, this._maxLength, 0);
		}

		super.onHandleCreated(e);
	}
}
