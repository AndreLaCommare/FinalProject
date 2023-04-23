package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.MealReview;

public interface MealReviewRepository extends JpaRepository<MealReview, Integer> {

	List<MealReview> findByMealId(int mealId);

}
