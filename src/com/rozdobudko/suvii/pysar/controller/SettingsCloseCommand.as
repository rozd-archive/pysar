package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.view.SettingsMediator;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class SettingsCloseCommand extends SimpleCommand implements ICommand
	{
		public function SettingsCloseCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var settingsProxy:SettingsProxy = this.facade.retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
			
			if(settingsProxy.popUp)
			{
				PopUpManager.removePopUp(settingsProxy.popUp);
				settingsProxy.popUp = null;
				
				this.facade.retrieveMediator(SettingsMediator.NAME);
			}
		}
		
	}
}