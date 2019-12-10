package com.demo.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.demo.PersonModel;
import com.demo.Service.PersonService;
import com.google.gson.Gson;

@Controller
public class HomeController {

	@Autowired
	private PersonService perService;

	@RequestMapping("/")
	public ModelAndView home() {
		ModelAndView model = new ModelAndView("/home");
		perService.getAllList();
		String json = new Gson().toJson(perService.getAllList());
		model.addObject("Person_data", json);
		return model;
	}

	@RequestMapping("/addPerson")
	public ModelAndView addPerson(PersonModel person) {
		if (person.getId() == 0) {
			perService.addPerson(person);
		} else {
			perService.addPerson(person);
		}
		return new ModelAndView("redirect:/");
	}

	@RequestMapping("/MPerson/{id}")
	public ModelAndView get(@PathVariable("id") int id) {
		ModelAndView model = new ModelAndView("/edit");
		PersonModel CandidateObj = perService.get(id);
		if (CandidateObj == null) {
			throw new RuntimeException("Candidate not found" + id);
		} else {
			model.addObject("User", new Gson().toJson(CandidateObj));
		}
		return model;

	}

	@RequestMapping("/DPerson/{id}")
	public ModelAndView DPerson(@PathVariable("id") int id) {
		ModelAndView model = new ModelAndView();
		List<PersonModel> CandidateObj = perService.deletePerson(id);
		if (CandidateObj == null) {
			throw new RuntimeException("Candidate not found" + id);
		} else {
			model.addObject("Person_data", new Gson().toJson(perService.getAllList()));
		}
		return new ModelAndView("redirect:/");

	}
}
