package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealReview;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.MealRepository;
import com.skilldistillery.meals.repositories.MealReviewRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class MealReviewServiceImpl implements MealReviewService {
    @Autowired
    private MealReviewRepository mealReviewRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MealRepository mealRepository;

    @Override
    public MealReview createMealReview(MealReview mealReview, Meal meal, User user) {
        mealReview.setMeal(meal);
        mealReview.setUser(user);
        return mealReviewRepository.save(mealReview);
    }

    @Override
    public List<MealReview> getMealReviewsByMealId(int mealId) {
        return mealReviewRepository.findByMealId(mealId);
    }
}

