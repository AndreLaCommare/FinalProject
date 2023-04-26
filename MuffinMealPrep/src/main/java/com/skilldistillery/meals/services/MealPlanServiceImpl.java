package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.MealPlan;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.MealPlanRepository;
import com.skilldistillery.meals.repositories.MealRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class MealPlanServiceImpl implements MealPlanService {

	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired 
	private MealPlanRepository mealPlanRepo;
	
	@Autowired 
	private MealRepository mealRepo;

	@Override
	public List<MealPlan> findAllMealPlans() {
			
	
		return mealPlanRepo.findByVisibleTrueAndCopiedFromPlanIsNull();
	}

	@Override
	public List<MealPlan> findAllMealPlansByUser(String username) {
		
		return mealPlanRepo.findByPlanCreator_Username(username);
	}

	@Override
	public MealPlan findMealPlanById(int mealPlanId) {
		return mealPlanRepo.findById(mealPlanId);
		
	}

	@Override
	public MealPlan findMealPlanByUserAndId(String username, int mealPlanId) {
		return mealPlanRepo.findByIdAndPlanCreator_Username(mealPlanId, username);
		
	}

	@Override
	public MealPlan create(String username, MealPlan mealPlan) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			mealPlan.setPlanCreator(user);
			System.out.println(mealPlan + " IN SERVICE ******************* ");
			mealPlan.setEnabled(true);
			mealRepo.saveAllAndFlush(mealPlan.getMeals());
			return mealPlanRepo.saveAndFlush(mealPlan);
		}
		return null;
	}

	@Override
	public MealPlan update(String username, int mealPlanId, MealPlan mealPlan) {
		MealPlan original = mealPlanRepo.findByIdAndPlanCreator_Username(mealPlanId, username);
		
		if(original != null) {
			original.setTitle(mealPlan.getTitle());
			original.setDescription(mealPlan.getDescription());
			original.setEnabled(mealPlan.isEnabled());
			original.setVisible(mealPlan.isVisible());
			original.setDiets(mealPlan.getDiets());
			original.setMeals(mealPlan.getMeals());
			mealPlanRepo.saveAndFlush(original);
		}
		return original;
	}

	@Override
	public boolean deactivate(String username, int mealPlanId) {
		boolean deactivated = false;
		
		MealPlan mealPlanToDeactivate = mealPlanRepo.
										findByIdAndPlanCreator_Username(mealPlanId, username);
		if(mealPlanToDeactivate != null) {
			mealPlanToDeactivate.setEnabled(false); 
			deactivated = true;
		}
		return false;
	}
	
	@Override
	public boolean adminDeactivate( int mealId) {
	    boolean deactivated = false;
	    MealPlan mealPlan = mealPlanRepo.findById(mealId);
	    if (mealPlan != null) {
	        mealPlan.setEnabled(false);
	       
	        mealPlanRepo.saveAndFlush(mealPlan);
	        deactivated = true;
	    }
	    return deactivated;
	}
	
	@Override
	public boolean adminReactivate( int mealPlanId, MealPlan mealPlan) {
		boolean deactivated = false;
		mealPlan = mealPlanRepo.findById(mealPlanId);
		if (mealPlan != null) {
			mealPlan.setEnabled(true);
			
			mealPlanRepo.saveAndFlush(mealPlan);
			deactivated = true;
		}
		return deactivated;
	}
	
	@Override
	public MealPlan addMealToMealPlan(String username, int mealPlanId, int mealId) {
	    MealPlan mealPlan = mealPlanRepo.findByIdAndPlanCreator_Username(mealPlanId, username);
	    if (mealPlan != null) {
	        Meal meal = mealRepo.findById(mealId);
	        if (meal != null) {
	            mealPlan.addMeal(meal);
	            return mealPlanRepo.saveAndFlush(mealPlan);
	        }
	    }
	    return mealPlan;
	}
	
	@Override
	public boolean removeMealFromMealPlan(String username, int mealPlanId, int mealId) {
		boolean removed = false;
		User user = userRepo.findByUsername(username);
		MealPlan mealPlan = mealPlanRepo.findById(mealPlanId);
		Meal meal = mealRepo.findById(mealId);
		
		if(user !=null && mealPlan !=null) {
		mealPlan.removeMeal(meal);
		mealPlanRepo.saveAndFlush(mealPlan);
		removed=true;
		}
		System.out.println(removed);
		return removed;
	}

	@Override
	public boolean deleteMealPlan(String username, int mealPlanId) {
		boolean deleted = false;
		User user = userRepo.findByUsername(username);
		MealPlan mealPlanToDelete = mealPlanRepo.findById(mealPlanId);
		
		if(user != null && mealPlanToDelete != null) {
			mealPlanToDelete.setEnabled(false);
			mealPlanRepo.saveAndFlush(mealPlanToDelete);
			deleted = true;
		}
		
		
		return deleted;
	}
	
	@Override
	public List<MealPlan> mealPlanSearch(String query) {
		// TODO Auto-generated method stub
		return mealPlanRepo.findByTitleLike("%" + query + "%");
	}

}
