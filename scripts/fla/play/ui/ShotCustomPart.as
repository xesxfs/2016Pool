package fla.play.ui
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.greensock.TweenMax;
   import fla.MaxShots;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   
   public class ShotCustomPart extends Sprite
   {
       
      
      public var _numList:MovieClip;
      
      public var _icon:MovieClip;
      
      public var _button:Button;
      
      private var _tid:int;
      
      private var _total:int;
      
      private var _num:int;
      
      public var _seconds:int;
      
      public function ShotCustomPart()
      {
         super();
         _numList.mouseEnabled = false;
         _numList.mouseChildren = false;
         _icon.mouseEnabled = false;
         _icon.mouseChildren = false;
         _button.addEventListener(AuiDefine.CLICK,onClickButton);
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         this.addEventListener("removedFromStage",onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function init(param1:int) : void
      {
         _total = param1;
         _num = param1;
         setNum(_num,true);
      }
      
      public function setNum(param1:int, param2:Boolean) : void
      {
         _num = param1;
         var _loc3_:int = _numList._ins.numChildren;
         var _loc4_:int = -30 * (_loc3_ - _num - 1);
         if(param2)
         {
            _numList._ins.y = _loc4_;
         }
         else
         {
            TweenMax.killTweensOf(_numList._ins);
            TweenMax.to(_numList._ins,0.6,{
               "delay":0.6,
               "y":_loc4_
            });
         }
      }
      
      public function decNum() : void
      {
         if(_num == 0)
         {
            return;
         }
         _num = _num - 1;
         setNum(_num,false);
      }
      
      public function getNum() : int
      {
         return _num;
      }
      
      public function getTotal() : int
      {
         return _total;
      }
      
      public function getUsed() : int
      {
         return _total - _num;
      }
      
      private function onClickButton(param1:Event) : void
      {
         game.hud.addToCenter(new MaxShots(_num,onChange));
      }
      
      private function onChange(param1:int) : void
      {
         _G.playTick();
         setNum(param1,true);
      }
   }
}
