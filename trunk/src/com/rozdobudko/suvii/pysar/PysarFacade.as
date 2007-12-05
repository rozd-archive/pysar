package com.rozdobudko.suvii.pysar
{
	import com.rozdobudko.suvii.pysar.controller.DeployCommand;
	import com.rozdobudko.suvii.pysar.controller.FindExcludeCommand;
	import com.rozdobudko.suvii.pysar.controller.FindShowHightlightCommand;
	import com.rozdobudko.suvii.pysar.controller.FindIncludeCommnad;
	import com.rozdobudko.suvii.pysar.controller.FindNextCommand;
	import com.rozdobudko.suvii.pysar.controller.FindPreviosCommand;
	import com.rozdobudko.suvii.pysar.controller.FindSearchCommnad;
	import com.rozdobudko.suvii.pysar.controller.LogAddCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuOpenCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuPrintCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuSaveAsCommand;
	import com.rozdobudko.suvii.pysar.controller.MenuSaveCommand;
	import com.rozdobudko.suvii.pysar.controller.SettingsChangeCommand;
	import com.rozdobudko.suvii.pysar.controller.SettingsCloseCommand;
	import com.rozdobudko.suvii.pysar.controller.SettingsShowCommand;
	import com.rozdobudko.suvii.pysar.controller.ShowAlertCommand;
	import com.rozdobudko.suvii.pysar.controller.TempCommand;
	import com.rozdobudko.suvii.pysar.model.FileProxy;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.model.LogProxy;
	import com.rozdobudko.suvii.pysar.model.MenuProxy;
	import com.rozdobudko.suvii.pysar.model.OutputProxy;
	import com.rozdobudko.suvii.pysar.model.SettingsProxy;
	import com.rozdobudko.suvii.pysar.model.SubjectsProxy;
	
	import mx.core.WindowedApplication;
	
	import org.puremvc.interfaces.IFacade;
	import org.puremvc.patterns.facade.Facade;
	import com.rozdobudko.suvii.pysar.controller.FindHideHightlightCommand;
	import com.rozdobudko.suvii.pysar.controller.filesystem.AutosaveFileSaveAsCommand;
	
	public class PysarFacade extends Facade implements IFacade
	{
		
		// ----------------- NOTIFICATIONS ---------------- //
		
		public static const TEMP:String						= "temp";
		
		
		public static const INIT:String						= "init";
		public static const DEPLOY:String					= "deploy";
		public static const ALERT:String					= "alert";
		
		public static const MENU_SAVE:String				= "menuSave";
		public static const MENU_SAVE_AS:String				= "menuSaveAs";
		public static const MENU_OPEN:String				= "menuOpen";
		public static const MENU_PRINT:String				= "menuPrint";
		
		public static const FIND_SEARCH:String				= "findSearch";
		public static const FIND_NEXT:String				= "findNext";
		public static const FIND_PREVIOS:String				= "findPrevios";
		public static const FIND_SHOW_HIGHTLIGHT:String		= "findShowHightlight";
		public static const FIND_HIDE_HIGHTLIGHT:String		= "findHideHightlight";
		public static const FIND_PHRASE:String				= "findFindPhrase";
		public static const FIND_INCLUDE:String				= "findInclude";
		public static const FIND_EXCLUDE:String				= "findExclude";
		
		public static const OUTPUT_UPDATE:String			= "updateOutput";
		
		public static const LOG_ADD:String					= "logAdd";
		
		public static const SETTINGS_SHOW:String			= "settingsShow";
		public static const SETTINGS_CLOSE:String			= "settingsClose";
		public static const SETTINGS_CHANGE:String			= "settingsChange";
		
		public static const FS_AUTOSAVE_FILE_SAVE_AS:String	= "fileSystemAutosaveFileSaveAs";
		public static const FS_PREFERENCES_FILE_OPEN:String	= "fileSystemPreferencesFileOpen";
		
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
			this.registerProxy(new SubjectsProxy());
		}
		
		
		override protected function initializeController():void 
		{
			trace("PysarFacade :: initializeController");
			
			super.initializeController();
			
			this.registerCommand(PysarFacade.TEMP, TempCommand);
			
			this.registerCommand(PysarFacade.DEPLOY, DeployCommand);
			this.registerCommand(PysarFacade.LOG_ADD, LogAddCommand);
			this.registerCommand(PysarFacade.MENU_SAVE, MenuSaveCommand);
			this.registerCommand(PysarFacade.MENU_SAVE_AS, MenuSaveAsCommand);
			this.registerCommand(PysarFacade.MENU_OPEN, MenuOpenCommand);
			this.registerCommand(PysarFacade.MENU_PRINT, MenuPrintCommand);
			this.registerCommand(PysarFacade.FIND_SEARCH, FindSearchCommnad);
			this.registerCommand(PysarFacade.FIND_NEXT, FindNextCommand);
			this.registerCommand(PysarFacade.FIND_PREVIOS, FindPreviosCommand);
			this.registerCommand(PysarFacade.FIND_SHOW_HIGHTLIGHT, FindShowHightlightCommand);
			this.registerCommand(PysarFacade.FIND_HIDE_HIGHTLIGHT, FindHideHightlightCommand);
			this.registerCommand(PysarFacade.FIND_INCLUDE, FindIncludeCommnad);
			this.registerCommand(PysarFacade.FIND_EXCLUDE, FindExcludeCommand);
			this.registerCommand(PysarFacade.SETTINGS_SHOW, SettingsShowCommand);
			this.registerCommand(PysarFacade.SETTINGS_CLOSE, SettingsCloseCommand);
			this.registerCommand(PysarFacade.SETTINGS_CHANGE, SettingsChangeCommand);
			this.registerCommand(PysarFacade.ALERT, ShowAlertCommand);
			this.registerCommand(PysarFacade.FS_AUTOSAVE_FILE_SAVE_AS, AutosaveFileSaveAsCommand);
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