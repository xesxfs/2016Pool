package fla
{
   import com.AUI.AuiDefine;
   import com.AUI.Button;
   import com.AUI.Window;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class Recommend extends Window
   {
       
      
      public var _title:TextField;
      
      public var _icon:MovieClip;
      
      public var _name:TextField;
      
      public var _done:Button;
      
      private var _object:Object;
      
      public function Recommend(param1:Object)
      {
         object = param1;
         super();
         _title.text = Language.id(7200);
         _done.addEventListener(AuiDefine.CLICK,onClickDone);
         _object = object;
         _name.text = _object.name;
         var loader:Loader = new Loader();
         loader.load(new URLRequest(object.iconUrl));
         loader.contentLoaderInfo.addEventListener("complete",function(param1:Event):void
         {
            _icon.visible = false;
            if(loader.content is Bitmap)
            {
               (loader.content as Bitmap).smoothing = true;
            }
         });
         loader.x = _icon.x;
         loader.y = _icon.y;
         addChild(loader);
      }
      
      private function onClickDone(param1:Event) : void
      {
         navigateToURL(new URLRequest(_object.gotoUrl));
         close();
      }
   }
}
