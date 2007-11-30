package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.data.ClassEntry;
	import com.rozdobudko.suvii.pysar.model.data.ConnectionEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntry;
	import com.rozdobudko.suvii.pysar.model.data.LogEntryText;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	public class LogProxy extends Proxy implements IProxy
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "LogProxy";

		// ---------------- PRIVATE FIELDS ---------------- //

		private var connection:LocalConnection;
		
		private var _entries:ArrayCollection;
		
		private var _connections:ArrayCollection;

		private var _classes:ArrayCollection;

		// ------------------ CONSTRUCTOR ----------------- //

		public function LogProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
			
			this._entries = new ArrayCollection();
			
			this._connections = new ArrayCollection();
			
			this._classes = new ArrayCollection();
			
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

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get entries():ArrayCollection
		{
			return this._entries
		}

		public function get connections():ArrayCollection
		{
			return this._connections;
		}
		
		public function get classes():ArrayCollection
		{
			return this._classes;
		}

		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public function add(name:String):void
		{
			this.addConnection(name);
		}
		
		public function log(level:int, message:String, className:String=null, connectionName:String=null):void
		{
			this.addClass(className, connectionName);
			
			this.addLog(level, message, className, connectionName);
		}

		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		private function addConnection(name:String):void
		{
			for(var i:uint; i<this.connections.length; i++)
			{
				if(ConnectionEntry(this.connections.getItemAt(i)).name == name)
				{
					return;
				}
			}
			
			this.connections.addItem(new ConnectionEntry(name, true));
		}
		
		private function addClass(className:String, connectionName:String=null):void
		{
			for(var i:uint; i<this.classes.length; i++)
			{
				var classEntry:ClassEntry = this.classes.getItemAt(i) as ClassEntry;
				
				if(classEntry.name == className && classEntry.connectionName == connectionName)
				{
					return
				}
			}
			
			this.classes.addItem(new ClassEntry(className, connectionName));
		}
		
		private function addLog(level:uint, message:String, className:String, connectionName:String):void
		{
			for(var i:uint; i<this.connections.length; i++)
			{
				if(!ConnectionEntry(this.connections.getItemAt(i)).enabled)
				{
					return;
				}
			}
			
			for(var j:uint; j<this.classes.length; j++)
			{
				if(!ClassEntry(this.classes.getItemAt(j)).enabled)
				{
					return;
				}
			}
			
			var entry:LogEntry = new LogEntry(
												UIDUtil.createUID(),
												level, 
												new LogEntryText(UIDUtil.createUID(), message), 
												new LogEntryText(UIDUtil.createUID(), className), 
												new LogEntryText(UIDUtil.createUID(), connectionName)
											  );
			this.entries.addItem(entry);
			
			this.sendNotification(PysarFacade.LOG_ADD, entry);
		}

		// ------------------- HANDLERS ------------------- //

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
//			trace("LogProxy :: connectionActivateHandler");
//			
//			trace(event.type);
//			trace(event.target);
		}

		// --------------- USER INTERACTION --------------- //

		
	}
}