package fla
{
   import com.AUI.List;
   import com.AUI.event.ItemEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class SelectLanguage extends Sprite
   {
       
      
      public var _list:List;
      
      private var _callback:Function;
      
      public function SelectLanguage()
      {
         super();
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      public function init(param1:Function) : void
      {
         _callback = param1;
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         this.removeEventListener("addedToStage",onAddedToStage);
         _list = new List();
         _list.x = 0;
         _list.y = 30;
         _list.autoFitWidth = true;
         _list.autoFitHeight = true;
         addChild(_list);
         var _loc2_:* = 0;
         var _loc7_:Array = _G.fc.csv.selectAllArray("langSupports");
         _loc6_ = 0;
         _loc4_ = _loc7_.length;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc7_[_loc6_];
            _loc3_ = new SelectLanguageItem();
            _loc3_.data = _loc5_.name;
            _loc3_.iso3166 = _loc5_.field;
            if(_loc5_.field == Language.field)
            {
               _loc2_ = _loc6_;
            }
            _list.addItem(_loc3_);
            _loc6_++;
         }
         _list.selectedIndex = _loc2_;
         _list.addEventListener("itemSelect",onItemSelect);
      }
      
      private function onItemSelect(param1:ItemEvent) : void
      {
         if(_callback)
         {
            _callback(param1.value.iso3166);
         }
      }
   }
}
