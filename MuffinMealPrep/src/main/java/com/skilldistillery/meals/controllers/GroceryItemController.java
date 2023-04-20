package com.skilldistillery.meals.controllers;

import java.security.Principal;
import java.util.List;
import java.util.Set;

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

import com.skilldistillery.meals.entities.GroceryItem;
import com.skilldistillery.meals.services.GroceryItemService;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class GroceryItemController {
	
	@Autowired
	GroceryItemService groceryServ;
	
	@GetMapping("groceries")
	public List<GroceryItem> index(Principal principal, HttpServletRequest req, HttpServletResponse res){
		List<GroceryItem> allGroceries = groceryServ.index(principal.getName());
	
		
		return allGroceries;
	}
	
	@GetMapping("myGroceries")
	public Set<GroceryItem> userCreatedGroceries(Principal principal, HttpServletRequest req, HttpServletResponse res){
		Set<GroceryItem> myGroceries = groceryServ.findAllCreatedByUser(principal.getName());
		return myGroceries;
	}
	
	@GetMapping("groceries/{groceryId}")
	public GroceryItem show(Principal principal,HttpServletRequest req, HttpServletResponse res, 
			@PathVariable Integer groceryId) {
		GroceryItem grocery = groceryServ.show(principal.getName(), groceryId);
		if(grocery == null) {
			res.setStatus(404);
		}
		return grocery;
	}
	
	@PostMapping("groceries")
	public GroceryItem create(Principal principal, HttpServletRequest req, HttpServletResponse res,
			@RequestBody GroceryItem grocery) {
		try {
			grocery = groceryServ.create(principal.getName(), grocery);
			if (grocery == null) {
				res.setStatus(404);
			} else {
				res.setStatus(201);
				res.setHeader("Location", req.getRequestURL().append("/").append(grocery.getId()).toString());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return grocery;
	}
	
	@PutMapping("groceries/{groceryId}")
	public GroceryItem update(Principal principal, HttpServletRequest req, HttpServletResponse res, 
			@PathVariable Integer groceryId, @RequestBody GroceryItem grocery) {
		GroceryItem updatedGrocery = null;
		try {
			updatedGrocery = groceryServ.update(principal.getName(), groceryId, grocery);
			if (updatedGrocery == null) {
				res.setStatus(404);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			res.setStatus(400);
		}

		return updatedGrocery;
	}
	
	@DeleteMapping("groceries/{groceryId}")
	public void destroy(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int groceryId) {

		try {
			if (groceryServ.destroy(principal.getName(), groceryId)) {
				res.setStatus(204);
			} else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}

	}

}
