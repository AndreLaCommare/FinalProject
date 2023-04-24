package com.skilldistillery.meals.services;

import java.util.List;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.User;

public interface UserService {
	User findByUsername(String username);
	List<GroceryItem> fullShoppingList(String username);
	User addToShoppingList(String username, int groceryItemId);
	User removeFromShoppingList(String username, int groceryItemId);
	public User updateShoppingList(String username, int userId, User user);
	List<User> findAll();
	boolean removeFromGroceries(String username, int groceryItemId);
}
