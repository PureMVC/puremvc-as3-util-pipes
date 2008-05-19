/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.plumbing
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	
	/**
	 * Pipe Filter.
	 * <P>
	 * Filters may modify the contents of messages before writing
	 * them to their output PipeFitting.  
	 */ 
	public class Filter extends Pipe
	{
		public static const PARAMS:int = 2;
		
		/**
		 * Constructor.
		 * <P>
		 * Optionally connect the output and set the parameters.</P>
		 */
		public function Filter( name:String, output:IPipeFitting=null, params:Object=null ) 
		{
			super( output );
			this.name = name;
			if ( params ) setParams( params );
		}

		/**
		 * Handle the incoming message.
		 * <P>
		 * If message type is normal, filter the message and 
		 * write the result to the output Pipe Fitting if the 
		 * filter operation is successful.</P>
		 * <P> 
		 * The Filter Control PARAMS message type tells the Filter
		 * to accept the body of the message as parameters. The
		 * Filter only accepts the parameters if it is for this
		 * specific filter.</P> 
		 * <P>
		 * Returns true if the filter process does not throw an error and subsequent operations 
		 * in the pipeline succede.</P>
		 */
		override public function write( message:IPipeMessage ):Boolean
		{
			var filtered:IPipeMessage;
			var success:Boolean = true;
			switch ( message.getType() )	
			{
				// Filter normal messages
				case Message.TYPE_NORMAL:
					try {
						filtered = filter( message );
						success = output.write( filtered );
					} catch (e:Error) {
						success = false;
					}
					break;
				
				// Accept parameters from control message 
				case Message.TYPE_CONTROL && Filter.PARAMS:
					if ( message.getHeader() as String == this.name ) {
						success = setParams( message.getBody );
					}
					break;
			}
				
			return success;			
		}
		
		/**
		 * Set the Filter parameters.
		 * 
		 * @param params the parameters object
		 * @return Boolean true if the parameters were valid and set.
		 */
		public function setParams( params:Object ):Boolean
		{
			var success:Boolean = true;
			if ( validateParams( params ) ) 
			{
				this.params = params;
			} else {
				success = false;
			}
			return success;
		}
		
		/**
		 * Validate the Filter parameters.
		 * <P>
		 * Override this method in your subclass
		 * and use it to ensure the parameters
		 * on the object passed in are valid for 
		 * use with your filter operation.</P>
		 * 
		 * @param params the parameters object
		 * @return Boolean true if the parameters were valid and set.
		 */
		protected function validateParams( params:Object ):Boolean
		{
			return true;
		}
		
		/**
		 * Filter the message.
		 * <P>
		 * <I>Override in subclass to add the filter functionality!</I>
		 * <B>Don't call super!</B> Instead process the message and
		 * return your filtered result.</P>
		 * <P>
		 * If your filter method detects an invalid or unauthorized
		 * input message, <B>it should throw an error.</B> This will result
		 * in false being returned to the ultimate writer client of 
		 * the pipeline this filter is a part of. This allows a
		 * pipleline to be transactional, and for the client  
		 * to perform rollback operations if the message is unsuccessfully
		 * written to the pipe.</P>     
		 */
		protected function filter( message:IPipeMessage ):IPipeMessage
		{
			return message;
		}
		
		protected var params:Object;
		protected var name:String;

	}
}