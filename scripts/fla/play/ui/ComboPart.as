package fla.play.ui
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ComboPart extends Sprite
   {
       
      
      public var _comboKey:TextField;
      
      public var _comboVal:TextField;
      
      private var _num:int;
      
      private var _max:int;
      
      public function ComboPart()
      {
         super();
         _comboKey.mouseEnabled = false;
         _comboKey.text = Language.id(2014);
         _comboVal.mouseEnabled = false;
         _comboVal.text = "0";
      }
      
      public function set num(param1:int) : void
      {
         if(_num == param1)
         {
            return;
         }
         if(param1 > _max)
         {
            _max = param1;
         }
         _num = param1;
         _comboVal.text = _num > 0?"+" + _num:_num.toString();
         TweenMax.killTweensOf(_comboVal);
         TweenMax.to(_comboVal,0.3,{
            "colorTransform":{"tint":65280},
            "yoyo":true,
            "repeat":3
         });
      }
      
      public function get num() : int
      {
         return _num;
      }
      
      public function getMax() : int
      {
         return _max;
      }
   }
}
