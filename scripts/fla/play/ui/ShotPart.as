package fla.play.ui
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.clearInterval;
   
   public class ShotPart extends Sprite
   {
       
      
      public var _numList:MovieClip;
      
      private var _tid:int;
      
      private var _total:int;
      
      private var _num:int;
      
      public var _seconds:int;
      
      public function ShotPart()
      {
         super();
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
         var _loc3_:int = _numList._ins.numChildren;
         var _loc4_:int = -30 * (_loc3_ - param1 - 1);
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
   }
}
