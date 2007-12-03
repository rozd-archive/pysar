package com.rozdobudko.suvii.pysar.model
{
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import mx.collections.ArrayCollection;
	import com.rozdobudko.suvii.pysar.model.data.ClassEntry;
	import com.rozdobudko.suvii.pysar.model.data.ConnectionEntry;

	public class SubjectsProxy extends Proxy implements IProxy
	{
		// ------------------ CONSTANTS ------------------ //

		public static const NAME:String = "SubjectsProxy";
		
		// ---------------- PRIVATE FIELDS --------------- //
		

		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SubjectsProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get connections():ArrayCollection
		{
			return LogProxy(this.facade.retrieveProxy(LogProxy.NAME)).connections;
		}
		
		public function get classes():ArrayCollection
		{
			return LogProxy(this.facade.retrieveProxy(LogProxy.NAME)).classes;
		}
		
		// ---------------- PUBLIC METHODS --------------- //	



		// --------------- PRIVATE METHODS --------------- //
		
		
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
	}
}