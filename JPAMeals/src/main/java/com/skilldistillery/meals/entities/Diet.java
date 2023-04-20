package com.skilldistillery.meals.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Diet {

	@Id	
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "meal_has_diet", 
	joinColumns = @JoinColumn(name = "diet_id"), 
	inverseJoinColumns = @JoinColumn(name = "meal_id"))
	private List<Meal> mealsWithDiets;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "meal_plan_has_diet", 
	joinColumns = @JoinColumn(name = "diet_id"), 
	inverseJoinColumns = @JoinColumn(name = "meal_plan_id"))
	private List<MealPlan> mealPlansWithDiets;
	
	

	public Diet() {
		
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

	public List<Meal> getMealsWithDiets() {
		return mealsWithDiets;
	}
	public void setMealsWithDiets(List<Meal> mealsWithDiets) {
		this.mealsWithDiets = mealsWithDiets;
	}
	public List<MealPlan> getMealPlansWithDiets() {
		return mealPlansWithDiets;
	}
	public void setMealPlansWithDiets(List<MealPlan> mealPlansWithDiets) {
		this.mealPlansWithDiets = mealPlansWithDiets;
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
		Diet other = (Diet) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Diet [id=" + id + ", name=" + name + "]";
	}
	
	
}
