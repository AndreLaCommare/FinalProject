package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.repositories.MealPlanRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class MealPlanServiceImpl implements MealPlanService {

	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private MealPlanRepository mealPlanRepo;

	@Override
	public List<MealPlan> findAllMealPlans() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MealPlan> findAllMealPlansUser() {
		// TODO Auto-generated method stub
		return null;
	}
}
