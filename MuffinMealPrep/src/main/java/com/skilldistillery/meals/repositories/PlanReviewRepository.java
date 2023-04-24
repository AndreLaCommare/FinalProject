package com.skilldistillery.meals.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.meals.entities.PlanReview;

public interface PlanReviewRepository extends JpaRepository<PlanReview, Integer> {

	List<PlanReview> findByMealPlanId(int mealPlanId);

}
