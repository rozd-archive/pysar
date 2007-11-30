package com.rozdobudko.suvii.pysar.model
{
	import flash.text.Font;
	
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	public class SelectFontProxy extends Proxy implements IProxy
	{
		// ------------------ CONSTANTS ------------------ //

		public static const NAME:String = "SelectFontProxy";
		
		// -------------- PRIVATE VARIABLES -------------- //
		
		private var _selectedFont:Font;

		private var _selectedSize:uint;
		
		private var _owner:Object;
		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SelectFontProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get fonts():Array
		{
			return Font.enumerateFonts(true);
		}
		
		
		public function get selectedFont():Font
		{
			return this._selectedFont;
		}
		
		public function set selectedFont(value:Font):void
		{
			this._selectedFont = value;
		}
		
		
		public function set selectedSize(value:uint):void
		{
			this._selectedSize = value;
		}
		
		public function get selectedSize():uint
		{
			return this._selectedSize;
		}
		
		
		public function get owner():Object
		{
			return this._owner;
		}
		
		public function set owner(value:Object):void
		{
			this._owner = value;
		}
		
		// ------------------- METHODS ------------------- //
	}
}