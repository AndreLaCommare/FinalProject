package com.skilldistillery.meals.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.GroceryItem;
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
	public User removeFromShoppingList(String username, int groceryItemId) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		GroceryItem groceryItem = groceryItemRepo.findById(groceryItemId).orElse(null);
		if (user != null && groceryItem != null) {
			user.removeGrocery(groceryItem);
			return userRepo.save(user);
		}
		return null;
	}

	@Override
	public User addToShoppingList(String username, int groceryItemId) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		GroceryItem groceryItem = groceryItemRepo.findById(groceryItemId).orElse(null);
		if (user != null && groceryItem != null) {
			user.addGrocery(groceryItem);
			return userRepo.save(user);
		}
		return null;
	}

	@Override
	public List<GroceryItem> fullShoppingList(String username) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		if(user != null) {
			System.out.println(userRepo.findByGroceries(username));
			return userRepo.findByGroceries(username);
			
		}
		return null;
	}

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
		GroceryItem gorceryItem = groceryItemRepo.queryById(groceryItemId);
		user.removeGrocery(gorceryItem);
		
		
		return removed;
	}
	
	

	
}
