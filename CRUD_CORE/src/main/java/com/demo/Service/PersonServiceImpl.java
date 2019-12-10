package com.demo.Service;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.PersonModel;
import com.demo.Dao.PersonDao;

@Service
@Transactional
public class PersonServiceImpl implements PersonService {
	@Autowired
	private PersonDao PersonDao;

	@Transactional
	@Override
	public void addPerson(PersonModel person) {
		PersonDao.addPerson(person);
	}

	@Override
	public PersonModel get(int id) {
		return PersonDao.get(id);
	}

	@Override
	public List<PersonModel> getAllList() {
		return PersonDao.getAllList();
	}

	@Override
	public List<PersonModel> deletePerson(int id) {
		return PersonDao.deletePerson(id);
	}

}
