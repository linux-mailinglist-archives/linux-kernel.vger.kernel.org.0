Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D89165378
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 01:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgBTAUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 19:20:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35611 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgBTAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:20:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so799184plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jTaHDD+09W3xPLB5zxqrZcfKt5xjlZG4YPPLRu8eAo=;
        b=b1XelOjvj05D0Bwh2OQjpR9HZva2lUVZkRpxeC9Q98tZq8EZ4K9eDHdlUPwmiOOop8
         QkMHi2N81LsFtlBSeEFLuFw3VZUe+PpiUS4er8PSCtS5Tt8WBr3C2D2/RiSBm/RQ/aId
         920+6K4rD3kfJybAs0JO6Bag2lo7zANivnhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/jTaHDD+09W3xPLB5zxqrZcfKt5xjlZG4YPPLRu8eAo=;
        b=WFrg0g25/IEdoWVs8KREXptPThc9NJuI36BiD+JOM+5vY/35q9Dx8ruYSmnB1V/Gb6
         ocT+XCmgv1nO/DMYZgy0aFGbc+B0DJqHca6lpPX7oAlVBYapuBrbj7x6FG6OEHXWU3sL
         jdy+9z4t7THNmfg96GZUnEocK9gg1y/VgF3LXjkbKet7iFuShZrQbNPyvr3tfZlDf29B
         lgPV742NzIomZNNxNm4RlZjMMvkmGTI/LTge9ZkLJQ+ouspnPnD5pOAT4fGrKx4gcwrf
         hzKNhzkmbG1NO8YHr5vLB+hEkTkYx96hTbtmiTWaNSJ1wcXB1flgDAGe+sszgX2XVF/6
         FBug==
X-Gm-Message-State: APjAAAXF6tue2PZOA/Hpqy377VIIHOOBjtkQ9rDcST8s1ODgtVLyBmtx
        1reV5cm+SNZEbduIasnuTsWUJg==
X-Google-Smtp-Source: APXvYqxZJROEl7Go9mJ14zcRqIEZy8MOQhYz52cxdH9LK3/ms/0tqs13Hch4RiI8ug3rWwZp182Wog==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr28045532plb.24.1582158048735;
        Wed, 19 Feb 2020 16:20:48 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g21sm804731pfb.126.2020.02.19.16.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:20:48 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] watchdog: qcom: Use irq flags from firmware
Date:   Wed, 19 Feb 2020 16:20:47 -0800
Message-Id: <20200220002047.115000-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT or ACPI tables should tell the driver what the irq flags are.
Given that this driver probes only on DT based platforms and those DT
platforms specify the irq flags we can safely drop the forced irq flag
setting here.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/watchdog/qcom-wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index eb47fe5ed280..c70e89013101 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -248,8 +248,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	/* check if there is pretimeout support */
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq > 0) {
-		ret = devm_request_irq(dev, irq, qcom_wdt_isr,
-				       IRQF_TRIGGER_RISING,
+		ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
 				       "wdt_bark", &wdt->wdd);
 		if (ret)
 			return ret;
-- 
Sent by a computer, using git, on the internet

