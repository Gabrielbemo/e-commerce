package com.gabriel.ecommerce.order;

import com.gabriel.ecommerce.customer.CustomerClient;
import com.gabriel.ecommerce.exception.BusinessException;
import com.gabriel.ecommerce.orderline.OrderLineRequest;
import com.gabriel.ecommerce.orderline.OrderLineService;
import com.gabriel.ecommerce.product.ProductClient;
import com.gabriel.ecommerce.product.PurchaseRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository repository;
    private final OrderLineService orderLineService;
    private final CustomerClient customerClient;
    private final ProductClient productClient;
    private final OrderMapper mapper;

    public Integer createOrder(@Valid OrderRequest request) {

        //Using OpenFeign
        var customer = this.customerClient.findCustomerById(request.customerId())
                .orElseThrow(() -> new BusinessException("Cannot create order:: No Customer exists with the provided ID"));

        //Using RestTemplate
        this.productClient.purchaseProducts(request.products());

        var order = this.repository.save(mapper.toOrder(request));

        for (PurchaseRequest purchaseRequest : request.products()) {
            orderLineService.saveOrderLine(
                    new OrderLineRequest(
                            null,
                            order.getId(),
                            purchaseRequest.productId(),
                            purchaseRequest.quantity()
                    )
            );
        }

        // todo start payment process

        // todo send the order confirmation --> notification-ms (kafka)

        return null;
    }
}
