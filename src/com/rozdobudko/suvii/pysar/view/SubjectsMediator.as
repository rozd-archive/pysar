package com.rozdobudko.suvii.pysar.view
{
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.interfaces.INotification;
	import org.puremvc.interfaces.IMediator;
	import com.rozdobudko.suvii.pysar.view.components.SubjectsModule;
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.SubjectsProxy;

	public class SubjectsMediator extends Mediator implements IMediator
	{
		// ---------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "SubjectsMediator";

		// ---------------- PRIVATE FIELDS --------------- //
		
		
		
		// ----------------- CONSTRUCTOR ----------------- //
		
		public function SubjectsMediator(viewComponent:Object=null)
		{
			super(viewComponent);
			
			this.component.sources.dataProvider = this.proxy.sources;
			this.component.categories.dataProvider = this.proxy.categories;
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		// -------------------- FIEDS -------------------- //
		
		private function get component():SubjectsModule
		{
			return this.getViewComponent() as SubjectsModule;
		}
		
		private function get proxy():SubjectsProxy
		{
			return this.facade.retrieveProxy(SubjectsProxy.NAME) as SubjectsProxy;
		}
		
		
		// --------------- PRIVATE METHODS --------------- //
		
		
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// --------------- USER INTERACTION --------------- //
	}
}