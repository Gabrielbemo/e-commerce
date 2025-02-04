package com.gabriel.ecommerce.kafka.order;

public record Customer(
        String Id,
        String firstname,
        String lastname,
        String email
) {
}
