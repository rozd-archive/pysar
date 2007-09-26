/**
 * TODO: Якщо підряд йдуть декілька однакових записів в опціях має бути такий налаштунок який дозволить об"єднати ці записи в один і помітить цого кількістно (на іконці запису яка позначає його рівень показати число як степінь)
 */ 
package common
{
	import flash.events.AsyncErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.core.WindowedApplication;
	import mx.events.FlexEvent;
	import mx.collections.ArrayCollection;
	import modules.SettingsModule;
	import mx.managers.PopUpManager;
	import flash.display.Stage;
	import flash.events.Event;

	public class Application extends WindowedApplication
	{
		private var connection:LocalConnection;
		private var entries:ArrayCollection;
		private var settings:SettingsModule;
		
		[Bindable]
		public var output:ArrayCollection;
		
		[Bindable]
		public var connections:ArrayCollection;

		[Bindable]
		public var classes:ArrayCollection;
		
		function Application(){
			super();
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			
			this.entries = new ArrayCollection();
			this.output = new ArrayCollection();
			this.connections = new ArrayCollection();
			this.classes = new ArrayCollection();
		}
		
		//----------------Main methods--------------------
		public function init():void {
			this.connection = new LocalConnection();
			this.connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.connectionAsyncErrorHandler);
			this.connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.connectionSecurityErrorHandler);
			this.connection.addEventListener(StatusEvent.STATUS, this.connectionStatusHandler);
			this.connection.addEventListener(Event.ACTIVATE, this.connectionActivateHandler);
			this.connection.client = this;
			this.connection.connect(Settings.CONNECTION_NAME);
		}
		public function log(level:int, message:String, className:String, connectionName:String):void {
			trace("Application :: log");

			this.entries.addItem(new LogEntry(level, message, className, connectionName));
			this.output = this.entries;
			
			for(var i:int=0; i<this.classes.length; i++){
				if(this.classes.getItemAt(i).name == className){
					return;
				}
			}
			
			this.classes.addItem({name:className});
		}
		public function add(name:String):void {
			trace("Application :: add");
			
			this.connections.addItem(name);
		}
		public function remove(name:String):void {
			trace("Application :: remove");
			
		}
		//----------------Main methods--------------------
		
		
		//----------------Handlers------------------------
		private function creationCompleteHandler(event:FlexEvent):void {
			trace("Application :: creationCompleteHandler");
			
			this.init();
		}
		
		private function connectionStatusHandler(event:StatusEvent):void {
			trace("ASLogger :: connectionStatusHandler");

			trace(event.type);
			trace(event.level);
			trace(event.code);
			trace(event.target);
		}
		private function connectionSecurityErrorHandler(event:SecurityErrorEvent):void {
			trace("ASLogger :: connectionSecurityErrorHandler");
		}
		private function connectionAsyncErrorHandler(event:AsyncErrorEvent):void {
			trace("ASLogger :: connectionAsyncErrorHandler");
			
			trace(event.error);
			trace(event.errorID);
			trace(event.text);
			trace(event.type);
		}
		private function connectionActivateHandler(event:Event):void {
			trace("Application :: connectionActivateHandler");
			
			trace(event.type);
			trace(event.target);
		}
		
		private function settingsChangeHandler(event:Event):void {
			//trace("Application :: settingsChangeHandler");
			
			this.output = new ArrayCollection();
			
			for(var i:int; i<this.entries.length; i++){
				for(var j:int=0; j<this.settings.levels.length; j++){
					if(LogEntry(this.entries[i]).level == this.settings.levels[j]){
						this.output.addItem(LogEntry(this.entries[i]));
					}
				}
			}
			
			PopUpManager.removePopUp(this.settings);
		}
		private function settingsCancelHandler(event:Event):void {
			//trace("Application :: settingsCancelHandler");
			
			PopUpManager.removePopUp(this.settings);
		}
		//----------------Handlers------------------------
		
		
		//----------------User interaction----------------
		protected function showSettings():void {
			this.settings = SettingsModule(PopUpManager.createPopUp(this, SettingsModule));
			this.settings.addEventListener(Event.CHANGE, this.settingsChangeHandler);
			this.settings.addEventListener(Event.CANCEL, this.settingsCancelHandler);
			PopUpManager.centerPopUp(this.settings);
		}
		//----------------User interaction----------------
	}
}