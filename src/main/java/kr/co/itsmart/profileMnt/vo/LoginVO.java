package kr.co.itsmart.profileMnt.vo;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;

public class LoginVO implements UserDetails {


    private String user_id; // username
    private String user_pw;

    // 기본 생성자
    public LoginVO(){}

    // 필드를 초기화하는 생성자
    public LoginVO(String user_id, String user_pw){
        this.user_id = user_id;
        this.user_pw = user_pw;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }
    public String getUser_pw() {
        return user_pw;
    }
    public void setUser_pw(String user_pw) {
        this.user_pw = user_pw;
    }

    // Builder 클래스
    public static class Builder{
        private String user_id;
        private String user_pw;

        public Builder user_id(String user_id){
            this.user_id = user_id;
            return this;
        }
        public Builder user_pw(String user_pw){
            this.user_pw = user_pw;
            return this;
        }
        public LoginVO build(){
            LoginVO loginVO = new LoginVO();
            loginVO.setUser_id(this.user_id);
            loginVO.setUser_pw(this.user_pw);
            return loginVO;
        }
    }

    // 빌더 메서드
    public static Builder builder() {
        return new Builder();
    }

    @Override
    public boolean isAccountNonExpired() {
        return UserDetails.super.isAccountNonExpired();
    }

    @Override
    public boolean isAccountNonLocked() {
        return UserDetails.super.isAccountNonLocked();
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return UserDetails.super.isCredentialsNonExpired();
    }

    @Override
    public boolean isEnabled() {
        return UserDetails.super.isEnabled();
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }

    @Override
    public String getPassword() {
        return  getUser_pw();
    }

    @Override
    public String getUsername() {
        return getUser_id();
    }
}
