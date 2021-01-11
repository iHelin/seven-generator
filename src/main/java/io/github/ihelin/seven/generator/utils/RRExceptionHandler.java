package io.github.ihelin.seven.generator.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 异常处理器
 *
 * @author iHelin ihelin@outlook.com
 * @since 2021-01-07 12:43
 */
@RestControllerAdvice(basePackages = "io.github.ihelin.seven.generator.controller")
public class RRExceptionHandler {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    @ExceptionHandler(value = Throwable.class)
    public R handleException(Throwable throwable) {
        R r = new R();
        if (throwable instanceof RRException) {
            r.put("code", ((RRException) throwable).getCode());
            r.put("msg", throwable.getMessage());
        } else if (throwable instanceof DuplicateKeyException) {
            r = R.error("数据库中已存在该记录");
        } else {
            r = R.error();
        }
        //记录异常日志
        logger.error("系统异常", throwable);
        return r;
    }
}
