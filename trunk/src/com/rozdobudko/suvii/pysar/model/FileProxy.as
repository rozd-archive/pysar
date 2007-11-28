package com.rozdobudko.suvii.pysar.model
{
	import org.puremvc.interfaces.IProxy;
	import org.puremvc.patterns.proxy.Proxy;

	public class FileProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "FileProxy";
		
		public function FileProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}
		
		override public function getProxyName():String
		{
			return NAME;
		}
		
	}
}