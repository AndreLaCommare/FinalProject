package com.skilldistillery.meals.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.MealPlan;

public interface MealPlanRepository extends JpaRepository<MealPlan, Integer> {
	
	MealPlan findById(int mealPlanId);

}
