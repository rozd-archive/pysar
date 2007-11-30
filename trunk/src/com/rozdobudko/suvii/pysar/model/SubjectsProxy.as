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
		
		private var _classes:ArrayCollection;

		private var _connections:ArrayCollection;
		
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
			return this._connections;
		}
		
		public function set connections(value:ArrayCollection):void
		{
			this._connections = value;
			
			this.sendNotification(PysarFacade.SUBJECTS_UPDATE);
		}
		
		public function get classes():ArrayCollection
		{
			return this._classes;
		}
		
		public function set classes(value:ArrayCollection):void
		{
			this._classes = value;
			
			this.sendNotification(PysarFacade.SUBJECTS_UPDATE);
		}
		
		// ---------------- PUBLIC METHODS --------------- //	



		// --------------- PRIVATE METHODS --------------- //
		
		
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
	}
}