package com.gabriel.ecommerce.payment;

import jakarta.validation.Valid;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class PaymentMapper {
    public Payment toPayment(@Valid PaymentRequest request) {
        return Payment.builder()
                .id(request.id())
                .orderId(request.orderId())
                .paymentMethod(request.paymentMethod())
                .amount(request.amount())
                .createdAt(LocalDateTime.now())
                .build();
    }
}
