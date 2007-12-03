package com.rozdobudko.suvii.pysar.model.data
{
	import mx.styles.CSSStyleDeclaration;
	import mx.formatters.SwitchSymbolFormatter;
	import com.rozdobudko.suvii.pysar.Settings;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.PysarFacade;
	
	public class LogEntry
	{
		private var id:String;
		
		public var level:int;
		public var message:LogEntryText;
		public var className:LogEntryText;
		public var connectionName:LogEntryText;
		
		private var _findData:FindData;
		
		function LogEntry(id:String, level:int=0, message:LogEntryText=null, className:LogEntryText=null, connectionName:LogEntryText=null)
		{
			super();
			
			this.level = level;
			this.message = message;
			this.className = className;
			this.connectionName = connectionName;
			
			this.id = id;
		}
		
		// -------------------- FIEDS -------------------- //
		
		/**
		 * 
		 */
		public function get findData():FindData
		{
			return this._findData;
		}
		
		public function set findData(value:FindData):void
		{
			this._findData = value;
		}
		
		/**
		 * Style of the output DataGrid and Text components.
		 */
		public function get style():CSSStyleDeclaration
		{
			var settingsProxy:SettingsProxy = PysarFacade.getInstance().retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
			
			switch(this.level)
			{
				case Settings.LEVEL_DEBUG :
					return settingsProxy.debugStyle;
				break;
				case Settings.LEVEL_INFO :
					return settingsProxy.infoStyle;
				break;
				case Settings.LEVEL_WARNING :
					return settingsProxy.warningStyle;
				break;
				case Settings.LEVEL_ERROR :
					return settingsProxy.errorStyle;
				break;
				case Settings.LEVEL_FATAL :
					return settingsProxy.fatalStyle;
				break;
			}
			
			return null;
		}
		
		/**
		 * Color of higtlighting text
		 * @return 
		 */		
		public function get hightlightColor():Number
		{
			return Settings.FIND_HIGHTLIGHT_COLOR;
		}
		
		// ------------------- METHODS ------------------- //
		
		public function phraseExist(phrase:String):Boolean
		{
			if( this.message.label.indexOf(phrase) != -1 ||
				this.className.label.indexOf(phrase) != -1 ||
				this.connectionName.label.indexOf(phrase) != -1)
			{
				return true;
			}
			
			return false;
		}
		
		public function toString():String
		{
			return	"[object LogEntry | " + this.id + "]";
//					this.level + ", " +
//					this.message + ", " +
//					this.className +", " +
//					this.connectionName +"]";
		}
	}
}