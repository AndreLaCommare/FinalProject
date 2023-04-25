package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.Meal;

public interface MealRepository extends JpaRepository<Meal, Integer> {
	Meal findById(int mealId);
	List<Meal> findByUser_Username(String username);
	Meal findByIdAndUser_Username(int mealId, String username);
	List<Meal> findByNameLike(String query);

}
