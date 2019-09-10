Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F4AF015
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437000AbfIJRAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 13:00:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45623 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436774AbfIJRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:00:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so11853251pfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bikh9UsnUjpSQW/IwIHKeMJrzrZCC/io4Z8+rlW60FQ=;
        b=ASKKRpS+Xw0+wSO11wEtYMt/nJXjbgkKYdD8m+ELFl/hVxvk3+vxZJbEiXBtKfQ168
         eA4Pg1QI2hhtruxSUaWfPPNNBzcdMLfLWWqWbLXiqP0Sw7q8Wpnz0YZ1WjunRk/TU8SK
         cPwG9MBzL4bZpAK//iN5fdcDOmWgx7DjEZmIzbz/Z2x9YKE0ozHmofiIrlCsiLlvgFKL
         MTqZRDB+KbP6QBP7rUgX+U7zH2PqPEnK2Abk9Aj94OFj94c22gN1Ftg14ue/NzbJcOzL
         JIsztp76FmsVuZ7C7qzR2L4hhkvAFC+4d3SLHYjbpnHLcWuw3kOK426YLLX2DTn5BSwn
         EISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bikh9UsnUjpSQW/IwIHKeMJrzrZCC/io4Z8+rlW60FQ=;
        b=GdcbUD8+K7U073Q1Zaa5Jxz92+gXbtzYnFaOiBZA4RSAb4dTSr1jOzfEfh0Xf03UkF
         xaQocCWApu5Iql17YObkRu7zPuu8u7FECPMRnIBC1pWQci/zObNzRtFgjJJjBEb/gqmt
         UQYo+aXPG+DI0Kr882AtDBIBfNaB5HNi2bPe72VyWcHDKw1E9QAdSmPNHJ7McEo+aZjI
         /nVUg012tGcbDm1bUqUAh98l2qAwgvFlwuWX1eLwnwO7mzXb+eI5DOAiSlmF/K7ICzhi
         B8Uj3C6DD2GWspnX5grdYxLAOr4gnJfPijsWvmwc9npHTju0LQvt0yIrJC6iKdMUGpgt
         Q0SA==
X-Gm-Message-State: APjAAAUO7PXm79pN26TLTfgsVe5eZVgErxRtd9vk71ykf64iFv6f/S3/
        uw2yVJHb7acaQeEHGeFuqrk=
X-Google-Smtp-Source: APXvYqzkse/be4istMmH3NU8sEFn+6IMjToQQl9oYLfyZ+w6E6klPxmUcDbSA19U12g0elwRBseAXQ==
X-Received: by 2002:a63:fb14:: with SMTP id o20mr28533944pgh.136.1568134853360;
        Tue, 10 Sep 2019 10:00:53 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id x10sm23768355pfr.44.2019.09.10.10.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 10:00:52 -0700 (PDT)
Date:   Tue, 10 Sep 2019 10:00:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max77686: fix obtaining "maxim,ena" GPIO
Message-ID: <20190910170050.GA55530@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes 96392c3d8ca4, as devm_gpiod_get_from_of_node() does
not do translation "con-id" -> "con-id-gpios" that our bindings expects,
and therefore it was wrong to change connection ID to be simply
"maxim,ena" when moving to using devm_gpiod_get_from_of_node().

Fixes: 96392c3d8ca4 ("regulator: max77686: Pass descriptor instead of GPIO number")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/regulator/max77686-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index 8020eb57374a..c8e579e99316 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -257,7 +257,7 @@ static int max77686_of_parse_cb(struct device_node *np,
 	case MAX77686_BUCK9:
 	case MAX77686_LDO20 ... MAX77686_LDO22:
 		config->ena_gpiod = gpiod_get_from_of_node(np,
-				"maxim,ena",
+				"maxim,ena-gpios",
 				0,
 				GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE,
 				"max77686-regulator");
-- 
2.23.0.162.g0b9fbb3734-goog


-- 
Dmitry
