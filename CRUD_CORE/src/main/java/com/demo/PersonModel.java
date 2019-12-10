package com.demo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "person")
public class PersonModel {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	@Column
	private String fname;
	@Column
	private String lname;
	@Column
	private String gender;
	@Column
	private String email;
	@Column
	private int contact;
	@Column
	private String pswd;
	

	public int getId() {
		return id;
	}
	public void setId(int id) {
		System.out.println(id);
		this.id = id;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getContact() {
		return contact;
	}
	public void setContact(int contact) {
		this.contact = contact;
	}
	public String getPswd() {
		return pswd;
	}
	public void setPswd(String pswd) {
		this.pswd = pswd;
	}
	@Override
	public String toString() {
		return "PersonModel [id=" + id + ", fname=" + fname + ", lname=" + lname + ", gender=" + gender + ", email="
				+ email + ", contact=" + contact + ", pswd=" + pswd + "]";
	}
	
}
