Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3006364B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 14:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGIM63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 08:58:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:58:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69CwBk41920782
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 05:58:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69CwBk41920782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562677092;
        bh=CD6Y4OFGUWp/bG1/hPiAbqcU/PTvaJHpU4bQW4hpAS8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=w8YPvVsom4qfeNk+kMAsjUSd3uE9LpumFvkGO7nkBHnfKE78ukVlZ8swd8qNGdKds
         4YG83WMXeIXJLdme2d1TG7FErRUXVlWYmRuj1IHaOf7i0ddKCu7YRHvfFxCPzI7d6Z
         JBBmx8NKTv/t34NHgBa8iohebnzlyNmbHawTa3mLdTmwC8r3KamABw8yDSz5V+TNQb
         QE+r4nMyzWV8egEAFWYS0yTG7KPOmt6x9IwhSW49B+leMN/7CxKQAR4Xi5kjuCyuar
         nQQKjHpekGD+chk1IzKTEqU1bu0H8gJ/51mwYxIKMCY2wFwpkASkujnBHrSrszAc2M
         Km4kN6iVo6ieg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69Cw9Pu1920776;
        Tue, 9 Jul 2019 05:58:09 -0700
Date:   Tue, 9 Jul 2019 05:58:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wen Yang <tipbot@zytor.com>
Message-ID: <tip-7c8e90ddf02f139a90bc29c04302e9914818f0c8@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, wen.yang99@zte.com.cn,
        mingo@kernel.org, geert+renesas@glider.be, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, wen.yang99@zte.com.cn,
          linux-kernel@vger.kernel.org, geert+renesas@glider.be,
          tglx@linutronix.de
In-Reply-To: <1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn>
References: <1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/renesas-rza1: Prevent use-after-free in
 rza1_irqc_probe()
Git-Commit-ID: 7c8e90ddf02f139a90bc29c04302e9914818f0c8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7c8e90ddf02f139a90bc29c04302e9914818f0c8
Gitweb:     https://git.kernel.org/tip/7c8e90ddf02f139a90bc29c04302e9914818f0c8
Author:     Wen Yang <wen.yang99@zte.com.cn>
AuthorDate: Mon, 8 Jul 2019 14:19:04 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Jul 2019 14:53:50 +0200

irqchip/renesas-rza1: Prevent use-after-free in rza1_irqc_probe()

The gic_node is still being used in the rza1_irqc_parse_map() call
after the of_node_put() call, which may result in use-after-free.

Fixes: a644ccb819bc ("irqchip: Add Renesas RZ/A1 Interrupt Controller driver")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lkml.kernel.org/r/1562566745-7447-3-git-send-email-wen.yang99@zte.com.cn
---
 drivers/irqchip/irq-renesas-rza1.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index b1f19b210190..b0d46ac42b89 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -208,20 +208,19 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	gic_node = of_irq_find_parent(np);
-	if (gic_node) {
+	if (gic_node)
 		parent = irq_find_host(gic_node);
-		of_node_put(gic_node);
-	}
 
 	if (!parent) {
 		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_put_node;
 	}
 
 	ret = rza1_irqc_parse_map(priv, gic_node);
 	if (ret) {
 		dev_err(dev, "cannot parse %s: %d\n", "interrupt-map", ret);
-		return ret;
+		goto out_put_node;
 	}
 
 	priv->chip.name = "rza1-irqc",
@@ -237,10 +236,12 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 						    priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(gic_node);
+	return ret;
 }
 
 static int rza1_irqc_remove(struct platform_device *pdev)
