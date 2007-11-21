package com.rozdobudko.suvii.pysar.model.data
{
	public class LogEntryFindDataRange
	{
		public var begin:int;
		public var end:int;
		
		public function LogEntryFindDataRange(begin:int=-1, end:int=-1)
		{
			super();
			
			this.begin = begin;
			this.end = end;
		}
	}
}