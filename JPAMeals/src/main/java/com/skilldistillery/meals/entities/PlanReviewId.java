package com.skilldistillery.meals.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
@Embeddable
public class PlanReviewId implements Serializable {

private static final long serialVersionUID = 1L;
	
	@Column(name = "meal_plan_id")
	private int mealPlanId;

	@Column(name = "user_id")
	private int userId;
	
	public PlanReviewId() {
		
	}

	public int getMealPlanId() {
		return mealPlanId;
	}

	public void setMealPlanId(int mealPlanId) {
		this.mealPlanId = mealPlanId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(mealPlanId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PlanReviewId other = (PlanReviewId) obj;
		return mealPlanId == other.mealPlanId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "PlanReviewId [mealPlanId=" + mealPlanId + ", userId=" + userId + "]";
	}
	
}
