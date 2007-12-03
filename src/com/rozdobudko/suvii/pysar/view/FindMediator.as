package com.rozdobudko.suvii.pysar.view
{
	import com.rozdobudko.suvii.pysar.PysarFacade;
	import com.rozdobudko.suvii.pysar.model.FindProxy;
	import com.rozdobudko.suvii.pysar.view.components.FindModule;
	import com.rozdobudko.suvii.pysar.view.components.search.events.FindEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.puremvc.interfaces.IMediator;
	import org.puremvc.patterns.mediator.Mediator;
	import org.puremvc.patterns.observer.Notification;
	import org.puremvc.interfaces.INotification;
	
	public class FindMediator extends Mediator implements IMediator
	{
		// ---------------- STATIC FIELDS ---------------- //

		public static const NAME:String = "FindMediator";

		// ---------------- PRIVATE FIELDS --------------- //
		
		private var _searchPhraseNotFound:Boolean;
		
		// ------------------ CONSTRUCTOR ---------------- //
		
		public function FindMediator(component:Object)
		{
			super(component);
			
			this.component.addEventListener(FindEvent.SEARCH, this.searchHandler);
			
			this.component.searchBox.addEventListener(Event.CHANGE, this.searchHandler);
			this.component.includeBox.addEventListener(Event.CHANGE, this.includeHandler);
			this.component.excludeBox.addEventListener(Event.CHANGE, this.excludeHandler);
			this.component.nextBut.addEventListener(MouseEvent.CLICK, this.nextHandler);
			this.component.previosBut.addEventListener(MouseEvent.CLICK, this.previosHandler);
			this.component.hightlightingBut.addEventListener(MouseEvent.CLICK, this.hightlightHandler);
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					PysarFacade.FIND_PHRASE
				   ];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case PysarFacade.FIND_PHRASE :
					this.searchPhraseNotFound = !notification.getBody();
				break;
			}
		}
		
		// ------------------- PureMVC ------------------- //
		
		override public function getMediatorName():String
		{
			return NAME;
		}
		
		private function get component():FindModule
		{
			return this.getViewComponent() as FindModule;
		}
		
		private function get proxy():FindProxy
		{
			return this.facade.retrieveProxy(FindProxy.NAME) as FindProxy;
		}
		
		// -------------------- FIEDS -------------------- //
		
		public function get searchPhrase():String
		{
			return this.component.searchBox.text;
		}
		
		public function get includePhrase():String
		{
			return this.component.includeBox.text;
		}
		
		public function get excludePhrase():String
		{
			return this.component.excludeBox.text;
		}
		
		public function get caseSensitive():Boolean
		{
			return this.component.caseBox.selected;
		}
		
		public function get hightlight():Boolean
		{
			return this.component.hightlightingBut.selected;
		}
		
		public function get searchPhraseNotFound():Boolean
		{
			return this._searchPhraseNotFound;
		}

		public function set searchPhraseNotFound(value:Boolean):void
		{
			this._searchPhraseNotFound = value;
			
			this.component.searchBox.setStyle("backgroundColor", this.searchPhraseNotFound ? "0xFF6666" : "0xFFFFFF");
			
			this.component.searchBox.setStyle("color", this.searchPhraseNotFound ? "0xFFFFFF" : "0x0B333C");
		}
		
		// ------------------- HANDLERS ------------------- //
		
		
		
		// ---------------- USER INTRACTION --------------- //
		
		private function searchHandler(event:Event):void
		{
			this.sendNotification(PysarFacade.FIND_SEARCH);
			
			if(this.hightlight)
			{
				if(this.searchPhrase == "" || this.searchPhraseNotFound)
				{
					this.sendNotification(PysarFacade.FIND_HIDE_HIGHTLIGHT);
				}
				else
				{
					this.sendNotification(PysarFacade.FIND_SHOW_HIGHTLIGHT);
				}
			}
			else
			{
				this.sendNotification(PysarFacade.FIND_SEARCH);
			}
		}
		
		
		private function nextHandler(event:Event):void
		{
			if(this.searchPhraseNotFound || this.searchPhrase == "")
			{
				return;
			}
			
			this.sendNotification(PysarFacade.FIND_NEXT);
		}
		
		
		private function previosHandler(event:Event):void
		{
			if(this.searchPhraseNotFound || this.searchPhrase == "")
			{
				return;
			}
			
			this.sendNotification(PysarFacade.FIND_PREVIOS);
		}
		
		
		private function hightlightHandler(event:Event):void
		{
			if(this.searchPhraseNotFound || this.searchPhrase == "")
			{
				return;
			}
			
			if(this.hightlight)
			{
				this.sendNotification(PysarFacade.FIND_SHOW_HIGHTLIGHT);
			}
			else
			{
				this.sendNotification(PysarFacade.FIND_HIDE_HIGHTLIGHT);
			}
		}
		

		private function includeHandler(event:Event):void
		{
			this.sendNotification(PysarFacade.FIND_INCLUDE);
		}


		private function excludeHandler(event:Event):void
		{
			this.sendNotification(PysarFacade.FIND_EXCLUDE);
		}
	}
}