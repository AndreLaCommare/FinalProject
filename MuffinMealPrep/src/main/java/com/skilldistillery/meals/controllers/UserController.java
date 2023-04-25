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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.User;
import com.skilldistillery.meals.services.GroceryItemService;
import com.skilldistillery.meals.services.UserService;

@CrossOrigin({ "*", "http://localhost/" })
@RestController
@RequestMapping("api")
public class UserController {

	@Autowired
	UserService userService;
	@Autowired
	GroceryItemService groceryService;

	
	@DeleteMapping("myShoppingList/{groceryItemId}")
	public void removeGroceryFromShoppingList(Principal principal,
			HttpServletRequest req,
			HttpServletResponse res,
			@PathVariable int groceryItemId) {
		System.out.println("in delete shopping list");
		try {
			if (userService.removeFromGroceries(principal.getName(), groceryItemId)){
				res.setStatus(204);
			}else {
				res.setStatus(404);
			}
		}catch(Exception e) {
			e.printStackTrace();
			res.setStatus(400);
		}
	}
	
	@PutMapping("myShoppingList/{userId}")
	public User shoppingList(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int userId, @RequestBody User user ) {
		User updatedUser =  userService.updateShoppingList(principal.getName(), userId, user);
		
		if (updatedUser == null) {
			res.setStatus(404);
		} else {
			res.setStatus(200);
		}
		return updatedUser;
	}
	
	@GetMapping("users")
	public List<User> getAllUsers(Principal principal, HttpServletRequest req, HttpServletResponse res){
		User user = userService.findByUsername(principal.getName());
		List<User>  allUsers = userService.findAll();
		if(allUsers != null && user.getRole() == "ADMIN") {
			res.setStatus(404);
		} else {
			res.setStatus(200);
		}
		return allUsers;
	}
	
    @DeleteMapping("users/{userId}")
    public void deactivate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int userId) {
       User adminUser  = userService.findByUsername(principal.getName());
       System.out.println(adminUser);
       if(adminUser.getRole().equals("ADMIN")) {
    	if (userService.deactivate( userId)) {
            res.setStatus(204);
        } else {
            res.setStatus(404);
        }
       }
    }
    
    @PutMapping("users/{userId}")
    public User reactivate(Principal principal, HttpServletRequest req, HttpServletResponse res, @PathVariable int userId, @RequestBody User user) {
        User adminUser  = userService.findByUsername(principal.getName());
        System.out.println(adminUser);
        if(adminUser.getRole().equals("ADMIN")) {
     	if (userService.reactivate( userId, user)) {
             res.setStatus(200);
             return user;
         } else {
             res.setStatus(404);
           
         }
     	
        }
        return null;
     }
    
    @DeleteMapping("users")
    public void userDeleteAccount(Principal principal, HttpServletRequest req, HttpServletResponse res){
    	System.out.println(principal.getName() + "**********************************");
    	if(userService.userDeletingOwnAccount(principal.getName())){
    		res.setStatus(200);
    	}else {
    		res.setStatus(404);
    	}
    }
	
}
