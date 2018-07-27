package fla.play.effect
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class NumEffect extends Sprite
   {
       
      
      public function NumEffect(param1:int)
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         var _loc4_:TextField = new TextField();
         _loc4_.defaultTextFormat = new TextFormat("Arial",18,16776960);
         _loc4_.autoSize = "left";
         _loc4_.text = param1 > 0?"+" + param1:param1.toString();
         _loc4_.filters = [new GlowFilter(0,1,2,2,2,2)];
         var _loc3_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,true,0);
         _loc3_.draw(_loc4_);
         var _loc2_:Bitmap = new Bitmap(_loc3_);
         _loc2_.x = -(int(_loc2_.width / 2));
         _loc2_.y = -(int(_loc2_.height / 2));
         this.addChild(_loc2_);
      }
   }
}
