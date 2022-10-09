package com.portfolio.gascharge.repository.charge;

import com.portfolio.gascharge.domain.charge.Charge;
import com.portfolio.gascharge.domain.charge.search.ChargeStatus;
import com.portfolio.gascharge.enums.charge.ChargePlaceMembership;
import com.querydsl.core.QueryResults;
import com.querydsl.core.types.OrderSpecifier;
import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;

import java.util.List;

import static com.portfolio.gascharge.domain.charge.QCharge.charge;
import static com.portfolio.gascharge.utils.querydsl.QueryDslUtil.getOrderSpecifiers;
import static io.micrometer.core.instrument.util.StringUtils.isEmpty;

@RequiredArgsConstructor
public class ChargeRepositoryImpl implements ChargeRepositoryCustom {

    private final JPAQueryFactory queryFactory;

    @Override
    public Page<Charge> findChargeWithSearchStatus(ChargeStatus chargeStatus, Pageable pageable) {
        List<OrderSpecifier> orderSpecifiers = getOrderSpecifiers(pageable, Charge.class, "charge");

        QueryResults<Charge> results = queryFactory
                .selectFrom(charge)
                .where(
                        chargeNameLike(chargeStatus.getName()),
                        chargeIsMembership(chargeStatus.getChargePlaceMembership())
                )
                .orderBy(orderSpecifiers.stream().toArray(OrderSpecifier[]::new))
                .offset(pageable.getOffset())
                .limit(pageable.getPageSize())
                .fetchResults();


        List<Charge> content = results.getResults();
        long total = results.getTotal();

        return new PageImpl<>(content, pageable, total);
    }

    private BooleanExpression chargeNameLike(String name) {
        return isEmpty(name) ? null : charge.name.like("%" + name + "%");
    }

    private BooleanExpression chargeIsMembership(ChargePlaceMembership chargePlaceMembership) {
        return chargePlaceMembership == null ? null : charge.membership.eq(chargePlaceMembership);
    }

}
