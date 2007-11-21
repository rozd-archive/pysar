package modules.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const SEARCH:String = "search";
		public static const HIGHTLIGHT:String = "hightlight";
		public static const RANGE:String = "range";
		public static const NEXT:String = "next";
		public static const PREVIOS:String = "previos";
		
		public function SearchEvent(type:String, bubles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubles, cancelable);
		}
	}
}