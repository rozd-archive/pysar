package modules
{
	import modules.events.SearchEvent;
	
	
	/**
	 * Event modules.events.SearchEvent.SEARCH
	 * Dispatch when user click "Search" button.
	 */
	[Event(name="search", type="modules.events.SearchEvent")]
	
	public class SearchModule extends SearchModuleUI
	{
	
	
		//----------------Main methods--------------------
		//----------------Main methods--------------------
		
		
		//----------------Handlers------------------------
		//----------------Handlers------------------------
		
		
		//----------------User interaction----------------
		protected function searh(event:SearchEvent):void {
			
		}
		protected function hightlight(event:SearchEvent):void {
			
		}
		protected function mask(event:SearchEvent):void {
			
		}
		protected function next(event:SearchEvent):void {
			
		}
		protected function previos(event:SearchEvent):void {
			
		}
		//----------------User interaction----------------
	}
}