package com.skilldistillery.meals.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.MealRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class MealServiceImpl implements MealService {

	@Autowired
	private MealRepository mealRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	
	@Override
	public List<Meal> findAllMeals() {
		List <Meal> meals = mealRepo.findAll();
		List <Meal> visibleMeals = new ArrayList<>();
		
		for (Meal meal : meals) {
			if(meal.isVisible()) {
			visibleMeals.add(meal);
			}
	}
		return visibleMeals;
	}
	
	@Override
	public List<Meal> findAllMealsForUser(String username) {
        return mealRepo.findByUser_Username(username);
    }

	@Override
	public Meal findByMealId( int mealId) {
		return mealRepo.findById(mealId);
	}

	@Override
	public Meal create(String username, Meal meal) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			meal.setUser(user);
			 return mealRepo.saveAndFlush(meal);
		}
		return null;
	}

	@Override
	public Meal update(String username, int mealId, Meal meal) {
		Meal managedMeal = mealRepo.findByIdAndUser_Username(mealId, username);
		if (managedMeal != null) {
			managedMeal.setName(meal.getName());
			managedMeal.setDescription(meal.getDescription());
			managedMeal.setImageUrl(meal.getImageUrl());
			managedMeal.setInstructions(meal.getInstructions());
			managedMeal.setEnabled(meal.isEnabled());
			managedMeal.setVisible(meal.isVisible());
			
			mealRepo.saveAndFlush(managedMeal);
		}
		return managedMeal;
	}

	@Override
	public boolean deactivate(String username, int mealId) {
	    boolean deactivated = false;
	    Meal meal = mealRepo.findByIdAndUser_Username(mealId, username);
	    if (meal != null) {
	        meal.setEnabled(false);
	        mealRepo.saveAndFlush(meal);
	        deactivated = true;
	    }
	    return deactivated;
	}
}
