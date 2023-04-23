package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealReview;
import com.skilldistillery.meals.entities.User;

public interface MealReviewService {

	MealReview createMealReview(MealReview mealReview, Meal meal, User user);

	List<MealReview> getMealReviewsByMealId(int mealId);

}
