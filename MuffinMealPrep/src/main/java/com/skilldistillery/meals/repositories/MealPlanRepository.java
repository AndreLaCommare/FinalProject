package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.MealPlan;

public interface MealPlanRepository extends JpaRepository<MealPlan, Integer> {
	
	MealPlan findById(int mealPlanId);
	
	

	MealPlan findByIdAndPlanCreator_Username(int mealPlanId, String username);

	List<MealPlan> findByPlanCreator_Username(String username);
	List<MealPlan> findByVisibleTrueAndCopiedFromPlanIsNull();
	List<MealPlan> findByPlanCreator_UsernameAndVisibleTrue(String username);
}
