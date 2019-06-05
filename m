Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D3735760
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFEHFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 03:05:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42846 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfFEHFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 03:05:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so4080152pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFvuIRi7rsk2TFp/SSh+b+ezX83xyjP/0LBIMVGRR1U=;
        b=Y8ygajd/pjZ28xsj4PsaLG4FFFLwbaEUuRrDRgc4vDF7ppGFNWbPFagSK4DqAMuUu5
         /J2cc4UsilVprscnxjgKd6fxkcYXAiPUiM56qskqgpo0/aSUZMKmK2EjkM7KVWMoeLot
         TZ7N8EoHd2L6MCi7KCXKnusi7HD+v+8JyjGlNjx4z9GiuL530XkqO9obPthSurPEBvMO
         fl5lhqy+ya6nwz/hAKr4ORU3NRIPUzf9L7f3k4CkPhqR7T4nKNZPr8JYG3Y+cdqEuwjg
         afR5FTISTBTeYhf/UtpUBCTyvseuCopW25sEeLcMON22zcbahZLzTyqTElCzxRG66v2h
         Lobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFvuIRi7rsk2TFp/SSh+b+ezX83xyjP/0LBIMVGRR1U=;
        b=SwV+mCRMivXn/E7XUaQY0KgvL4bK6MOqDnqijGRGFKRXHqoSQW42ecgb+qp3q6d623
         0G/lpaZ413pKgHntVg4VWSdtPxKBnW/LW26iA/0kgCMRVkiR0cezNT5Q66pPrLQK8SrI
         GZ4T76gpnGJ4Pt4hDCTuhnvYwPZCHwElBrJaBk/jDim2p2I/rT/pqqwWZiwB8H/t8pND
         N+9spNstQyHkdL9dgnte+xOI2nEpylKuvs2Rc0y/geS4EN0VMBNqt8u7p9V24zW2NLCW
         2UiiofXG+PylgBrp9/3pk2jNuBOUP8CXZrGTdWcWldI5z5QPY5/TgM0VPODMtoTkCYRf
         qkRA==
X-Gm-Message-State: APjAAAXPf2XAJgfC1anEc6wYLDJ3wjCNQx4a/TCxcyCJ81mnkBfLFuu4
        SzE3rBdSwX2c2QLcQyGBFPY=
X-Google-Smtp-Source: APXvYqyC0jx/q6tG1m6BADcPh6aQ2BVId4Gl6G3bZIAJ8W2OBXOSwnX7Pbxe8TFCZEK2BpS0Tq2X+A==
X-Received: by 2002:a17:90a:b104:: with SMTP id z4mr20745515pjq.102.1559718341700;
        Wed, 05 Jun 2019 00:05:41 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d132sm6527348pfd.61.2019.06.05.00.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 00:05:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/15] drm/bridge: tc358767: Introduce tc_pllupdate_pllen()
Date:   Wed,  5 Jun 2019 00:05:04 -0700
Message-Id: <20190605070507.11417-13-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605070507.11417-1-andrew.smirnov@gmail.com>
References: <20190605070507.11417-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tc_wait_pll_lock() is always called as a follow-up for updating
PLLUPDATE and PLLEN bit of a given PLL control register. To simplify
things, merge the two operation into a single helper function
tc_pllupdate_pllen() and convert the rest of the code to use it. No
functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index c58714daa0a1..a04401cf2a92 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -463,10 +463,18 @@ static u32 tc_srcctrl(struct tc_data *tc)
 	return reg;
 }
 
-static void tc_wait_pll_lock(struct tc_data *tc)
+static int tc_pllupdate_pllen(struct tc_data *tc, unsigned int pllctrl)
 {
+	int ret;
+
+	ret = regmap_write(tc->regmap, pllctrl, PLLUPDATE | PLLEN);
+	if (ret)
+		return ret;
+
 	/* Wait for PLL to lock: up to 2.09 ms, depending on refclk */
 	usleep_range(3000, 6000);
+
+	return 0;
 }
 
 static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
@@ -566,13 +574,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
 		return ret;
 
 	/* Force PLL parameter update and disable bypass */
-	ret = regmap_write(tc->regmap, PXL_PLLCTRL, PLLUPDATE | PLLEN);
-	if (ret)
-		return ret;
-
-	tc_wait_pll_lock(tc);
-
-	return 0;
+	return tc_pllupdate_pllen(tc, PXL_PLLCTRL);
 }
 
 static int tc_pxl_pll_dis(struct tc_data *tc)
@@ -645,15 +647,13 @@ static int tc_aux_link_setup(struct tc_data *tc)
 	 * Initially PLLs are in bypass. Force PLL parameter update,
 	 * disable PLL bypass, enable PLL
 	 */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
 	if (ret)
 		goto err;
-	tc_wait_pll_lock(tc);
 
 	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
 	if (ret == -ETIMEDOUT) {
@@ -933,15 +933,13 @@ static int tc_main_link_enable(struct tc_data *tc)
 		return ret;
 
 	/* PLL setup */
-	ret = regmap_write(tc->regmap, DP0_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP0_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
-	ret = regmap_write(tc->regmap, DP1_PLLCTRL, PLLUPDATE | PLLEN);
+	ret = tc_pllupdate_pllen(tc, DP1_PLLCTRL);
 	if (ret)
 		return ret;
-	tc_wait_pll_lock(tc);
 
 	/* Reset/Enable Main Links */
 	dp_phy_ctrl |= DP_PHY_RST | PHY_M1_RST | PHY_M0_RST;
-- 
2.21.0

