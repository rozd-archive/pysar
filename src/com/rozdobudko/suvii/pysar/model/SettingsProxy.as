package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.Settings;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.styles.CSSStyleDeclaration;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import flash.events.IOErrorEvent;
	import mx.formatters.SwitchSymbolFormatter;

	public class SettingsProxy extends Proxy implements IProxy
	{
		// ----------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "SettingsProxy";

		// ---------------- PRIVATE FIELDS ---------------- //
		
		private var preferencesFile:File;
		
		private var openStream:FileStream;

		private var writeStream:FileStream;
		
		private var preferences:XML;
		
		private var stylesMap:Object;

		private var _levels:Array;
		
		private var _selectedLevelsByBoxes:Boolean;

		private var _selectedLevelsByButtons:Boolean;
		
		private var _debugStyle:CSSStyleDeclaration;
		
		private var _infoStyle:CSSStyleDeclaration;
		
		private var _warningStyle:CSSStyleDeclaration;
		
		private var _errorStyle:CSSStyleDeclaration;
		
		private var _fatalStyle:CSSStyleDeclaration;
		
		private var _preferencesFile:Object;

		// ------------------ CONSTRUCTOR ----------------- //

		public function SettingsProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
			
			this.init();
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}

		// ----------------- PUBLIC FIEDS ----------------- //

		public function get levels():Array
		{
			return this._levels;
		}
		
		
		public function set levels(value:Array):void
		{
			this._levels = value;
		}
		
		
		public function get selectedLevelsByBoxes():Boolean
		{
			return this._selectedLevelsByBoxes;
		}


		public function set selectedLevelsByBoxes(value:Boolean):void
		{
			this._selectedLevelsByBoxes = value;
			this._selectedLevelsByButtons = !value;
		}


		public function get selectedLevelsByButtons():Boolean
		{
			return this._selectedLevelsByButtons;
		}


		public function set selectedLevelsByButtons(value:Boolean):void
		{
			this._selectedLevelsByButtons = value;
			this._selectedLevelsByBoxes = !value;
		}
		
		/**
		 * @public
		 * Style of <b>debug</b> level row.
		 */
		public function get debugStyle():CSSStyleDeclaration
		{
			return this._debugStyle;
		}
		
		/**
		 * @public
		 * Style of <b>info</b> level row.
		 */
		public function get infoStyle():CSSStyleDeclaration
		{
			return this._infoStyle;
		}
		
		/**
		 * @public
		 * Style of <b>warning</b> level row.
		 */
		public function get warningStyle():CSSStyleDeclaration
		{
			return this._warningStyle;
		}
		
		/**
		 * @public
		 * Style of <b>error</b> level row.
		 */
		public function get errorStyle():CSSStyleDeclaration
		{
			return this._errorStyle;
		}
		
		/**
		 * @public
		 * Style of <b>fatal</b> level row.
		 */
		public function get fatalStyle():CSSStyleDeclaration
		{
			return this._fatalStyle;
		}
		
		// --------------- PROTECTED FIELDS --------------- //

		

		// ---------------- PUBLIC METHODS ---------------- //

		public function save():void
		{
			for each(var style:XML in this.preferences.content.styles.levels.level)
			{
				/**
				 * TODO: Upgrade dec to hex transformation
				 */
				style.@color = "0x" + (this.stylesMap[style.@id].getStyle("color") == 0 ? "000000" : this.stylesMap[style.@id].getStyle("color").toString(16).toUpperCase());
				style.@fontStyle = this.stylesMap[style.@id].getStyle("fontStyle");
				style.@fontFamily = this.stylesMap[style.@id].getStyle("fontFamily");
				style.@fontWeight = this.stylesMap[style.@id].getStyle("fontWeight");
			}
			
			var stream:FileStream = new FileStream();
			try
			{
				stream.open(this.preferencesFile, FileMode.WRITE);
				stream.writeUTFBytes('<?xml version=\"1.0\" encoding=\"UTF-8\"?>' + this.preferences.toXMLString());
			}
			catch(e:Error)
			{
				// TODO: handle exception
			}
			stream.close();
		}
		
		/**
		 * Show "Save As " dia
		 */
		public function selectAutosaveFile():void
		{
			
		}
		
		// --------------- PROTECTED METHODS -------------- //

		

		// ---------------- PRIVATE METHODS --------------- //

		private function init():void
		{
			this.stylesMap = {};
			this.stylesMap[Settings.DEBUG] = this._debugStyle = new CSSStyleDeclaration();
			this.stylesMap[Settings.INFO] = this._infoStyle = new CSSStyleDeclaration();
			this.stylesMap[Settings.WARNING] = this._warningStyle = new CSSStyleDeclaration();
			this.stylesMap[Settings.ERROR] = this._errorStyle = new CSSStyleDeclaration();
			this.stylesMap[Settings.FATAL] = this._fatalStyle = new CSSStyleDeclaration();
			
			/**
			 * TODO: Test
			 */
			
			this.setDefaultStyle(this.debugStyle);
			this.setDefaultStyle(this.infoStyle);
			this.setDefaultStyle(this.warningStyle);
			this.setDefaultStyle(this.errorStyle);
			this.setDefaultStyle(this.fatalStyle);
			
			this.levels = [];
			this.levels[Settings.LEVEL_DEBUG] = true;
			this.levels[Settings.LEVEL_INFO] = true;
			this.levels[Settings.LEVEL_WARNING] = true;
			this.levels[Settings.LEVEL_ERROR] = true;
			this.levels[Settings.LEVEL_FATAL] = true;
			
			this.preferencesFile = File.applicationStorageDirectory.resolvePath(Settings.PREFERENCES_FILE_NAME);
			
			var stream:FileStream = new FileStream();
			try
			{
				stream.open(this.preferencesFile, FileMode.READ);
				this.preferences = new XML(stream.readUTFBytes(stream.bytesAvailable));
			}
			catch(e:Error)
			{
				 // TODO: handle the exception
			}
			stream.close();
			
			this.setPreferencesByFile();
		}
		
		private function setPreferencesByFile():void
		{
			for each(var style:XML in this.preferences.content.styles.levels.level)
			{
				this.stylesMap[style.@id].setStyle("color", style.@color);
				this.stylesMap[style.@id].setStyle("fontStyle", style.@fontStyle);
				this.stylesMap[style.@id].setStyle("fontFamily", style.@fontFamily);
				this.stylesMap[style.@id].setStyle("fontWeight", style.@fontWeight);
			}
		}
		
		private function setDefaultStyle(style:CSSStyleDeclaration):void
		{
			style.setStyle("fontWeight", "normal");
			style.setStyle("paddingLeft", 5);
			style.setStyle("paddingRight", 5);
		}

		// ------------------- HANDLERS ------------------- //
		
		private function openToReadHandler(event:Event):void
		{
			this.preferences = new XML(this.openStream.readUTFBytes(this.openStream.bytesAvailable));
			
			this.openStream.close();
			
			this.setPreferencesByFile();
		}


		private function openToWriteHandler(event:Event):void
		{
			trace("openToWriteHandler");
			
			trace("> "+this.preferences.toXMLString());
			this.writeStream.writeUTFBytes('<?xml version=\"1.0\" encoding=\"UTF-8\"?>' + this.preferences.toXMLString());
			this.writeStream.close();
		}
	}
}