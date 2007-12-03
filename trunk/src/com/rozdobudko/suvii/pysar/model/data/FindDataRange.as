package com.rozdobudko.suvii.pysar.model.data
{
	public class FindDataRange
	{
		public var beginIndex:int;
		public var endIndex:int;
		public var logText:LogEntryText
		
		public function FindDataRange(beginIndex:int=-1, endIndex:int=-1, logText:LogEntryText=null)
		{
			super();
			
			this.beginIndex = beginIndex;
			this.endIndex = endIndex;
			this.logText = logText;
		}
	}
}