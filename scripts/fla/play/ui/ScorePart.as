package fla.play.ui
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class ScorePart extends Sprite
   {
       
      
      public var _scoreKey:TextField;
      
      public var _scoreVal:TextField;
      
      public var _star:MovieClip;
      
      private var _srcLevel:int;
      
      private var _srcScore:int;
      
      private var _target:Object;
      
      public function ScorePart()
      {
         super();
         _scoreKey.mouseEnabled = false;
         _scoreKey.text = Language.id(2010);
         _scoreVal.mouseEnabled = false;
         this.addEventListener("addedToStage",onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onAddedToStage);
         _target = {"v":_srcScore};
         update(true);
      }
      
      public function update(param1:Boolean = false) : void
      {
         imm = param1;
         TweenMax.killTweensOf(_target,true);
         TweenMax.to(_target,1.2,{
            "v":_G.player.getScore(),
            "onUpdate":function():void
            {
               _scoreVal.text = "LV" + _srcLevel + ":" + int(_target.v);
            },
            "onComplete":function():void
            {
               _star.gotoAndStop(_G.player.getStar());
               _srcLevel = _G.player.getLevel();
               _srcScore = _G.player.getScore();
               _scoreVal.text = "LV" + _srcLevel + ":" + _G.player.getScore().toString();
            }
         });
         if(imm)
         {
            TweenMax.killTweensOf(_target,true);
         }
      }
   }
}
