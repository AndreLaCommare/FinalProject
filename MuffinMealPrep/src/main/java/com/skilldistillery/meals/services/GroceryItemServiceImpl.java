package com.skilldistillery.meals.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.repositories.GroceryItemRepository;
import com.skilldistillery.meals.repositories.UserRepository;

@Service
public class GroceryItemServiceImpl implements GroceryItemService {

	@Autowired
	UserRepository userRepo;
	@Autowired
	GroceryItemRepository groceryRepo;

	@Override
	public List<GroceryItem> index(String username) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		if (user != null) {
			return groceryRepo.findAll();
			}
		return null;
	}
	@Override
	public Set<GroceryItem> findAllCreatedByUser(String username){
		return groceryRepo.findByUsersWithGroceries_Username(username);
	}

	@Override
	public GroceryItem show(String username, Integer groceryId) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		if (user != null) {
			return groceryRepo.queryById(groceryId);
		}
		return null;
	}

	@Override
	public GroceryItem create(String username, GroceryItem grocery) {
		// TODO Auto-generated method stub
		User user = userRepo.findByUsername(username);
		if (user != null) {
			return groceryRepo.saveAndFlush(grocery);
		}
		return null;
	}

	@Override
	public GroceryItem update(String username, int groceryId, GroceryItem grocery) {
		// TODO Auto-generated method stub
		GroceryItem existing = groceryRepo.findByIdAndUsersWithGroceries_Username(groceryId, username);
		System.out.println(existing);
		if (existing != null) {
			existing.setName(grocery.getName());

			return groceryRepo.saveAndFlush(existing);
		}
		return null;
	}

	@Override
	public boolean destroy(String username, int tid) {
		// TODO Auto-generated method stub
		boolean deleted = false;
		GroceryItem toDelete = groceryRepo.findByIdAndUsersWithGroceries_Username(tid, username);
		
		if (toDelete != null) {
			groceryRepo.delete(toDelete);
			deleted = true;
		}
		return deleted;
	}

}
