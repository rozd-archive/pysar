package common
{
	public class LogEntry
	{
		public var level:int;
		public var message:String;
		public var className:String;
		public var connectionName:String;
		
		function LogEntry(level:int=0, message:String=null, className:String=null, connectionName:String=null){
			super();
			this.level = level;
			this.message = message;
			this.className = className;
			this.connectionName = connectionName;
		}
	}
}