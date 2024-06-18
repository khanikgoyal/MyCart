package com.entities;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(length = 10, name = "user_id")
	private int userId;
	@Column(length = 100, name = "user_name")
	private String userName;
	@Column(length = 100, name = "user_email")
	private String userEmail;
	@Column(length = 100, name = "user_pass")
	private String userPassword;
	@Column(length = 12, name = "user_phn")
	private String userPhone;
	@Column(length = 1500, name = "user_pic")
	private String userPic;
	@Column(length = 1500, name = "user_address")
	private String userAddress;
	@Column(name="user_type")
	private String userType;

	
	public User(int userId, String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType) {
		this.userId=userId;
		this.userName=userName;
		this.userEmail=userEmail;
		this.userPassword=userPassword;
		this.userPhone=userPhone;
		this.userPic=userPic;
		this.userAddress=userAddress;
		this.userType=userType;
	}
	public User(String userName, String userEmail, String userPassword, String userPhone, String userPic, String userAddress, String userType) {
		this.userName=userName;
		this.userEmail=userEmail;
		this.userPassword=userPassword;
		this.userPhone=userPhone;
		this.userPic=userPic;
		this.userAddress=userAddress;
		this.userType=userType;
	}
	public User() {
		
	}
	
	public void setUserId(int userId) {
		this.userId=userId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserName(String userName) {
		this.userName=userName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail=userEmail;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword=userPassword;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone=userPhone;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPic(String userPic) {
		this.userPic=userPic;
	}
	public String getUserPic() {
		return userPic;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress=userAddress;
	}
	public String getUserAddress() {
		return userAddress;
	}
	
	
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	@Override
	public String toString() {
		return "User{" + "UserId=" + userId + ", UserName=" + userName + ", UserEmail=" + userEmail + ", UserPassword=" + userPassword + ", UserPhone = " + userPhone + ", UserPic=" + userPic + ", UserAddress=" + userAddress + "}";
	}
}
