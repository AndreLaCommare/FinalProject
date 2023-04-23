package com.skilldistillery.meals.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
@Entity
@Table(name="grocery_item")
public class GroceryItem {
	
	@Id	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@CreationTimestamp
	@Column(name="created_at")
	private LocalDateTime createdAt;
	
	@JsonIgnore
	@ManyToMany(mappedBy="groceries")
	private List<User> usersWithGroceries;
	
	@JsonIgnore
	@ManyToMany(mappedBy="groceryItems")
	private List<Meal> mealsWithGroceries;
	
	public GroceryItem() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public List<User> getUsersWithGroceries() {
		return usersWithGroceries;
	}

	public void setUsersWithGroceries(List<User> usersWithGroceries) {
		this.usersWithGroceries = usersWithGroceries;
	}
	public void addUser(User user) {
		if (usersWithGroceries == null) usersWithGroceries = new ArrayList<>();
		if (!usersWithGroceries.contains(user)) {
			usersWithGroceries.add(user);
			user.addGrocery(this);
		}
	}
	
	public void removeUser(User user) {
		if(usersWithGroceries != null && usersWithGroceries.contains(user)) {
			usersWithGroceries.remove(user);
			user.removeGrocery(this);
		}
	}
	

	public List<Meal> getMealsWithGroceries() {
		return mealsWithGroceries;
	}

	public void setMealsWithGroceries(List<Meal> mealsWithGroceries) {
		this.mealsWithGroceries = mealsWithGroceries;
	}
	
	public void addMeal(Meal meal) {
		if (mealsWithGroceries == null) mealsWithGroceries = new ArrayList<>();
		if (!mealsWithGroceries.contains(meal)) {
			mealsWithGroceries.add(meal);
			meal.addGrocery(this);
		}
	}
	
	public void removeMeal(Meal meal) {
		if(mealsWithGroceries != null && mealsWithGroceries.contains(meal)) {
			mealsWithGroceries.remove(meal);
			meal.removeGrocery(this);
		}
	}
	

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		GroceryItem other = (GroceryItem) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "GroceryItem [id=" + id + ", name=" + name + ", createdAt=" + createdAt + "]";
	}
	
	
	
}
