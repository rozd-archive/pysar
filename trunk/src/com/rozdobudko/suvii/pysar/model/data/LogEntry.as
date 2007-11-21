package com.rozdobudko.suvii.pysar.model.data
{
	public class LogEntry
	{
		public var level:int;
		public var message:LogEntryText;
		public var className:LogEntryText;
		public var connectionName:LogEntryText;
		
		private var _findData:LogEntryFindData;
		
		function LogEntry(level:int=0, message:LogEntryText=null, className:LogEntryText=null, connectionName:LogEntryText=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.className = className;
			this.connectionName = connectionName;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get findData():LogEntryFindData
		{
			return this._findData;
		}
		
		public function set findData(value:LogEntryFindData):void
		{
			this._findData = value;
		}
		
		// ------------------- METHODS ------------------- //
		
		public function toString():String
		{
			return	"[object LogEntry | " +
					this.level + ", " +
					this.message + ", " +
					this.className +", " +
					this.connectionName +"]";
		}
	}
}