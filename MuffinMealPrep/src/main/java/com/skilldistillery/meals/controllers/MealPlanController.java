package com.skilldistillery.meals.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.services.MealPlanService;
import com.skilldistillery.meals.services.UserService;

@RestController
@RequestMapping("api")
@CrossOrigin({"*", "http://localhost/"})
public class MealPlanController {

	@Autowired
	private MealPlanService mealPlanService;
	
	@Autowired
	private UserService userService;
	
	
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
		System.out.println(mealPlan + " before create");
		mealPlan = mealPlanService.create(principal.getName(), mealPlan);
		System.out.println(mealPlan + " after create ***********************************************************");
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

    @PutMapping("mealPlans/{mealPlanId}")
    public MealPlan update(Principal principal, HttpServletRequest req, HttpServletResponse res,
                       @PathVariable Integer mealPlanId, @RequestBody MealPlan mealPlan) {
    	MealPlan updatedMealPlan = null;
    	System.out.println(mealPlan.getTitle());
    	try {
        updatedMealPlan = mealPlanService.update(principal.getName(), mealPlanId, mealPlan);
        
        if (updatedMealPlan == null) {
            res.setStatus(404);
        }
    	}catch (Exception e) {
    		e.printStackTrace();
    		res.setStatus(400);
    	}
    	System.out.println(updatedMealPlan.getTitle()+ "*****************");
        return updatedMealPlan;
    }
    
    @DeleteMapping("mealPlans/admin/{mealPlanId}")
    public void adminDeactivate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int mealPlanId) {
    	User adminUser  = userService.findByUsername(principal.getName());
        
        if(adminUser.getRole().equals("ADMIN")) {
    	if (mealPlanService.adminDeactivate(mealPlanId)) {
    		res.setStatus(204);
    	} else {
    		res.setStatus(404);
    	}
        }
    }
    
    @PutMapping("mealPlans/admin/{mealPlanId}")
    public void adminReactivate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int mealPlanId, @RequestBody MealPlan mealPlan) {
    	User adminUser  = userService.findByUsername(principal.getName());
    	
    	if(adminUser.getRole().equals("ADMIN")) {
    		if (mealPlanService.adminReactivate(mealPlanId, mealPlan)) {
    			res.setStatus(200);
    		} else {
    			res.setStatus(404);
    		}
    	}
    }
}
