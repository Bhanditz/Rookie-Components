package com.gamerisker.controls
{
	import com.gamerisker.event.ComponentEvent;
	
	import starling.events.EventDispatcher;

	/**
	 * 	RadioButton	管理器
	 * @author GameRisker
	 * 
	 */	
	public class RadioButtonGroup extends EventDispatcher
	{
		/** @private */	
		private var m_group : Vector.<RadioButton>;

		/** @private */	
		private var m_currentbutton : RadioButton;
		
		/** @private */	
		protected var m_groupName : String = "defulatname";
		
		private static var m_instance : RadioButtonGroup;
		
		/**
		 *	构造函数 
		 */		
		public function RadioButtonGroup()
		{
			m_group = new Vector.<RadioButton>;
		}
		
		public static function getInstance() : RadioButtonGroup
		{
			if(m_instance)
				return m_instance;
			
			return m_instance = new RadioButtonGroup();
		}
		
		/**
		 *	将按钮添加进管理组 
		 * @param button
		 * 
		 */		
		public function addButton(button : RadioButton) : void
		{
			if(m_group.indexOf(button) > -1)
				return;
			
			button.addListener(callFunction);
			m_group.push(button);
		}
		
		/**
		 *	将按钮删除管理组
		 * @param button
		 * 
		 */		
		public function removeButton(button : RadioButton) : void
		{
			var index : int = m_group.indexOf(button);
			
			if(index > -1)
			{
				m_group.splice(index,1);
			}
		}

		/** @private */	
		private function callFunction(button : RadioButton) : void
		{
			for(var i:int=0;i<m_group.length;i++)
			{
				if(button == m_group[i])
				{
					if(!button.selected)
					{
						m_group[i].selected = true;
						
						dispatchEventWith(ComponentEvent.RADIOBUTTONCHANGE , false , button);
					}
				}
				else if(button.group == m_group[i].group)
				{
					m_group[i].selected = false;
				}
			}
			
			m_currentbutton = button;
		}
	}
}
