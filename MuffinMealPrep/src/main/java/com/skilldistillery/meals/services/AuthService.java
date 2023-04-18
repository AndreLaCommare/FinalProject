package com.skilldistillery.meals.services;

import com.skilldistillery.meals.entities.User;

public interface AuthService {
	public User register(User user);
	public User getUserByUsername(String username);
}
