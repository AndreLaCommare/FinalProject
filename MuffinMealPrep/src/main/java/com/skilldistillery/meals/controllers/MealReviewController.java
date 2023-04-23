package com.skilldistillery.meals.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealReview;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.MealRepository;
import com.skilldistillery.meals.repositories.UserRepository;
import com.skilldistillery.meals.services.MealReviewService;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api/meals")
public class MealReviewController {
    @Autowired
    private MealReviewService mealReviewService;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private MealRepository mealRepository;

    @PostMapping("/{mealId}/mealReview/{userId}")
    public MealReview createMealReview(@RequestBody MealReview mealReview, @PathVariable int mealId, @PathVariable int userId) {
        Meal meal = mealRepository.findById(mealId);
        User user = userRepository.findById(userId);
        return mealReviewService.createMealReview(mealReview, meal, user);
    }

    @GetMapping("/{mealId}/mealReview")
    public List<MealReview> getMealReviewsByMealId(@PathVariable int mealId) {
        return mealReviewService.getMealReviewsByMealId(mealId);
    }
}
