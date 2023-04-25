package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.User;

public interface UserService {
	User findByUsername(String username);

	public User updateShoppingList(String username, int userId, User user);
	List<User> findAll();
	boolean removeFromGroceries(String username, int groceryItemId);

	boolean deactivate(int userId);
	
	boolean reactivate(int userId, User user);

	boolean userDeletingOwnAccount(String username);
}
