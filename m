Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4704128A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfLURaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 12:30:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46170 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:30:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so5450616pll.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2QTmp22i2wQ3tMt0EPE2HLUBg6DWHMOxxV5tEQtCtyw=;
        b=LWDwQaodnDBll0FBmNk5qriQ4tpw2rxB4fhBPFDllIgVhjyV5Gc+BXI0wvtauYhfGq
         VO7gHEZmElJIf4JicgkxZZ5K5YmPnpCge9pgfNTvkXDBuvEvvROFM9kkuYhzKmRcMqcg
         QMFfQPlH1KnMHQa4nYaQoUbx4joK/fjw7MToGRCXaWsO5iaL1lls8+vLduvyJhrzn+pp
         2rajHsytvQItvvv83Hdhr8AgaGRH0FVy9nOQmlzb9/J02bNWBBKuJSsGQ9TrL7oJ9qKF
         u5TnTpQGIGviqbDPu3R1/VAQwKCij6LL8XleKqn/S9+/kJjNRuXYemvqPFstRynBOL2V
         pDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2QTmp22i2wQ3tMt0EPE2HLUBg6DWHMOxxV5tEQtCtyw=;
        b=l8nxd3kgzLUWM4sy12UB91VTEGrHa7r0k5HFSMx3xEhlaasRW0mX89F+0KPqG1LC6B
         swatJW+7n+yTEKS0JJA0z+hWJW3DIbXA9BPoO5tRhnOrT0jtpj7RVMSrYUdz8rQRwp5/
         w8EiBWVA4Y+xHz6jngsjj5Hhy9XFfpa3+jys/UN75JmNGqszpQXBbVk6fiVgYdnDlc4L
         jCKC8fXf2gV1ynpl8qKIQIbtrreLelYr+8HLofmJ56qlc7Vz1D8azr+HybGHaN3RtD2s
         jB5zHK95PNM3pWs/mnJJaYW3ToM8VL3iv/7SL8ustqc+eqxKwXCEvU0nuLL9pXjVUIgS
         WDrw==
X-Gm-Message-State: APjAAAWIriQQ59IlCwrI9z0XO1ad6ibgEjDh/khYaaCis8q6/Tit9YEd
        gWLbvdf3XBcD8HDPF6JrsJc=
X-Google-Smtp-Source: APXvYqyAvBG6emP+FiF1pa5cEkSxjpSAurI1JIXy6jqvgF+zNbfEZsK/Xda5X/RgvkU+QBDkfuSsxg==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr21772538pls.20.1576949437778;
        Sat, 21 Dec 2019 09:30:37 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id j3sm16956369pfi.8.2019.12.21.09.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:30:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 1/4] clocksource: em_sti: convert to devm_platform_ioremap_resource
Date:   Sat, 21 Dec 2019 17:30:24 +0000
Message-Id: <20191221173027.30716-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221173027.30716-1-tiny.windzz@gmail.com>
References: <20191221173027.30716-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code, which
wraps 'platform_get_resource' and 'devm_ioremap_resource' in a
single helper.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clocksource/em_sti.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 9039df4f90e2..086fd5d80b99 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -279,7 +279,6 @@ static void em_sti_register_clockevent(struct em_sti_priv *p)
 static int em_sti_probe(struct platform_device *pdev)
 {
 	struct em_sti_priv *p;
-	struct resource *res;
 	int irq;
 	int ret;
 
@@ -295,8 +294,7 @@ static int em_sti_probe(struct platform_device *pdev)
 		return irq;
 
 	/* map memory, let base point to the STI instance */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	p->base = devm_ioremap_resource(&pdev->dev, res);
+	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-- 
2.17.1

