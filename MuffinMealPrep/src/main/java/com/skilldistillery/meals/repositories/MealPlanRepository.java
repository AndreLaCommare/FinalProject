package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.MealPlan;

public interface MealPlanRepository extends JpaRepository<MealPlan, Integer> {
	
	MealPlan findById(int mealPlanId);
	
	List<MealPlan> findByUser_Username(String username);
	
	MealPlan findByIdAndUser_Username(int mealPlanId, String username);
}
