package fla.play.effect
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class PotEffect extends MovieClip
   {
       
      
      public function PotEffect()
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.addEventListener("enterFrame",onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.currentFrame == this.totalFrames)
         {
            this.removeEventListener("enterFrame",onEnterFrame);
            if(this.parent)
            {
               parent.removeChild(this);
            }
         }
      }
   }
}
