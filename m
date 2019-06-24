Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FDF4FF44
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 04:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfFXCXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 22:23:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35323 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFXCXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:23:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so8809174lfg.2;
        Sun, 23 Jun 2019 19:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjFl+ulNhCjS8NUb8oKur18F5lvVHKIb2XLgee+9s3A=;
        b=g4VPysaRzpSIEpobJlrVIpAGQd6gUjdAYswwLlYaOcK8/974chFNoTXPabC9/6+84V
         C1ZVL2lkoBDHusdQSIxFKRSqEWQFg9SKYajkNaFY7C6zWG7g3rdOma/iUpjBeieA88aM
         /g7ytFSP5gFL2fk6YnfLgwDpR3ewe+1Hgbugy0DJzQu5YdQ6osDQGajvTsGaORtSL7Um
         HPYJr6nv4pjEVEl2EbVQboZtpdklYHJ4HykiOFx1gtqYiwF/F0wmdTxRRf9ox8CHNIgE
         XQvu/+4vhquULgN3nZ/b9Ab3AsYxKJ0+POGmWSk2SZDdeNQ4FuYfYBeCVd8/njRSPl+V
         tJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjFl+ulNhCjS8NUb8oKur18F5lvVHKIb2XLgee+9s3A=;
        b=Mql1pcFHcxnOabk9BOlIqik9m9UlGpbLbXYr6g2c21qWB1SzcSe3N9Fohnu1HWSc+a
         f3WXCNzduLUyOzMMLkEG8ZgVMh93Gw/UvRFNTzctR39MgqPk2M/UaXWwYxDdT/ePrBVs
         H8sok79/pUQxG3/JN+30Ss1Uio1M8m3zD0roBYCwmgy0yhu3UGssi+SX7buFedjHnkwi
         EVwtnHO78ATgCakQoURYKHSeCSan4ct82P9HvZRDRojJMxaCX2EnVNuUu8Tnhh4ZIrv1
         jGixsAsMZYdcNlLmtcfwya2GXrYw20DvYlWTtyC5+7jbS4OJOp+d1ufdLCi/ka19Fqwr
         CKDA==
X-Gm-Message-State: APjAAAUhlyjzf9AAvKnV1b3g/bqg/a6j5JwP/0nzVp57t+nHX3PaeoQV
        8NKUnYb+6o5XHkSFp0vpWs4hK+6n
X-Google-Smtp-Source: APXvYqzDNtSwjrrvWDrL7QOOE6SRyOOzs36pcdK0XpDEaf+GEC1qQl/szXsC9BN2TZM0UjDA0cyOsA==
X-Received: by 2002:ac2:5189:: with SMTP id u9mr7614475lfi.189.1561336324956;
        Sun, 23 Jun 2019 17:32:04 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id y5sm1495146ljj.5.2019.06.23.17.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 17:32:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] memory: tegra: Ensure timing control debug features are disabled
Date:   Mon, 24 Jun 2019 03:31:30 +0300
Message-Id: <20190624003132.29473-9-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624003132.29473-1-digetx@gmail.com>
References: <20190624003132.29473-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timing control debug features should be disabled at a boot time, but you
never now and hence it's better to disable them explicitly because some of
those features are crucial for the driver to do a proper thing.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 3 +++
 drivers/memory/tegra/mc.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index eaebe371625c..4c1492c653e1 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -660,6 +660,9 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	} else
 #endif
 	{
+		/* ensure that debug features are disabled */
+		mc_writel(mc, 0x00000000, MC_TIMING_CONTROL_DBG);
+
 		err = tegra_mc_setup_latency_allowance(mc);
 		if (err < 0) {
 			dev_err(&pdev->dev,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 0720a1d2023e..abc565b42225 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -33,6 +33,8 @@
 #define MC_EMEM_ARB_OVERRIDE				0xe8
 #define MC_EMEM_ARB_OVERRIDE_EACK_MASK			0x3
 
+#define MC_TIMING_CONTROL_DBG				0xf8
+
 #define MC_TIMING_CONTROL				0xfc
 #define MC_TIMING_UPDATE				BIT(0)
 
-- 
2.22.0

