package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.MealPlan;

public interface MealPlanService {

	List<MealPlan> findAllMealPlans();
	
	List<MealPlan> findAllMealPlansUser();
	
}
