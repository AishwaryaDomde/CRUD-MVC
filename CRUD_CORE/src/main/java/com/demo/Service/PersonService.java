package com.demo.Service;

import java.util.List;

import com.demo.PersonModel;

public interface PersonService {
	void addPerson(PersonModel person);

	PersonModel get(int id);

	List<PersonModel> getAllList();

	List<PersonModel> deletePerson(int id);
}
