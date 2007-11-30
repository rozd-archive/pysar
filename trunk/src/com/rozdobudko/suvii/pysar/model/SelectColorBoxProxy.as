package com.rozdobudko.suvii.pysar.model
{
	import flash.text.Font;
	import flash.utils.Proxy;
	
	import org.puremvc.interfaces.IProxy;

	public class SelectColorBoxProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "SelectColorBoxProxy";
		
		public function SelectCOlorBoxProxy()
		{
			super();
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
	}
}