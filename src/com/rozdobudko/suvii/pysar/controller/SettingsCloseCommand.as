package com.rozdobudko.suvii.pysar.controller
{
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.view.SettingsMediator;
	
	import mx.managers.PopUpManager;
	
	import org.puremvc.interfaces.ICommand;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.patterns.command.SimpleCommand;
	import mx.core.IFlexDisplayObject;

	public class SettingsCloseCommand extends SimpleCommand implements ICommand
	{
		public function SettingsCloseCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var settingsMediator:SettingsMediator = this.facade.retrieveMediator(SettingsMediator.NAME) as SettingsMediator;
			
			if(settingsMediator)
			{
				PopUpManager.removePopUp(settingsMediator.getViewComponent() as IFlexDisplayObject);
				
				this.facade.removeMediator(SettingsMediator.NAME);
			}
		}
		
	}
}