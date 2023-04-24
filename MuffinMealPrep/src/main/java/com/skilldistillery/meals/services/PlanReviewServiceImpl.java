package com.skilldistillery.meals.services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.entities.PlanReview;
import com.skilldistillery.meals.entities.PlanReviewId;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.MealPlanRepository;
import com.skilldistillery.meals.repositories.PlanReviewRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class PlanReviewServiceImpl implements PlanReviewService {

    @Autowired
    private PlanReviewRepository planReviewRepo;

    @Autowired
    private UserRepository userRepo;

    @Autowired
    private MealPlanRepository mealPlanRepo;

    @Override
    public List<PlanReview> findByMealPlanId(int mealPlanId) {
        return planReviewRepo.findByMealPlanId(mealPlanId);
    }

    @Override
    public PlanReview createPlanReview(String username, int mealPlanId, PlanReview planReview) {
        User user = userRepo.findByUsername(username);
        MealPlan mealPlan = mealPlanRepo.findById(mealPlanId);

        if (user != null && mealPlan != null) {
            PlanReviewId id = new PlanReviewId(mealPlanId, user.getId());
            id.setMealPlanId(mealPlanId);
           
            planReview.setId(id);

            planReview.setUser(user);
            planReview.setMealPlan(mealPlan);
            planReview.setCreatedAt(LocalDateTime.now());
            planReview.setEnabled(true);

            return planReviewRepo.saveAndFlush(planReview);
        }

        return null;
    }
}
