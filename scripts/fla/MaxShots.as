package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Window;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class MaxShots extends Window
   {
       
      
      public var _title:TextField;
      
      public var _nums:MovieClip;
      
      private var _value:int;
      
      private var _cb:Function;
      
      public function MaxShots(param1:int, param2:Function)
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         super();
         _title.defaultTextFormat = _G.windowTitle;
         _title.text = Language.id(1010);
         _value = param1;
         _cb = param2;
         _nums.buttonMode = true;
         _nums.mouseEnabled = false;
         _loc6_ = 0;
         _loc5_ = _nums.numChildren;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _nums.getChildAt(_loc6_) as MovieClip;
            _loc4_ = _loc6_ + 1;
            _loc3_.gotoAndStop(_loc4_);
            if(_value == _loc4_)
            {
               _loc3_.graphics.beginFill(39168);
               _loc3_.graphics.drawRect(0,0,48,36);
            }
            _loc6_++;
         }
         _nums.addEventListener(AuiDefine.CLICK,onClickNum);
      }
      
      override protected function onAddedToStage(param1:Event) : void
      {
         super.onAddedToStage(param1);
      }
      
      override protected function onRemovedFromStage(param1:Event) : void
      {
         super.onRemovedFromStage(param1);
      }
      
      private function onClickNum(param1:Event) : void
      {
         var _loc2_:int = (param1.target as MovieClip).currentFrame;
         _G.player.model.createShots = _loc2_;
         _cb(_loc2_);
         close();
      }
   }
}
