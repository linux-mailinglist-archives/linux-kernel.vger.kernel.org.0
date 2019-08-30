Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6224A3179
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 09:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfH3Hql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 03:46:41 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47747 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbfH3Hqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:46:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B96E7205DD;
        Fri, 30 Aug 2019 03:46:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Aug 2019 03:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=ccb4qfASYNJsR
        kcCGbcB3o9/3lt3kvx57ndPsTCioUU=; b=E8m80fGMIH+S8N6Pd12CHP8Mi6K79
        AyQPJwKb8jFTtbRdtgTjeWull3smJBUNDMyXAXYspV0eeicKoHtAUbXeE8Fy/HPO
        d9SwpItWo7OnkecCkC4VyAgIpGRNqxwltHEgpFtYOXLAzjPgW6mKH9D9CiGDH1BI
        cF/OpeUray34sjRba4iJV4OuiwTMGgaL1tUm/hl9ThvprPSVbx7In2v8LZSyQ5Hk
        hCuUqE0MWxvIYZutlrBoyI1GsiUeht6w37yUWM97tvgM0rBhRew/4hC1FnFvdlrw
        cqOFDKQiRQEfXLj8VGODD7cmhlLoAYk4WF3hpeeAMfV5hPTSyR5NpxScA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ccb4qfASYNJsRkcCGbcB3o9/3lt3kvx57ndPsTCioUU=; b=zxLlQbmT
        QWJ3vE9cvYoCa9WlMmL37M+O7Le9REVQpONgkbVUzPOIYl0HzfChnF2F7JawkjuV
        1Q/tTradg5f2exI4yNOjRMDKFDKCjtXZGe2GkW88t7xuWC0lBEfkN1K/tkBw5Mhu
        g9tTvipqynbFgqIqcHYBJVuIP5cdoqGnPsZfRz4DVaXR9USVD3sofwqV6iI5dnCV
        oo7XWNSFIPv1+vKhQfY7oCBv718cegKesTOrSknT5E6g/ERBBQY1W7tq//4+WURE
        F83Hnaqh872oufgoay0B/l/JwiDfcdOeyCBNF2Tu2kuf/AMhtz7ZGV0PKftsgqi5
        Rc5jgunXd0w3QA==
X-ME-Sender: <xms:XtRoXdCoztIaE-bm9Umb99VL2wb8GR_gBfJq5-kI9eIF4jtoEHTMAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeifedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfies
    rghjrdhiugdrrghuqeenucfkphepvddtfedrheejrddvudehrddujeeknecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:XtRoXfy1jQ6gICTVt4ivGjmly9Ln96hEwLp7xZBrR7ApBDlh1rVgnw>
    <xmx:XtRoXTnR0ZHAfA4lLM3db-JyeW2ERj-y-A9M1kUjLCeePkHqQXUQAA>
    <xmx:XtRoXcFU2vWhAStkhkXUaU4RBQFTeKcIOEJYJlIfiYoUDpMwGwKUOg>
    <xmx:XtRoXULM_gOgWv8WJ67fPT9_C8eIQJQ2UgN17naqRMrNPmIWqFQ1XQ>
Received: from localhost.localdomain (203-57-215-178.dyn.iinet.net.au [203.57.215.178])
        by mail.messagingengine.com (Postfix) with ESMTPA id 043FDD6005F;
        Fri, 30 Aug 2019 03:46:34 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, joel@jms.id.au, ryanchen.aspeed@gmail.com,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-of-aspeed: Uphold clocks-on post-condition of set_clock()
Date:   Fri, 30 Aug 2019 17:16:43 +0930
Message-Id: <20190830074644.10936-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190830074644.10936-1-andrew@aj.id.au>
References: <20190830074644.10936-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early-exit didn't seem to matter on the AST2500, but on the AST2600
the SD clock genuinely may not be running on entry to
aspeed_sdhci_set_clock(). Remove the early exit to ensure we always run
sdhci_enable_clk().

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d5acb5afc50f..a9175ca85696 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -55,9 +55,6 @@ static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	int div;
 	u16 clk;
 
-	if (clock == host->clock)
-		return;
-
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
-- 
2.20.1

