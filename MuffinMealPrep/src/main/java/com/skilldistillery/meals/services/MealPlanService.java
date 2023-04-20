package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.entities.User;

public interface MealPlanService {

	List<MealPlan> findAllMealPlans();
	
	List<MealPlan> findAllMealPlansByUser(String username);
	
	MealPlan findMealPlanById(int mealPlanId);
	
	MealPlan findMealPlanByUserAndId(String username, int mealPlanId);
	
	MealPlan create(String username, MealPlan mealPlan);
	
	MealPlan update(String username, int mealPlanId, MealPlan mealPlan);
	
	boolean deactivate(String username, int mealPlanId);
	
}
