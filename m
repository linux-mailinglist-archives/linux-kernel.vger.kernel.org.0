Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF73BCC506
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 23:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfJDVnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 17:43:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32943 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730947AbfJDVnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so4510674pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4laGYk6kNzn8ggwZvF8ju207Nsdwdem3C56p/DpFJ3U=;
        b=l2eJdqZcJgLnDMBk7KvcITQUW/7MqjOc3WuPFqGdj5gEgT/7bhTh6bMSoK7mODWk7A
         WAuFtOYzqwZwuLflgZmp2IUwkkBLhrgTG33hA4SQqqM1fU12wyaVXF7mwmY1RwF4vHZ9
         Pw0o60gUDPfwIVD3tbfd2VuruIuJJCrTkI+/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4laGYk6kNzn8ggwZvF8ju207Nsdwdem3C56p/DpFJ3U=;
        b=fETFJceEdBpKMT3z9FE92SRaMrDRxXvy1fSf80rMya+Annr1wJRuT4afykOCYj9Ng+
         w7X/IDXk5MNc+3raiePpIVrQypzjtPwiclrsCmYk5v4OLW276GLGo4pMwI4hiUy9lVdr
         ZZOq852WLGslLQm7qD/qye9nroBIeIBwy6yxUx88wZReY5uMZwrVkiyKk469TecQLARQ
         5pHFfFWrIBDAaHWNQC318OPn52KCXTCAFO91Drp0TudfFfFv1OIJ3L9LsY4e/gdGFyal
         fFPIqZbv8vxCN1BrgnlkhKQ0nomiM4CVYWuePmmxpsDdba56iCkDrQF+EmrByE+ZU3Yn
         99mA==
X-Gm-Message-State: APjAAAV9LxnF3l00n3qxkfxjlcias2vb9jQQy6ijA/lFcF57Z4/zgTNV
        7OHKk889Snuu2Wev2jKjkO9jBrBVGdo=
X-Google-Smtp-Source: APXvYqzmnwOeITbb1UwBBpTnEmTSF22BpTx1tKltkPKfcs3uJBHD64v05RXG4u/rna6qhT7+4hLo4Q==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr19144840pjq.18.1570225420159;
        Fri, 04 Oct 2019 14:43:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:39 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH 04/10] drivers: net: davinci_mdio: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:28 -0700
Message-Id: <20191004214334.149976-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more modern API to get the match data out of the of match table.
This saves some code, lines, and nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-omap@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 drivers/net/ethernet/ti/davinci_mdio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 38b7f6d35759..f78f7409df0c 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -358,20 +358,16 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-		const struct of_device_id	*of_id;
+		const struct davinci_mdio_of_param *of_mdio_data;
 
 		ret = davinci_mdio_probe_dt(&data->pdata, pdev);
 		if (ret)
 			return ret;
 		snprintf(data->bus->id, MII_BUS_ID_SIZE, "%s", pdev->name);
 
-		of_id = of_match_device(davinci_mdio_of_mtable, &pdev->dev);
-		if (of_id) {
-			const struct davinci_mdio_of_param *of_mdio_data;
-
-			of_mdio_data = of_id->data;
-			if (of_mdio_data)
-				autosuspend_delay_ms =
+		of_mdio_data = of_device_get_match_data(&pdev->dev);
+		if (of_mdio_data) {
+			autosuspend_delay_ms =
 					of_mdio_data->autosuspend_delay_ms;
 		}
 	} else {
-- 
Sent by a computer through tubes

