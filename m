Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62C0130B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 02:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAFBfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jan 2020 20:35:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44953 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgAFBex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so35297459lfa.11;
        Sun, 05 Jan 2020 17:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7IbWzfPhmBnEreIxXsILwKTpjW90RDh/fEgRDfgjeM=;
        b=AmUifnA5XnTZGZZ082fVauHQS8xiNyA7i6Pv7uajYxbnxnD5Nd/i6mX6YGkbtIwSAy
         g02Us0ENuC5NO2XDoeHhVy6rHPqBq7WgoGxgdTHNM1ZmLb0ZxKRywsyxRZN79WuBq6OY
         15Rx3a462oTajjSNG77GEDqaOXN0yAEpsVNksCLDnA3z2U3/m6I1POkqASzaADSg7Osq
         7pH9ue+tml699F1DO/5FKirmHH7794X2y2YNrUNNMosHVfmamo5CThssalTPxqWVP0KI
         IOKSWaww3CSJJuEqkZ+0+abQCZauLESsuEwHRLRtG0cMd6PRx/4CWcx8ycr5abr+LF5j
         uHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7IbWzfPhmBnEreIxXsILwKTpjW90RDh/fEgRDfgjeM=;
        b=XF6NHneZFAo/prJc/Eye9hRwCEvybMnYoCSc2mBWd3DQDpXovgfpb3iUPy/4MnKVtY
         QMQxnb1oEaI871r7l+pPXYa9Bp5AuM63SryVTk6V0QShVY1vtV//Ax18snZe+CoStEmJ
         3Ww4vnoxK0SnuuJ0oAkIWyQMvKD9Mz7aP0ZOuWzwdNMHSefSunKcz4kqfW5KNNw+QOpV
         zw+jzYChh9jQ27zx7/63tT2QEue6Q6SUg2LsjGix5iSbHsEvSM4ikFkKjuZkMwLX9gdI
         sb7F4Ch01ce/CpLdPuLa3BbkFIIyT0HTSjbjRr98ZR4fawJdeBbG82ohqkNWBKjKzJqE
         W1ww==
X-Gm-Message-State: APjAAAUJFpuavxB4BR0kqHaA3YDZRv5no+yjnUA6CzukHuTGk6o0Q4E2
        3l+2Rzu6mMlohx2cVRY1WTE=
X-Google-Smtp-Source: APXvYqw8vdLhoJtuPi+v3NEjMicxcwkIIvTDQv+HHBM9MAUYnVdcQHr7ETJIuDHVYSThN2WhJ7sm8A==
X-Received: by 2002:a19:c697:: with SMTP id w145mr54051507lff.54.1578274490798;
        Sun, 05 Jan 2020 17:34:50 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/20] usb: phy: tegra: Use devm_otg_ulpi_create()
Date:   Mon,  6 Jan 2020 04:34:07 +0300
Message-Id: <20200106013416.9604-12-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resource-managed variant removes the necessity for the driver to care
about freeing ULPI resources.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 5b9f031619c5..9adbcdf8d3a1 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1100,6 +1100,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	enum usb_phy_interface phy_type;
 	struct reset_control *reset;
 	struct resource *res;
+	struct usb_phy *phy;
 	int err;
 
 	tegra_phy = devm_kzalloc(&pdev->dev, sizeof(*tegra_phy), GFP_KERNEL);
@@ -1200,12 +1201,14 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 		}
 
-		tegra_phy->ulpi = otg_ulpi_create(&ulpi_viewport_access_ops, 0);
-		if (!tegra_phy->ulpi) {
+		phy = devm_otg_ulpi_create(&pdev->dev,
+					   &ulpi_viewport_access_ops, 0);
+		if (!phy) {
 			dev_err(&pdev->dev, "Failed to create ULPI OTG\n");
 			return -ENOMEM;
 		}
 
+		tegra_phy->ulpi = phy;
 		tegra_phy->ulpi->io_priv = tegra_phy->regs + ULPI_VIEWPORT;
 		break;
 
@@ -1224,17 +1227,9 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 
 	err = usb_add_phy_dev(&tegra_phy->u_phy);
 	if (err)
-		goto free_ulpi;
+		return err;
 
 	return 0;
-
-free_ulpi:
-	if (tegra_phy->ulpi) {
-		kfree(tegra_phy->ulpi->otg);
-		kfree(tegra_phy->ulpi);
-	}
-
-	return err;
 }
 
 static int tegra_usb_phy_remove(struct platform_device *pdev)
@@ -1243,11 +1238,6 @@ static int tegra_usb_phy_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&tegra_phy->u_phy);
 
-	if (tegra_phy->ulpi) {
-		kfree(tegra_phy->ulpi->otg);
-		kfree(tegra_phy->ulpi);
-	}
-
 	return 0;
 }
 
-- 
2.24.0

