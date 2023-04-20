package com.skilldistillery.meals.services;

import java.util.List;
import java.util.Set;

import com.skilldistillery.meals.entities.GroceryItem;

public interface GroceryItemService {
	public List<GroceryItem> index(	String username);

    public GroceryItem show(String username, Integer tid);

    public GroceryItem create(String username, GroceryItem grocery);

    public GroceryItem update(String username, int tid, GroceryItem grocery);

    public boolean destroy(String username, int tid);
    
    public Set<GroceryItem> findAllCreatedByUser(String username);
}
