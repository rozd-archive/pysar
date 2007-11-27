package com.rozdobudko.suvii.pysar.model.data
{
	public class LogEntryText
	{
		private var _label:String;
		
		private var id:String;
		
		public function LogEntryText(id:String, label:String)
		{
			super();
			
			this.id = id;
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
			return	"[object LogEntryText | " + this.id + " | " + this.label + "]";
		}
	}
}