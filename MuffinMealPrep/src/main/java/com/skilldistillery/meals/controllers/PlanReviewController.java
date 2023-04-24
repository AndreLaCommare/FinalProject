package com.skilldistillery.meals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.PlanReview;
import com.skilldistillery.meals.services.PlanReviewService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost/" })
public class PlanReviewController {

    @Autowired
    private PlanReviewService planReviewService;

    @GetMapping("mealPlans/{mealPlanId}/reviews")
    public List<PlanReview> getPlanReviewsByMealPlanId(@PathVariable int mealPlanId) {
        return planReviewService.findByMealPlanId(mealPlanId);
    }

    @PostMapping("mealPlans/{mealPlanId}/reviews")
    public PlanReview createPlanReview(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int mealPlanId, @RequestBody PlanReview planReview) {
        PlanReview createdPlanReview = planReviewService.createPlanReview(principal.getName(), mealPlanId, planReview);
        
        if (createdPlanReview == null) {
            res.setStatus(404);
        } else {
            res.setStatus(201);
            res.setHeader("Location", req.getRequestURL().append("/").append(createdPlanReview.getId().getMealPlanId()).append("/").append(createdPlanReview.getId().getUserId()).toString());
        }
        
        return createdPlanReview;
    }
}
