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
import com.skilldistillery.meals.services.MealService;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class MealController {

    @Autowired
    MealService mealService;

    @GetMapping("meals")
    public List<Meal> showAll(HttpServletRequest req, HttpServletResponse res) {
        List<Meal> allMeals = mealService.findAllMeals();
        return allMeals;
    }

    @GetMapping("myMeals")
    public List<Meal> userCreatedMeals(Principal principal, HttpServletRequest req, HttpServletResponse res) {
        List<Meal> myMeals = mealService.findAllMealsForUser(principal.getName());
        return myMeals;
    }

    @GetMapping("meals/{mealId}")
    public Meal showByMealId(HttpServletRequest req, HttpServletResponse res,
                     @PathVariable Integer mealId) {
        Meal meal = mealService.findByMealId(mealId);
        if (meal == null) {
            res.setStatus(404);
        }
        return meal;
    }


    @PostMapping("meals")
    public Meal create(Principal principal, HttpServletRequest req, HttpServletResponse res,
                       @RequestBody Meal meal) {
        meal = mealService.create(principal.getName(), meal);
        if (meal == null) {
            res.setStatus(404);
        } else {
            res.setStatus(201);
            res.setHeader("Location", req.getRequestURL().append("/").append(meal.getId()).toString());
        }
        return meal;
    }

    @PutMapping("meals/{mealId}")
    public Meal update(Principal principal, HttpServletRequest req, HttpServletResponse res,
                       @PathVariable Integer mealId, @RequestBody Meal meal) {
        Meal updatedMeal = mealService.update(principal.getName(), mealId, meal);
        if (updatedMeal == null) {
            res.setStatus(404);
        }
        return updatedMeal;
    }

    @DeleteMapping("meals/{mealId}")
    public void deactivate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int mealId) {
        if (mealService.deactivate(principal.getName(), mealId)) {
            res.setStatus(204);
        } else {
            res.setStatus(404);
        }
    }
    
    @PostMapping("meals/{mealId}/groceryItems/{groceryItemId}")
    public Meal addGroceryItemToMeal(Principal principal, HttpServletRequest req, HttpServletResponse res,
                                     @PathVariable int mealId, @PathVariable int groceryItemId, @RequestBody Meal meal) {
        Meal updatedMeal = mealService.addGroceryItemToMeal(principal.getName(), mealId, groceryItemId, meal);
        if (updatedMeal == null) {
            res.setStatus(404);
        } else {
            res.setStatus(200);
        }
        return updatedMeal;
    }

}
