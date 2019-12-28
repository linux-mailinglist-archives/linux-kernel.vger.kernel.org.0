Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC3012BEA0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 20:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfL1TPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 14:15:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39263 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfL1TPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 14:15:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so16352564pfs.6;
        Sat, 28 Dec 2019 11:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xMhSUaoLvbRS73MvzsX7fmmvsEWEBSbzwEx5SJxXjpA=;
        b=P66zAWKVsxghJs+uKX+aAsz486sKeQggR9ZD685ZiiotPHnaImkbarQOzpgBExACAr
         0m+wz7SPPDREENrgJWvRXta8HRU1sgpBWtSZt8ikIWwMkKsHreO1F6PWDIioRYGwYLoO
         3esKe6vV7tEabVVmBOtTywnHK87UkCTjNIUtmRZV78MGCd8E36NmO4+tBZUNsZF/5JGH
         P8kQ0M3M2qX1Nwmk0KoeMbbFPNuSBEqWp/TQGJ478HymFQ/YXGIV7X9t89t0ngoSw90I
         nuxjzkXnFG6bvBRatK6eX0j5ejGnieAEpY3jWrNayVvr1dHhzGTlqT8S227pBDd+K0R4
         meUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xMhSUaoLvbRS73MvzsX7fmmvsEWEBSbzwEx5SJxXjpA=;
        b=tYQTCv91NRz60KR1tfpATJdF4U29uZpNliA5f5bf5iiBe4+nbOlHiC8m70W6n5ZGrP
         wQtTfCOQHTCAa4diEhjczGvawi+VAa1tcJnUvxr+AU2wOMWAAVHC+r+tagg6GXa4sE2B
         mElhD8uAUIEIEoALGXr0FAdP3kQhZdojFI8KWGh7PK6cdjRmAsDmjtDn1OO39WMcDmpa
         JWoa3I8BkQ6v3ZNnLCNlsViMCr8sy3G8UTCT5dZ5Uf3UYFw9o/5aHji0JgogYVoyQJX8
         kq6tv+jDyr85mhuhsRhdFBtEsWdg9MCbPEFPMMaGUTBgDOoCpll4ksp9Jpd9kPINBwZk
         d8Gw==
X-Gm-Message-State: APjAAAVppDtqikl96MCCozJIZqRvTtS3IO6XXFCLzeP7VTEPewtWKLDd
        7YdQs6dsGu8XM88LgNZtJL8=
X-Google-Smtp-Source: APXvYqxB6RVGET87O9fX5SlbjXabkBMlr6aK9Z3y6OEKl6J2YM8VVPP34GRL2M3O5laHsLavAdu6OQ==
X-Received: by 2002:a65:6842:: with SMTP id q2mr63586845pgt.345.1577560543230;
        Sat, 28 Dec 2019 11:15:43 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id d2sm18861017pjo.32.2019.12.28.11.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 11:15:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] hwspinlock: stm32: convert to devm_platform_ioremap_resource
Date:   Sat, 28 Dec 2019 19:15:41 +0000
Message-Id: <20191228191541.26999-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/hwspinlock/stm32_hwspinlock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
index c8eacf4f9692..3ad0ce0da4d9 100644
--- a/drivers/hwspinlock/stm32_hwspinlock.c
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -58,12 +58,10 @@ static int stm32_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct stm32_hwspinlock *hw;
 	void __iomem *io_base;
-	struct resource *res;
 	size_t array_size;
 	int i, ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	io_base = devm_ioremap_resource(&pdev->dev, res);
+	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
 		return PTR_ERR(io_base);
 
-- 
2.17.1

