package com.rozdobudko.suvii.pysar.model.data
{
	public class LogEntryText
	{
		private var _text:String;

		public function LogEntryText(text:String)
		{
			super();
			
			this.text = text;
		}
		
		public function get text():String
		{
			return this._text;
		}
		public function set text(value:String):void
		{
			this._text = value;
		}
		
		public function toString():String
		{
			return	"[object LogEntryText | "+
					this.text + "]";
		}
	}
}