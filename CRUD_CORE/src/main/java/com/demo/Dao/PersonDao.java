package com.demo.Dao;

import java.util.List;

import com.demo.PersonModel;

public interface PersonDao {
	void addPerson(PersonModel person);

	PersonModel get(int id);

	List<PersonModel> getAllList();

	List<PersonModel> deletePerson(int id);
}
