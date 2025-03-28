package com.gabriel.ecommerce.customer;

import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class CustomerRequestTest {

    private Validator validator;

    @BeforeEach
    void setUp() {
        // Inicializa o validador para cada teste
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    void testValidCustomerRequest() {
        // Criando um objeto válido de CustomerRequest
        CustomerRequest request = new CustomerRequest(
                "123",
                "John",
                "Doe",
                "john.doe@example.com",
                new Address("Street 123", "City", "12345")
        );

        // Validando o objeto
        Set<ConstraintViolation<CustomerRequest>> violations = validator.validate(request);

        // Espera-se que não haja violações
        assertTrue(violations.isEmpty());
    }

    @Test
    void testMissingFirstname() {
        // Criando um objeto com o campo 'firstname' ausente
        CustomerRequest request = new CustomerRequest(
                "123",
                null,  // 'firstname' não informado
                "Doe",
                "john.doe@example.com",
                new Address("Street 123", "City", "12345")
        );

        // Validando o objeto
        Set<ConstraintViolation<CustomerRequest>> violations = validator.validate(request);

        // Espera-se uma violação de 'firstname' ausente
        assertEquals(1, violations.size());
        assertEquals("customer firstname is required", violations.iterator().next().getMessage());
    }

    @Test
    void testInvalidEmail() {
        // Criando um objeto com um email inválido
        CustomerRequest request = new CustomerRequest(
                "123",
                "John",
                "Doe",
                "invalid-email",  // Email inválido
                new Address("Street 123", "City", "12345")
        );

        // Validando o objeto
        Set<ConstraintViolation<CustomerRequest>> violations = validator.validate(request);

        // Espera-se uma violação de email inválido
        assertEquals(1, violations.size());
        assertEquals("customer email is not a valid email address", violations.iterator().next().getMessage());
    }

    @Test
    void testNullEmail() {
        // Criando um objeto com o campo 'email' ausente
        CustomerRequest request = new CustomerRequest(
                "123",
                "John",
                "Doe",
                null,  // 'email' não informado
                new Address("Street 123", "City", "12345")
        );

        // Validando o objeto
        Set<ConstraintViolation<CustomerRequest>> violations = validator.validate(request);

        // Espera-se uma violação de 'email' ausente
        assertEquals(1, violations.size());
        assertEquals("customer email is required", violations.iterator().next().getMessage());
    }

    @Test
    void testValidAddress() {
        // Criando um objeto com endereço válido
        CustomerRequest request = new CustomerRequest(
                "123",
                "John",
                "Doe",
                "john.doe@example.com",
                new Address("Street 123", "City", "12345")
        );

        // Validando o objeto
        Set<ConstraintViolation<CustomerRequest>> violations = validator.validate(request);

        // Espera-se que não haja violações no endereço (assumindo que Address tenha validações)
        assertTrue(violations.isEmpty());
    }
}
