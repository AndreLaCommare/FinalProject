package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.Meal;

public interface MealService {


	Meal findByMealId(int mealId);

	List<Meal> findAllMeals();

	Meal create(String username, Meal meal);

	Meal update(String username, int tid, Meal meal);


	List<Meal> findAllMealsForUser(String username);

	boolean deactivate(String username, int mealId);

	Meal addGroceryItemToMeal(String username, int mealId, int groceryItemId, Meal meal);

	Meal removeGroceryItemFromMeal(String username, int mealId, int groceryItemId, Meal meal);

}
