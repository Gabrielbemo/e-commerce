package com.gabriel.ecommerce.product;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

import java.math.BigDecimal;

public record ProductRequest(
        Integer id,
        @NotNull(message = "product name is required")
        String name,
        @NotNull(message = "product description is required")
        String description,
        @Positive(message = "product available shold be positive")
        double availableQuantity,
        @Positive(message = "product price shold be positive")
        BigDecimal price,
        @NotNull(message = "product category is required")
        Integer categoryId
) {
}
