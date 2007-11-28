package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.collections.ArrayCollection;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.observer.Notification;
	import org.puremvc.patterns.proxy.Proxy;
	import mx.utils.UIDUtil;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryFindData;

	public class LogProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "LogProxy";
		
		private var connections:ArrayCollection;
		private var connection:LocalConnection;
		private var _entries:ArrayCollection;
		
		public function LogProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
			
			this.setData(new ArrayCollection());
			
			this.connections = new ArrayCollection();
			
			this.connection = new LocalConnection(); 
			this.connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.connectionAsyncErrorHandler);
			this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.connectionSecurityErrorHandler);
			this.connection.addEventListener(StatusEvent.STATUS, this.connectionStatusHandler);
			this.connection.addEventListener(Event.ACTIVATE, this.connectionActivateHandler);
			this.connection.client = this;
			/**
			 * TODO: Replace connection name in to SettingsPanel
			 */
			this.connection.connect(Settings.CONNECTION_NAME);
		}
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get entries():ArrayCollection
		{
			return this.getData() as ArrayCollection;
		}

		// ------------------- METHODS ------------------- //
		
		public function add(name:String):void
		{
			trace("LogProxy :: add");
			
			this.connections.addItem(name);
		}
		
		public function log(level:int, message:String, className:String, connectionName:String):void
		{
			trace("LogProxy :: log");
			
			var entry:LogEntry = new LogEntry(
												UIDUtil.createUID(),
												level, 
												new LogEntryText(UIDUtil.createUID(), message), 
												new LogEntryText(UIDUtil.createUID(), className), 
												new LogEntryText(UIDUtil.createUID(), connectionName)
											  )
											  
			this.entries.addItem(entry);
			
			this.sendNotification(PysarFacade.LOG_ADD, entry);
		}
		
		// ------------------ HANDLERS ------------------- //
		
		private function connectionStatusHandler(event:StatusEvent):void
		{
			trace("LogProxy :: connectionStatusHandler");

			trace(event.type);
			trace(event.level);
			trace(event.code);
			trace(event.target);
		}
		private function connectionSecurityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("LogProxy :: connectionSecurityErrorHandler");
		}
		private function connectionAsyncErrorHandler(event:AsyncErrorEvent):void
		{
			trace("LogProxy :: connectionAsyncErrorHandler");
			
			trace(event.error);
			trace(event.errorID);
			trace(event.text);
			trace(event.type);
		}
		private function connectionActivateHandler(event:Event):void
		{
			trace("LogProxy :: connectionActivateHandler");
			
			trace(event.type);
			trace(event.target);
		}
	}
}