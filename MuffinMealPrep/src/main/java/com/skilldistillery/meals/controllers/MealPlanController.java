package com.skilldistillery.meals.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.services.MealPlanService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class MealPlanController {

	@Autowired
	private MealPlanService mealPlanService;
	
	
	
}
