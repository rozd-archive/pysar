package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.view.FindMediator;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	
	public class FindProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FindProxy";
		
		public function FindProxy()
		{
			
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get searchPhrase():String
		{
			return FindMediator(this.facade.retrieveMediator(FindMediator.NAME)).searchPhrase;
		}
		
		public function get includePhrase():String
		{
			return FindMediator(this.facade.retrieveMediator(FindMediator.NAME)).includePhrase;
		}
		
		public function get excludePhrase():String
		{
			return FindMediator(this.facade.retrieveMediator(FindMediator.NAME)).excludePhrase;
		}
		
		public function get caseSensitive():Boolean
		{
			return FindMediator(this.facade.retrieveMediator(FindMediator.NAME)).caseSensitive;
		}
		
		public function get hightlight():Boolean
		{
			return FindMediator(this.facade.retrieveMediator(FindMediator.NAME)).hightlight;
		}
	}
}