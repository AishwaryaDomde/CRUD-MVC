package com.demo.Dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.PersonModel;

@Repository
public class PersonDaoImpl implements PersonDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Transactional
	@Override
	public void addPerson(PersonModel PersonModel) {
		sessionFactory.getCurrentSession().saveOrUpdate(PersonModel);
	}

	@Transactional
	@Override
	public PersonModel get(int id) {
		return (PersonModel) sessionFactory.getCurrentSession().get(PersonModel.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PersonModel> getAllList() {
		return sessionFactory.getCurrentSession().createQuery("from PersonModel").list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PersonModel> deletePerson(int id) {
		PersonModel PersonModel = (PersonModel) sessionFactory.getCurrentSession().load(PersonModel.class, id);
		System.out.println("PersonModel"+PersonModel);
		if (null != PersonModel) {
			this.sessionFactory.getCurrentSession().delete(PersonModel);
		}
		return sessionFactory.getCurrentSession().createQuery("from PersonModel").list();
	}

}
