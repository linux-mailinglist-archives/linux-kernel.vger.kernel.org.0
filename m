Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A63616894C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgBUVZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgBUVZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:20 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53E512467B;
        Fri, 21 Feb 2020 21:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320320;
        bh=8xAYarg9uy/2NeW59dS8nkwZQkKdu+J/VHZxqaJ3p2w=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=rYxtHr/TrebRDj/JKjV2lkzI0mXS/b75130u4TKjeAluUYnmY5AZOqT5nmPhgl0jR
         mMKRJQJfRIvGa8ej+so58SE0NwoB787foVHSlXDjcnlw8oLtPWRhMm9BodcvSVbQs5
         +jwW4um62TBIaDmaXo4sqqK2qDncfeSrpeWFf4A8=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 05/25] i2c: exynos5: Remove IRQF_ONESHOT
Date:   Fri, 21 Feb 2020 15:24:33 -0600
Message-Id: <7094729e455378bb4794f3a118c6ffbf8297b4e2.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 4b217df0ab3f7910c96e42091cc7d9f221d05f01 ]

The drivers sets IRQF_ONESHOT and passes only a primary handler. The IRQ
is masked while the primary is handler is invoked independently of
IRQF_ONESHOT.
With IRQF_ONESHOT the core code will not force-thread the interrupt and
this is probably not intended. I *assume* that the original author copied
the IRQ registration from another driver which passed a primary and
secondary handler and removed the secondary handler but keeping the
ONESHOT flag.

Remove IRQF_ONESHOT.

Reported-by: Benjamin Rouxel <benjamin.rouxel@uva.nl>
Tested-by: Benjamin Rouxel <benjamin.rouxel@uva.nl>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 drivers/i2c/busses/i2c-exynos5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 3855e0b11877..ec490eaac6f7 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -758,9 +758,7 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_irq(&pdev->dev, i2c->irq, exynos5_i2c_irq,
-				IRQF_NO_SUSPEND | IRQF_ONESHOT,
-				dev_name(&pdev->dev), i2c);
-
+			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), i2c);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot request HS-I2C IRQ %d\n", i2c->irq);
 		goto err_clk;
-- 
2.14.1

