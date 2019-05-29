Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93222D7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfE2IjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 04:39:22 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:33394 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2IjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:39:22 -0400
X-Greylist: delayed 908 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 04:39:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=VizZIOSYyTUJLioFyx
        PymTPM95wmzjKyh7sAkeKcjRQ=; b=Etlk5mfgxnnxso3YgP+V7ewCwqr8n96Tcj
        WkkV6ZQQDJAt9j7smYMJWOGqTDGN5HHmnQXYforO+YEuitoyBTYS48Y0vT9hhlrJ
        A3s6SZgoTAs5phHWrB3dyNjhdQQja7gqxV3Wshjsq7FIUEvIYNq+kbqKcldUL/oo
        lRHzmy6T8=
Received: from localhost.localdomain (unknown [218.106.182.173])
        by smtp18 (Coremail) with SMTP id HNxpCgCXMtmIQe5c3OOhAA--.380S3;
        Wed, 29 May 2019 16:23:41 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Xidong Wang <wangxidong_97@163.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] clocksource/drivers/integrator: check return value
Date:   Wed, 29 May 2019 16:23:28 +0800
Message-Id: <1559118208-28049-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgCXMtmIQe5c3OOhAA--.380S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyDtryrWF4rCw43Gw1xZrb_yoWDurc_WF
        s2gryfJr9Y934xArZxC3W2qr929rs7uFyFgFW0yFZxCa47XF1rury7XwnrCrWxXwsrKFy7
        C3yDCr47AF43GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR4SrUUUUUU==
X-Originating-IP: [218.106.182.173]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbivg3D81ZcV9i4GgAAsk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In integrator_ap_timer_init_of(), the return value of
clk_prepare_enable() should be checked before clk is used.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/clocksource/timer-integrator-ap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 19fb7de..72d5bdc 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -177,6 +177,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 {
 	const char *path;
 	void __iomem *base;
+	int ret;
 	int err;
 	int irq;
 	struct clk *clk;
@@ -192,7 +193,10 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		pr_err("No clock for %pOFn\n", node);
 		return PTR_ERR(clk);
 	}
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		return ret;
+	}
 	rate = clk_get_rate(clk);
 	writel(0, base + TIMER_CTRL);
 
-- 
2.7.4

