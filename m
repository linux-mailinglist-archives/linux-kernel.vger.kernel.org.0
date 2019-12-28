Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A11C412BF08
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 21:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfL1Ugt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 15:36:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45907 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfL1UgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:36:09 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so22855269lfa.12;
        Sat, 28 Dec 2019 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdP96Dyf/p3F3EB7Y+X1Y5uzvSNakM1XTGFiEhIgPr8=;
        b=sP0I81aNHnh3g9QlugZ6vPbt64O/sDi3yeJJCXRHfcWfO7ipswqDstALpIhWmG6NAu
         M/1g6cL5vLYqXr3FTscMSqsapYGRsPJxaoV8Cr3WyRJ0AFf1mg2bYIfGNH6rrAWMrraz
         F2iGdRAes5EPjnFnsL7mvYkDbDwTkTZSE84TcfH8dzY1j5FBJHYxznI63WOBRUnGR6/F
         rhel+q0e++zlQJVizGgHQStKhIYlnRKkqX4mmpC0qIhOgenLTb6sZZlGT1y07vboNXJC
         K5aUn3hLMU2JDwZMZ5EG2htrwFUBUsjaQbcty/Tf2wB3FfscNiQsfZuw8CsPq6h/HCOr
         I0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdP96Dyf/p3F3EB7Y+X1Y5uzvSNakM1XTGFiEhIgPr8=;
        b=RRJoWUg/4biKotNRBXWOHqpY7JGy4KKejgEXqrVde58XoeVGNSg7EsPBwKL6DXcLGR
         EOaVFMOk4AGKNuJMDdd+ncTyWM019pIdP/jy8PuxvmVoAkhqdyOJXy1A1uCxo6aFDIRN
         rA/NhVSwQ4u201g439LSv90yIBRNs2YCv89pE2iDtLwbmou/+9HmqGnsU7CCU93+Sz4s
         nOOAs4lqhkVPPWfMwa5XFGJxRSjiBU+9rWAEGNvekgqw1vJvssHa7a9fVNP5DN5Gg48E
         MPWxj7IB565376WHwyuEjOkjcKk0MkoilVdlD0F39HaDXFUMuzO2br5I8jOSe/VB3PuW
         KlPQ==
X-Gm-Message-State: APjAAAXehDzu4+ZDbv0H4gyOEod9FXs6G0L88PlIwsXIwrXQCI22CMnq
        4Wyc2rIG/zEDU3xD4YA+seo=
X-Google-Smtp-Source: APXvYqx6JMRM+s3kdHpfaKhELpTsuwsI138fCaPkDt1jAVVUu1FwaMaaWbyYRAnf3qd6UCCu1VL3Zg==
X-Received: by 2002:ac2:54b5:: with SMTP id w21mr32148655lfk.175.1577565366417;
        Sat, 28 Dec 2019 12:36:06 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id d9sm15162614lja.73.2019.12.28.12.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:36:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/16] usb: phy: tegra: Use u32 for hardware register variables
Date:   Sat, 28 Dec 2019 23:33:50 +0300
Message-Id: <20191228203358.23490-9-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191228203358.23490-1-digetx@gmail.com>
References: <20191228203358.23490-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a mix of u32/ULONG usage in the driver's code. Let's switch to
u32 uniformly, for consistency.

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index a3d102f6f81e..0845fc0fb3f8 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -202,7 +202,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
 static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -221,7 +221,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
 static void set_phcd(struct tegra_usb_phy *phy, bool enable)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	if (phy->soc_config->has_hostpc) {
 		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
@@ -320,7 +320,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	err = clk_prepare_enable(phy->pad_clk);
@@ -355,7 +356,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->pad_regs;
-	unsigned long val, flags;
+	unsigned long flags;
+	u32 val;
 	int err;
 
 	if (!utmip_pad_count) {
@@ -393,7 +395,7 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
 static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -425,7 +427,7 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
 static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	/*
 	 * The USB driver may have already initiated the phy clock
@@ -460,7 +462,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	struct tegra_utmip_config *config = phy->config;
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	val = readl_relaxed(base + USB_SUSP_CTRL);
@@ -611,7 +613,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	utmi_phy_clk_disable(phy);
 
@@ -646,7 +648,7 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val |= UTMIP_HS_DISCON_DISABLE;
@@ -656,7 +658,7 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
 static void utmi_phy_postresume(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_TX_CFG0);
 	val &= ~UTMIP_HS_DISCON_DISABLE;
@@ -667,7 +669,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 				   enum tegra_usb_phy_port_speed port_speed)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
@@ -687,7 +689,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
 static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 
 	val = readl_relaxed(base + UTMIP_MISC_CFG0);
 	val &= ~UTMIP_DPDM_OBSERVE;
@@ -698,7 +700,7 @@ static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
 static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
 {
 	void __iomem *base = phy->regs;
-	unsigned long val;
+	u32 val;
 	int err;
 
 	err = gpio_direction_output(phy->reset_gpio, 0);
-- 
2.24.0

