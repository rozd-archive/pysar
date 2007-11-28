package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.view.SettingsMediator;
	import com.rozdobudko.suvii.pysar.view.components.SettingsPanel;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;

	public class SettingsShowCommand extends SimpleCommand implements ICommand
	{
		public function SettingsShowCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var settingsProxy:SettingsProxy = this.facade.retrieveProxy(SettingsProxy.NAME) as SettingsProxy;
			
			if(!this.facade.retrieveMediator(SettingsMediator.NAME))
			{
				var panel:SettingsPanel = PopUpManager.createPopUp(PysarFacade.getInstance().application, SettingsPanel) as SettingsPanel;
				PopUpManager.centerPopUp(panel);
				
				this.facade.registerMediator(new SettingsMediator(panel));
			}
		}
	}
}