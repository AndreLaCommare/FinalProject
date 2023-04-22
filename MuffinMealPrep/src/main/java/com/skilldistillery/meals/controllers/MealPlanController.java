package com.skilldistillery.meals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.SystemPropertyUtils;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.services.MealPlanService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class MealPlanController {

	@Autowired
	private MealPlanService mealPlanService;
	
	
	@GetMapping("mealPlans")
	public List<MealPlan> showAll(){
		return mealPlanService.findAllMealPlans();
	}
	
	@GetMapping("myMealPlans")
	public List<MealPlan> userCreatedMealPlans(Principal principal){
		return mealPlanService.findAllMealPlansByUser(principal.getName());
	}
	
	@GetMapping("mealPlans/{mealPlanId}")
	public MealPlan showByMealPlanId(Principal principal,
			@PathVariable Integer mealPlanId,
			HttpServletResponse res) {
		MealPlan mealPlan = mealPlanService.findMealPlanById(mealPlanId);
		if(mealPlan == null) {
			res.setStatus(404);
		}
		return mealPlan;
	}
	
	@PostMapping("mealPlans")
	public MealPlan create(Principal principal, HttpServletRequest req,
			HttpServletResponse res, @RequestBody MealPlan mealPlan) {
		mealPlan = mealPlanService.create(principal.getName(), mealPlan);
		System.out.println(mealPlan);
		if(mealPlan == null) {
			res.setStatus(404);
		} else {
			res.setHeader("Location",
					req.getRequestURL().append("/").
					append(mealPlan.getId()).toString());
		}
		System.out.println(mealPlan);
		return mealPlan;
	}
	
	@PostMapping("mealPlans/{mealPlanId}/meals/{mealId}")
	public MealPlan addMealToMealPlan(Principal principal, @PathVariable int mealPlanId, @PathVariable int mealId, HttpServletRequest req, HttpServletResponse res) {
	    MealPlan mealPlan = mealPlanService.addMealToMealPlan(principal.getName(), mealPlanId, mealId);
	    if (mealPlan == null) {
	        res.setStatus(404);
	    } else {
	        res.setStatus(201);
	        res.setHeader("Location", req.getRequestURL().append("/").append(mealPlan.getId()).toString());
	    }
	    return mealPlan;
	}

}
