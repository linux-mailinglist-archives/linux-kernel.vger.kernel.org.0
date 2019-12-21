Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB82F128A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Dec 2019 18:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfLURas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Dec 2019 12:30:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43771 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLURar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:30:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so5894445pfo.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Dec 2019 09:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CDLG2jUFJguahmmp2OuwclzZZpUe8qytlOBamjJpTes=;
        b=QlRfCfRrfIdwQytUgdqjA5bsR02ctE//ijxzL0ansJNhOiItKFt5COuY2EKcu2K+wH
         boHBUEpueSyTQ0DfmAXKZf5cgzY3HWMzUWrhYh++giabGwfRGefZA81mC3hqQaNjmrFD
         KY/PMO0gjxqyM2D4wI1GwFc/rtOns7ibDvbm8fL5Zem6CKvWTjsO7EdXcw6LiQgeBXDa
         h5XGRMPcr1w93IP/gxqhDuBc6I1y/b1eN8PQIxlmOvCUjWElkIWk2PcPQO/CEgq86xDL
         wjpIRxd9+BaJOkuZKiX1rQ8muLZwRYAoVVS0EzuleyzjpiaHUG0O+M8hL4mDVhs2wLwM
         IULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CDLG2jUFJguahmmp2OuwclzZZpUe8qytlOBamjJpTes=;
        b=tEOpRI8BWjibybA6sn2pyX0iX4ZTs0wlPV+vdFNvHehfVh3CZqEcK19Put8lSs1CCr
         WDqLQoOkHfUrwGYH80OeGojm1PGR45RL2KSqRDfMjHR3WMv+P5mnySCloaYjsRkwbKLm
         vTOeA0b0OckXhzLaNUNNUksgAVbMK9XEBYf90yatKFC6F6J+E3PxJ+sZRgNqonZXe7FN
         Ii5Bm7cI4/OUMcUU1GFkb/7QFDeQDZuquS9dAYIje8t8sNr2NfgmKZ+DqvCzAUmDtjSk
         A3QyTt5MJZPyyjdXPZ0w8Jg9OUHU+jzUsm9SQT7biA2/v/PlI6fdD7aaxbAv+FHe7QQS
         9xFw==
X-Gm-Message-State: APjAAAWrvg94ytjvVqVp8a8llo8VbiLG7UlRnLhSDD+ZuTHRaY8tXve5
        ABX2gs/AQk1F0hICR1cJq9o=
X-Google-Smtp-Source: APXvYqxDNl/7eiaH/a9r1GwLvVWc+F4Cf1nl54DlpIMykIn5xgDuayCxV/HGtPfzgyelajyvowSGbA==
X-Received: by 2002:a63:5d4d:: with SMTP id o13mr21329576pgm.182.1576949446106;
        Sat, 21 Dec 2019 09:30:46 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id b185sm1051348pfa.102.2019.12.21.09.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2019 09:30:45 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 3/4] clocksource: timer-ti-dm: convert to devm_platform_ioremap_resource
Date:   Sat, 21 Dec 2019 17:30:26 +0000
Message-Id: <20191221173027.30716-4-tiny.windzz@gmail.com>
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
 drivers/clocksource/timer-ti-dm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5394d9dbdfbc..aa2ede266edf 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -780,7 +780,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 {
 	unsigned long flags;
 	struct omap_dm_timer *timer;
-	struct resource *mem, *irq;
+	struct resource *irq;
 	struct device *dev = &pdev->dev;
 	const struct dmtimer_platform_data *pdata;
 	int ret;
@@ -802,18 +802,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (unlikely(!mem)) {
-		dev_err(dev, "%s: no memory resource.\n", __func__);
-		return -ENODEV;
-	}
-
 	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
 	if (!timer)
 		return  -ENOMEM;
 
 	timer->fclk = ERR_PTR(-ENODEV);
-	timer->io_base = devm_ioremap_resource(dev, mem);
+	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
-- 
2.17.1

