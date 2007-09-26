package modules.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public function const SEARCH:String;
		public function const SEARCH:String;
		
		public function SearchEvent(type:String, bubles:Boolean, cancelable:Boolean)
		{
			super(type, bubles, cancelable);
		}
	}
}