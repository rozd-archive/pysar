package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.view.components.SettingsPanel;
	
	import flash.text.Font;
	
	import mx.styles.CSSStyleDeclaration;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;
	import com.rozdobudko.suvii.pysar.Settings;

	public class SettingsProxy extends Proxy implements IProxy
	{
		// ------------------ CONSTANTS ------------------ //

		public static const NAME:String = "SettingsProxy";
		
		// -------------- PRIVATE VARIABLES -------------- //
		
		private var _popUp:SettingsPanel;
		
		private var _levels:Array;
		
		private var _selectedLevelsByBoxes:Boolean;

		private var _selectedLevelsByButtons:Boolean;
		
		private var _debugStyle:CSSStyleDeclaration;
		
		private var _infoStyle:CSSStyleDeclaration;
		
		private var _warningStyle:CSSStyleDeclaration;
		
		private var _errorStyle:CSSStyleDeclaration;
		
		private var _fatalStyle:CSSStyleDeclaration;
		
		private var _font:Font;
		
		// ----------------- CONSTRUCTOR ----------------- //
		
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
		
		// -------------------- FIEDS -------------------- //
		
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
		
		// ------------------- METHODS ------------------- //
		
		private function init():void
		{
			this._debugStyle = new CSSStyleDeclaration();
			this._infoStyle = new CSSStyleDeclaration();
			this._warningStyle = new CSSStyleDeclaration();
			this._errorStyle = new CSSStyleDeclaration();
			this._fatalStyle = new CSSStyleDeclaration();
			
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
		}
		
		private function setDefaultStyle(style:CSSStyleDeclaration):void
		{
			style.setStyle("fontWeight", "normal");
			style.setStyle("paddingLeft", 5);
			style.setStyle("paddingRight", 5);
		}
		
		// ------------------  HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
	}
}