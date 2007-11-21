package com.rozdobudko.suvii.pysar.model
{
	import com.rozdobudko.suvii.pysar.view.components.SettingsPanel;
	
	import flash.text.StyleSheet;
	
	import mx.styles.CSSStyleDeclaration;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	public class SettingsProxy extends Proxy implements IProxy
	{
		// ------------------ CONSTANTS ------------------ //

		public static const NAME:String = "SettingsProxy";
		
		// -------------- PRIVATE VARIABLES -------------- //
		
		private var _popUp:SettingsPanel;
		
		private var _levels:Array;
		
		private var _selectedLevelsByBoxes:Boolean;

		private var _selectedLevelsByButtons:Boolean;
		
		private var _fatalStyle:CSSStyleDeclaration;
		
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
		
		public function get popUp():SettingsPanel
		{
			return this._popUp;
		}
		
		public function set popUp(value:SettingsPanel):void
		{
			this._popUp = value;
		}
		
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
		
		public function get fatalStyle():CSSStyleDeclaration
		{
			return this._fatalStyle;
		}
		
		// ------------------- METHODS ------------------- //
		
		private function init():void
		{
			this._fatalStyle = new CSSStyleDeclaration();

			this.fatalStyle.setStyle("font-family", "Verdana");
			this.fatalStyle.setStyle("color", "0x0B333C");
		}
		
		// ------------------  HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
	}
}