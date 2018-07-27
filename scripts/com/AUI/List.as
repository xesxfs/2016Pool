package com.AUI
{
   import com.AUI.event.ItemEvent;
   import com.AUI.event.RadioEvent;
   import flash.display.DisplayObject;
   
   public dynamic class List extends VContainer
   {
       
      
      public var optionClass:Class;
      
      private var _radioNumber:int = 0;
      
      public var _selectedItem:Radio = null;
      
      public function List()
      {
         optionClass = Radio;
         super();
         var _loc1_:Number = Radio.incNumber;
         Radio.incNumber++;
         _radioNumber = _loc1_;
         addEventListener("radioChange",onRadioChange);
      }
      
      public function get data() : Array
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Array = [];
         _loc4_ = 0;
         _loc2_ = numItems;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = getItemAt(_loc4_) as Button;
            _loc1_.push(_loc3_.value);
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function set data(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:* = null;
         _selectedItem = null;
         removeItems();
         _loc5_ = 0;
         _loc3_ = param1.length;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = param1[_loc5_];
            _loc4_ = new optionClass();
            _loc4_.value = _loc2_;
            addItem(_loc4_);
            _loc5_++;
         }
         selectedIndex = 0;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         this.mouseEnabled = param1;
         this.mouseChildren = param1;
      }
      
      public function get enabled() : Boolean
      {
         return this.mouseEnabled;
      }
      
      override public function addItemAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         super.addItemAt(param1,param2);
         (param1 as Radio).number = _radioNumber;
         if(autoFitWidth == true)
         {
            setItemsWidth(_items.width);
         }
         return param1;
      }
      
      override public function removeItemAt(param1:int) : DisplayObject
      {
         var _loc2_:DisplayObject = super.removeItemAt(param1);
         if(_loc2_ == _selectedItem)
         {
            _selectedItem = null;
         }
         if(autoFitWidth == true)
         {
            setItemsWidth(getMaxFitWidth());
            setWindow(padding.left + _items.width + padding.right,padding.top + _items.height + padding.bottom);
         }
         return _loc2_;
      }
      
      public function getMaxFitWidth() : int
      {
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = 0;
         _loc1_ = 0;
         _loc5_ = _items.numChildren;
         while(_loc1_ < _loc5_)
         {
            _loc3_ = _items.getChildAt(_loc1_) as Radio;
            _loc4_ = _loc3_.getFitWidth();
            if(_loc4_ > _loc2_)
            {
               _loc2_ = _loc4_;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function get selectedItem() : Radio
      {
         return _selectedItem;
      }
      
      public function get selectedIndex() : int
      {
         if(_selectedItem == null)
         {
            return -1;
         }
         return getItemIndex(_selectedItem);
      }
      
      public function set selectedIndex(param1:int) : void
      {
         if(param1 < 0 || param1 >= numItems)
         {
            if(_selectedItem != null)
            {
               _selectedItem.selected = false;
               _selectedItem = null;
            }
            return;
         }
         var _loc2_:Radio = getItemAt(param1) as Radio;
         _loc2_.checked = true;
      }
      
      private function onRadioChange(param1:RadioEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Radio = param1.target as Radio;
         _selectedItem = _loc3_;
         _loc2_ = new ItemEvent("itemSelect");
         _loc2_.index = getItemIndex(_loc3_);
         _loc2_.value = _loc3_;
         dispatchEvent(_loc2_);
      }
   }
}
