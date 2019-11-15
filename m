Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4335DFE519
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfKOSnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:43:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35664 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKOSnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:43:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id s5so12070226wrw.2;
        Fri, 15 Nov 2019 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=iYDe8W6LdvP9DjVd6RsD4kC6QCPG2iOBqAvsM7kyB60OiQXRjlFCGKm7sLWB/FxO9V
         CgwGMyXZTq9Xgz8sYEWY2nEn8qalf/IQxoujraqnEVco/XiP8p0ujp9fOrvW6n6wz32p
         8wzjaJuoG40z1SLiVg9inXiZhR0l/2NCMb5mI1wk1paN96/j9X58n/3Y6e2BBwY4WeF9
         FaG82siK+7rEkDhwy9kKWajCmTwPzD4/VBwltdVImfWs3SAGHAIqvPgUCsCMdn5Ru6iX
         3h3F/dzzc6MsJxC9F97Vg/KWKO4vxx+kDlRL4UfXNCZF2fOMgMOk9XqdrejhJXiuSjOK
         KDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RT3uMjCTNXctwL3ki3eO315EjLjo+qSfc5PPzuNqLtA=;
        b=gBoWO9mLKoYWkwhDZwZVYtkm5YpTfOLT/BbVzzx9ltNesku2JYpZdmm1CeRqBJWobu
         FrF3sEIAAM90XeEpBawPwfhtWRYZ2jNofqIQCqaP4hxJaX4GG8tb+a+UtWzU5pDAINYM
         Ci0N3JhLv7CiYcGy/0QLHDnO27P0JeqfuNYRKKx8SG8nZpaFaGlJcinSgxpSHmHZUFnN
         JuP5Hf5ANcfqe2LWU+N9n/QJEMCtj+TflVrU9wz/tsyBD+3eLVeLjVanS2dd4C91g9Go
         8P9S7IluiNf63H+vXzwwSPpnBicKHFTIaoQMx+aWw1YbdwzUsLYy+h2/KikuL1nbVHs/
         s8AA==
X-Gm-Message-State: APjAAAVH8qn5JvNyJsBRU6+5nGgHigkwzU3UIGiX64k7i4V3UkLz7/LK
        OMLKOKZchfzZ/0BSH8X1ERuURJ+LPNk=
X-Google-Smtp-Source: APXvYqx1O7NWz3OUqruHqZXfbPWuSF7kLyTjWS2L9IkOwef3woCiL3C8rFG9rh07B5vhajz2ChFeNg==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr16735033wrp.29.1573843429463;
        Fri, 15 Nov 2019 10:43:49 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id g138sm2620989wmg.11.2019.11.15.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 10:43:49 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 09/13] phy: usb: fix driver to defer on clk_get defer
Date:   Fri, 15 Nov 2019 13:42:19 -0500
Message-Id: <20191115184223.41504-10-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115184223.41504-1-alcooperx@gmail.com>
References: <20191115184223.41504-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle defer on clk_get because the new SCMI clock driver comes
up after this driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 5f7bfa09494d..c82d7ec15334 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -341,6 +341,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->usb_20_clk = of_clk_get_by_name(dn, "sw_usb");
 	if (IS_ERR(priv->usb_20_clk)) {
+		if (PTR_ERR(priv->usb_20_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_info(dev, "Clock not found in Device Tree\n");
 		priv->usb_20_clk = NULL;
 	}
@@ -371,6 +373,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 		priv->usb_30_clk = of_clk_get_by_name(dn, "sw_usb3");
 		if (IS_ERR(priv->usb_30_clk)) {
+			if (PTR_ERR(priv->usb_30_clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			dev_info(dev,
 				 "USB3.0 clock not found in Device Tree\n");
 			priv->usb_30_clk = NULL;
@@ -382,6 +386,8 @@ static int brcm_usb_phy_dvr_init(struct platform_device *pdev,
 
 	priv->suspend_clk = clk_get(dev, "usb0_freerun");
 	if (IS_ERR(priv->suspend_clk)) {
+		if (PTR_ERR(priv->suspend_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 		dev_err(dev, "Suspend Clock not found in Device Tree\n");
 		priv->suspend_clk = NULL;
 	}
-- 
2.17.1

