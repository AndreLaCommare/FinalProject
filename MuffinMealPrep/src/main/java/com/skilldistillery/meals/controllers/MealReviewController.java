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

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealReview;
import com.skilldistillery.meals.entities.MealReviewId;
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
//    @Autowired
//    private UserRepository userRepository;
//    @Autowired
//    private MealRepository mealRepository;

    @PostMapping("{mealId}/mealReviews")
    public MealReview createMealReview(Principal principal, HttpServletRequest req,
    		HttpServletResponse res, @RequestBody MealReview mealReview, 
    		@PathVariable int mealId) {
        
    	
       
//        System.out.println(mealReviewId);
//        MealReview existingMealReview = mealReviewService.findMealReviewById(mealReviewId);
//        if (existingMealReview != null) {
//            res.setStatus(409);
//            return null;
//        }

       
        MealReview createdMealReview = mealReviewService.createMealReview(mealReview, mealId, principal.getName());
        
        if (createdMealReview == null) {
            res.setStatus(404);
        } else {
            res.setStatus(201);
            res.setHeader("Location", req.getRequestURL().append("/").append(createdMealReview.getId()).toString());
        }
        
        return createdMealReview;
    }

    @GetMapping("{mealId}/mealReviews")
    public List<MealReview> getMealReviewsByMealId(@PathVariable int mealId) {
        return mealReviewService.getMealReviewsByMealId(mealId);
    }
}
