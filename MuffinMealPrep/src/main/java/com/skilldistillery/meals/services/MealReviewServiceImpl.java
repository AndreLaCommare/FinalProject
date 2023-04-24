package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealReview;
import com.skilldistillery.meals.entities.MealReviewId;
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
    private MealRepository mealRepo;

    @Override
    public MealReview createMealReview(MealReview mealReview, int mealId, String username) {
    	Meal meal = mealRepo.findById(mealId);
    	System.out.println(meal);
        User user = userRepository.findByUsername(username);
        System.out.println(user);
        MealReviewId mealReviewId = new MealReviewId(mealId, user.getId());
        mealReview.setId(mealReviewId);
        mealReview.setMeal(meal);
        mealReview.setUser(user);
        mealReview.setEnabled(true);
        return mealReviewRepository.saveAndFlush(mealReview);
    }

    @Override
    public List<MealReview> getMealReviewsByMealId(int mealId) {
        return mealReviewRepository.findByMealId(mealId);
    }
    
    @Override
    public MealReview findMealReviewById(MealReviewId id) {
        return mealReviewRepository.findById(id);
    }

}

