package com.rozdobudko.suvii.pysar
{
	import com.rozdobudko.suvii.pysar.controller.DeployCommand;
	import com.rozdobudko.suvii.pysar.controller.FindNextCommand;
	import com.rozdobudko.suvii.pysar.controller.FindPreviosCommand;
	import com.rozdobudko.suvii.pysar.controller.FindSearchCommnad;
	import com.rozdobudko.suvii.pysar.controller.LogAddCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuOpenCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuPrintCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuSaveAsCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuSaveCommand;
	import com.rozdobudko.suvii.pysar.controller.SettingsCloseCommand;
	import com.rozdobudko.suvii.pysar.controller.SettingsShowCommand;
	import com.rozdobudko.suvii.pysar.model.FileProxy;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.MenuProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	
	import mx.core.WindowedApplication;
	
	import org.puremvc.interfaces.IFacade;
	import org.puremvc.patterns.facade.Facade;
	
	public class PysarFacade extends Facade implements IFacade
	{
		
		// ----------------- NOTIFICATIONS ---------------- //
		
		public static const INIT:String						= "init";
		public static const DEPLOY:String					= "deploy";
		
		public static const MENU_SAVE:String				= "menuSave";
		public static const MENU_SAVE_AS:String				= "menuSaveAs";
		public static const MENU_OPEN:String				= "menuOpen";
		public static const MENU_PRINT:String				= "menuPrint";
		
		public static const FIND_SEARCH:String				= "findSearch";
		public static const FIND_NEXT:String				= "findNext";
		public static const FIND_PREVIOS:String				= "findPrevios";
		public static const FIND_HIGHTLIGHT:String			= "findHightlight";
		
		public static const OUTPUT_UPDATE:String			= "updateOutput";
		
		public static const LOG_ADD:String					= "logAdd";

		public static const SETTINGS_SHOW:String			= "settingsShow";
		public static const SETTINGS_CLOSE:String			= "settingsClose";
		
		// ----------------- PRIVATE FIELDS ---------------- //
		
		private var _application:WindowedApplication;
		
		// ------------------- SINGLETON ------------------- //

		public static function getInstance():PysarFacade
		{
			if(instance == null)
			{
				instance = new PysarFacade();
			}
			return instance as PysarFacade;
		}


		// ------------------ CONSTRUCTOR ------------------ //
		
		
		
		// -------------------- PureMVC -------------------- //
		
		override protected function initializeModel():void 
		{
			trace("PysarFacade :: initializeModel");
			
			super.initializeModel();
			
			this.registerProxy(new LogProxy());
			this.registerProxy(new MenuProxy());
			this.registerProxy(new FileProxy());
			this.registerProxy(new FindProxy());
			this.registerProxy(new OutputProxy());
			this.registerProxy(new SettingsProxy());
		}
		
		
		override protected function initializeController():void 
		{
			trace("PysarFacade :: initializeController");
			
			super.initializeController();
			
			this.registerCommand(PysarFacade.DEPLOY, DeployCommand);
			this.registerCommand(PysarFacade.LOG_ADD, LogAddCommand);
			this.registerCommand(PysarFacade.MENU_SAVE, MenuSaveCommand);
			this.registerCommand(PysarFacade.MENU_SAVE_AS, MenuSaveAsCommand);
			this.registerCommand(PysarFacade.MENU_OPEN, MenuOpenCommand);
			this.registerCommand(PysarFacade.MENU_PRINT, MenuPrintCommand);
			this.registerCommand(PysarFacade.FIND_SEARCH, FindSearchCommnad);
			this.registerCommand(PysarFacade.FIND_NEXT, FindNextCommand);
			this.registerCommand(PysarFacade.FIND_PREVIOS, FindPreviosCommand);
			this.registerCommand(PysarFacade.SETTINGS_SHOW, SettingsShowCommand);
			this.registerCommand(PysarFacade.SETTINGS_CLOSE, SettingsCloseCommand);
		}
		
		
		override protected function initializeView():void 
		{
			super.initializeView();
			
			trace("PysarFacade :: initializeView");
		}
		
		
		// ----------------- FIELDS ----------------- //
		
		public function get application():WindowedApplication
		{
			return this._application;
		}
		
		public function set application(value:WindowedApplication):void
		{
			this._application = value;
		}
	}
}