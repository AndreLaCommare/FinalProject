package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.Meal;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.GroceryItemRepository;
import com.skilldistillery.meals.repositories.UserRepository;
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserRepository userRepo;
	
	@Autowired
	GroceryItemRepository groceryItemRepo;




	@Override
	public User updateShoppingList(String username, int userId, User user) {
		// TODO Auto-generated method stub
		User originalUser =userRepo.findById(userId);
		if (originalUser != null) {
			originalUser.setGroceries(user.getGroceries());
		
			userRepo.saveAndFlush(originalUser);
			
		}
		
		return originalUser;
		
	}

	@Override
	public User findByUsername(String username) {
		// TODO Auto-generated method stub
		return userRepo.findByUsername(username);
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		return userRepo.findAll();
	}
	
	@Override
	public boolean removeFromGroceries(String username, int groceryItemId) {
		boolean removed = false;
		User user = userRepo.findByUsername(username);
		GroceryItem groceryItem = groceryItemRepo.queryById(groceryItemId);
		if(user !=null && groceryItem !=null) {
		user.removeGrocery(groceryItem);
		userRepo.saveAndFlush(user);
		removed=true;
		}
		System.out.println(removed);
		return removed;
	}
	
	@Override
	public boolean deactivate( int userId) {
	    boolean deactivated = false;
	    User user = userRepo.findById(userId);
	    if (user != null) {
	        user.setEnabled(false);
	  
	        userRepo.saveAndFlush(user);
	        System.out.println(user);
	        deactivated = true;
	    }
	    return deactivated;
	}
	
	

	
}
