package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.PlanReview;

public interface PlanReviewService {

	List<PlanReview> findByMealPlanId(int mealPlanId);

	PlanReview createPlanReview(String username, int mealPlanId, PlanReview planReview);

}
