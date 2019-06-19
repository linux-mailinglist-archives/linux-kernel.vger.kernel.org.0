Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F384B153
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 07:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfFSF1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 01:27:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32885 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbfFSF1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so9034503pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=suY/vXMO4QTGQwZl4b4hihTIVEb82iVu4ggZaDzsG/eDO8iqQ3LZ31ZXNdlAMGSlge
         v6umLl8wBTpltFmkqIT1WwywnFeKp5GhIoTJce2RtjvJTRL95Le08tm3rkfHDvf8nT1M
         xvJS+YY9b0lsyLJm6SHyVVcz9oNdxpM1yx7aSh2hvimjopBmA4DW1Cntut8JMhHdAX6P
         PPL1zbdz1B9t/HY1Aww05BGUJVVqBwDSr+AOZVXSE2yOG8OvF3blcp7Tz6KGnm1rkFdZ
         FKomMg0EUUp3EKXOFlHaPO8MQ3jC6cN+P+bCTA0IspJykUhKm0yr1lqX77YtFDKPQFc+
         6HOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TKj94I1UJ9U1wimP1ZXUVhx4jFR4v9J2rmetWcqu/jc=;
        b=W6O0/ZdicLvbFvhY0/w7ALTzTloIWkf4ygh0JNUF4SixdLtc4Zunospl+t667xa7dN
         gFoFnHrya1ncKRVo4D3rODfgtXPZpgBkmPjVId4onXUy5sE3cWsrPaaAoXjDh/ApWlfW
         NYgzpOoPn3PkgXfMjL0MawyeGe4iBtd1afgl0lR+F3JgA7zyNo7BojeuaRzD3t+Upt0o
         oSD8cedAbcOZ+aaPEiQnoeMGnBnZL4ZzGQFUudGbFqHw1A7JshUTOivkAUGKYnwZwf42
         fOqFOAhDbcXDxDbwDcCp0gjsB2QPBCoz5yGo3hsXItUAK1DonXGhiH5qN3lCf9uGzfka
         4IaQ==
X-Gm-Message-State: APjAAAXTTUKqkvZhw+FAc45J0TbBx8cNxmNJg4zM3q7jyH9xQNVR5Jkk
        jzfwvxPoEDBBFDoMYsAg7b6G4XsHGss=
X-Google-Smtp-Source: APXvYqw9wK3jCk36OHTZfB+uFDa8ce3rAFNRgzwWwSVLXsIlElg+D1QR6c5WDjf+RkLuF6NhOb+KMQ==
X-Received: by 2002:a63:2258:: with SMTP id t24mr6037843pgm.236.1560922055190;
        Tue, 18 Jun 2019 22:27:35 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:34 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/15] drm/bridge: tc358767: Simplify polling in tc_main_link_setup()
Date:   Tue, 18 Jun 2019 22:27:03 -0700
Message-Id: <20190619052716.16831-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling loop with equivalent call to
tc_poll_timeout() for brevity. No functional change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
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
 drivers/gpu/drm/bridge/tc358767.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index fb8a1942ec54..f463ef6d4271 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -774,7 +774,6 @@ static int tc_main_link_enable(struct tc_data *tc)
 	struct device *dev = tc->dev;
 	unsigned int rate;
 	u32 dp_phy_ctrl;
-	int timeout;
 	u32 value;
 	int ret;
 	u8 tmp[8];
@@ -831,15 +830,10 @@ static int tc_main_link_enable(struct tc_data *tc)
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	tc_write(DP_PHY_CTRL, dp_phy_ctrl);
 
-	timeout = 1000;
-	do {
-		tc_read(DP_PHY_CTRL, &value);
-		udelay(1);
-	} while ((!(value & PHY_RDY)) && (--timeout));
-
-	if (timeout == 0) {
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
+	if (ret) {
 		dev_err(dev, "timeout waiting for phy become ready");
-		return -ETIMEDOUT;
+		return ret;
 	}
 
 	/* Set misc: 8 bits per color */
-- 
2.21.0

