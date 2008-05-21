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
		protected static const BASE:String  = Message.BASE+'/filter/';
		
		/**
		 * Set filter parameters.
		 */ 
		public static const PARAMS:String 	= BASE+'params';
		
		/**
		 * Toggle to filter bypass mode.
		 */
		public static const BYPASS:String 	= BASE+'bypass';
		
		/**
		 * Toggle to filtering mode (default behavior).
		 */
		public static const FILTER:String  	= BASE+'filter';


		// Constructor
		public function FilterControlMessage( type:String, filterName:String, params:Object )
		{
			super( PARAMS, {filterName:filterName}, params );
		}

		

	}
}