package com.rozdobudko.suvii.pysar.model.data
{
	public class LogEntryText
	{
		private var _label:String;

		public function LogEntryText(label:String)
		{
			super();
			
			this.label = label;
		}
		
		public function get label():String
		{
			return this._label;
		}
		public function set label(value:String):void
		{
			this._label = value;
		}
		
		public function toString():String
		{
			return	"[object LogEntryText | "+
					this.label + "]";
		}
	}
}