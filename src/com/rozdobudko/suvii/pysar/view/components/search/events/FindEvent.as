package com.rozdobudko.suvii.pysar.view.components.search.events
{
	import flash.events.Event;

	public class FindEvent extends Event
	{
		public static const SEARCH:String		= "findSearch";
		public static const NEXT:String			= "findNext";
		public static const PREVIOS:String		= "findPrevios";
		public static const HIGHTLIGHT:String	= "findHightlight";
		
		public function FindEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}