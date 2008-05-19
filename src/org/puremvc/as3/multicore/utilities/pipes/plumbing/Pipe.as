/*
 PureMVC AS3/MultiCore Utility – Pipes
 Copyright (c) 2008 Cliff Hall<cliff.hall@puremvc.org>
 Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.multicore.utilities.pipes.plumbing
{
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeMessage;
	import org.puremvc.as3.multicore.utilities.pipes.interfaces.IPipeFitting;

	/**
	 * Pipe.
	 * <P>
	 * This is the most basic <code>IPipeFitting</code>,
	 * simply allowing the connection of an output
	 * fitting and writing of a message to that output.</P> 
	 */	
	public class Pipe implements IPipeFitting
	{
		protected var output:IPipeFitting;

		public function Pipe( output:IPipeFitting=null )
		{
			if (output) connect(output);
		}

		/**
		 * Connect another PipeFitting to the output.
		 * 
		 * PipeFittings connect to and write to other 
		 * PipeFittings in a one-way, syncrhonous chain.</P>
		 */
		public function connect( output:IPipeFitting ) : Boolean
		{
			var success:Boolean = false;
			if (this.output == null) {
				this.output = output;
				success=true;
			}
			return success;
		}
		
		/**
		 * Write the message to the connected output.
		 * 
		 * @param message the message to write
		 * @return Boolean whether any connected downpipe outputs failed
		 */
		public function write( message:IPipeMessage ):Boolean
		{
			return output.write( message );
		}
		
	}
}