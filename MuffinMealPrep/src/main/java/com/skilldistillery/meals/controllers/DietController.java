package com.skilldistillery.meals.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.meals.entities.Diet;
import com.skilldistillery.meals.services.DietService;

@RestController
@RequestMapping("api/diets")
@CrossOrigin({ "*", "http://localhost/" })
public class DietController {

    @Autowired
    private DietService dietService;

    @GetMapping
    public List<Diet> findAllDiets(HttpServletRequest req, HttpServletResponse res) {
        List<Diet> diets = dietService.findAllDiets();
        if (diets == null || diets.isEmpty()) {
            res.setStatus(404);
        } else {
            res.setStatus(200);
        }
        return diets;
    }
}
