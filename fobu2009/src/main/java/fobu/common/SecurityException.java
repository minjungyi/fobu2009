package main.java.fobu.common;

/**
 * Security Exception
 *
 * @author  min 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class SecurityException extends Exception {

	/**
	 * The Constructor
	 */
	public SecurityException() {
		super();
	}
	
	/**
	 * The Constructor
	 *
	 * @param message Message
	 */
	public SecurityException(String message) {
		super(message);
	}
	
	/**
	 * The Constructor
	 *
	 * @param th Throwable
	 */
	public SecurityException(Throwable th) {
		super(th);
	}
	
	/**
	 * The Constructor
	 *
	 * @param message Message
	 * @param cause Throwable
	 */
	public SecurityException(String message, Throwable cause) {
		super(message, cause);
	}
	
}
