/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.messages
{
	
	/**
	 * Filter Control Message.
	 * <P>
	 * A special message for controlling the behavior of a Filter.</P>
	 * <P>
	 * When written to a pipeline containing a Filter, the type
	 * of the message is interpreted and acted upon by the Filter, 
	 * but only if the header property is the name of the filter
	 * instance. This allows multiple filters to be connected to the
	 * same pipeline and have control messages directed to them by 
	 * name.  
	 * </P>
	 */ 
	public class FilterControlMessage extends Message
	{
		/**
		 * Message type base URI
		 */
		protected static const BASE:String  = Message.BASE+'/filter/';
		
		/**
		 * Set filter parameters message type.
		 */ 
		public static const SET_PARAMS:String 	= BASE+'setparams';
		
		/**
		 * Set filter method message type.
		 */ 
		public static const SET_FILTER:String 	= BASE+'setfilter';

		/**
		 * Toggle to filter bypass mode message type.
		 */
		public static const BYPASS:String 		= BASE+'bypass';
		
		/**
		 * Toggle to filtering mode  message type. (default behavior).
		 */
		public static const FILTER:String  		= BASE+'filter';


		// Constructor
		public function FilterControlMessage( type:String, name:String, filter:Function=null, params:Object=null )
		{
			super( type );
			setName( name );
			setFilter( filter );
			setParams( params );
		}

		/**
		 * Set the target filter name.
		 */
		public function setName( name:String ):void
		{
			this.name = name;
		}
		
		/**
		 * Get the target filter name.
		 */
		public function getName( ):String
		{
			return this.name;
		}
		
		/**
		 * Set the filter function.
		 */
		public function setFilter( filter:Function ):void
		{
			this.filter = filter;
		}
		
		/**
		 * Get the filter function.
		 */
		public function getFilter( ):Function
		{
			return this.filter;
		}
		
		/**
		 * Set the parameters object.
		 */
		public function setParams( params:Object ):void
		{
			this.params = params;
		}
		
		/**
		 * Get the parameters object.
		 */
		public function getParams( ):Object
		{
			return this.params;
		}
		
		protected var params:Object;
		protected var filter:Function;
		protected var name:String;
	}
}