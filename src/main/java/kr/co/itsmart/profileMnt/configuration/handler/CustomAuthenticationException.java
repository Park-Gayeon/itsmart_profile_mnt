package kr.co.itsmart.profileMnt.configuration.handler;

public class CustomAuthenticationException extends RuntimeException{
    public CustomAuthenticationException(String message) {
        super(message);
    }
}
