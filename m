Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F814AC23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 22:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbfFRUx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 16:53:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbfFRUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J1lCaH4BAVPUd4b+Wn9keMGvzLFd6qySHnI5N2gYXgk=; b=YVaOePEmMHK8V1K2p4V641hfl3
        ++9eyOUFLCrURrPfJR8CnxmXKkWAHkZzE0TAyhfE7RpQs+K5vapvzsCcLYTmgcon7ptgQfntHaQHh
        hBoAooXKFPaAciZNNi1u6MLF8xmPVhVfMTqPcH9XFUIbnluOU6gJRCzOYmWEUtpusVUpZssmoGQpD
        jD+NqS1IIi9esOPzt0UHwYw5OWbK5+RiS8+ekWbGyq3fA8tG9cDWjpYyxrh4j9PbLikE9iKk0PuiM
        rO8zhkfBflHPz4lc3TgAiBr1CciUJ4IQSfNaA+b44rRkq/04dIoz5vIYdrseNrPROYfjLtgimGSZ7
        tgbz/vsQ==;
Received: from 177.133.86.196.dynamic.adsl.gvt.net.br ([177.133.86.196] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdL73-0008NP-Up; Tue, 18 Jun 2019 20:53:54 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hdL70-0001zp-25; Tue, 18 Jun 2019 17:53:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 15/29] docs: phy: convert samsung-usb2.txt to ReST format
Date:   Tue, 18 Jun 2019 17:53:33 -0300
Message-Id: <40e5746fd7107126240929130ce403f7cdc2b9e2.1560890800.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560890800.git.mchehab+samsung@kernel.org>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to merge it into a Sphinx book, we need first to
convert to ReST.

While this is not part of any book, mark it as :orphan:, in order
to avoid build warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../{samsung-usb2.txt => samsung-usb2.rst}    | 62 ++++++++++---------
 MAINTAINERS                                   |  2 +-
 2 files changed, 34 insertions(+), 30 deletions(-)
 rename Documentation/phy/{samsung-usb2.txt => samsung-usb2.rst} (77%)

diff --git a/Documentation/phy/samsung-usb2.txt b/Documentation/phy/samsung-usb2.rst
similarity index 77%
rename from Documentation/phy/samsung-usb2.txt
rename to Documentation/phy/samsung-usb2.rst
index ed12d437189d..98b5952fcb97 100644
--- a/Documentation/phy/samsung-usb2.txt
+++ b/Documentation/phy/samsung-usb2.rst
@@ -1,9 +1,11 @@
-.------------------------------------------------------------------------------+
-|			Samsung USB 2.0 PHY adaptation layer		       |
-+-----------------------------------------------------------------------------+'
+:orphan:
 
-| 1. Description
-+----------------
+====================================
+Samsung USB 2.0 PHY adaptation layer
+====================================
+
+1. Description
+--------------
 
 The architecture of the USB 2.0 PHY module in Samsung SoCs is similar
 among many SoCs. In spite of the similarities it proved difficult to
@@ -14,8 +16,8 @@ the PHY powering up process had to be altered. This adaptation layer is
 a compromise between having separate drivers and having a single driver
 with added support for many special cases.
 
-| 2. Files description
-+----------------------
+2. Files description
+--------------------
 
 - phy-samsung-usb2.c
    This is the main file of the adaptation layer. This file contains
@@ -32,44 +34,45 @@ with added support for many special cases.
    driver. In addition it should contain extern declarations for
    structures that describe particular SoCs.
 
-| 3. Supporting SoCs
-+--------------------
+3. Supporting SoCs
+------------------
 
 To support a new SoC a new file should be added to the drivers/phy
 directory. Each SoC's configuration is stored in an instance of the
-struct samsung_usb2_phy_config.
+struct samsung_usb2_phy_config::
 
-struct samsung_usb2_phy_config {
+  struct samsung_usb2_phy_config {
 	const struct samsung_usb2_common_phy *phys;
 	int (*rate_to_clk)(unsigned long, u32 *);
 	unsigned int num_phys;
 	bool has_mode_switch;
-};
+  };
 
-The num_phys is the number of phys handled by the driver. *phys is an
+The num_phys is the number of phys handled by the driver. `*phys` is an
 array that contains the configuration for each phy. The has_mode_switch
 property is a boolean flag that determines whether the SoC has USB host
 and device on a single pair of pins. If so, a special register has to
 be modified to change the internal routing of these pins between a USB
 device or host module.
 
-For example the configuration for Exynos 4210 is following:
+For example the configuration for Exynos 4210 is following::
 
-const struct samsung_usb2_phy_config exynos4210_usb2_phy_config = {
+  const struct samsung_usb2_phy_config exynos4210_usb2_phy_config = {
 	.has_mode_switch        = 0,
 	.num_phys		= EXYNOS4210_NUM_PHYS,
 	.phys			= exynos4210_phys,
 	.rate_to_clk		= exynos4210_rate_to_clk,
-}
+  }
+
+- `int (*rate_to_clk)(unsigned long, u32 *)`
 
-- int (*rate_to_clk)(unsigned long, u32 *)
 	The rate_to_clk callback is to convert the rate of the clock
 	used as the reference clock for the PHY module to the value
 	that should be written in the hardware register.
 
-The exynos4210_phys configuration array is as follows:
+The exynos4210_phys configuration array is as follows::
 
-static const struct samsung_usb2_common_phy exynos4210_phys[] = {
+  static const struct samsung_usb2_common_phy exynos4210_phys[] = {
 	{
 		.label		= "device",
 		.id		= EXYNOS4210_DEVICE,
@@ -95,29 +98,30 @@ static const struct samsung_usb2_common_phy exynos4210_phys[] = {
 		.power_off	= exynos4210_power_off,
 	},
 	{},
-};
+  };
+
+- `int (*power_on)(struct samsung_usb2_phy_instance *);`
+  `int (*power_off)(struct samsung_usb2_phy_instance *);`
 
-- int (*power_on)(struct samsung_usb2_phy_instance *);
-- int (*power_off)(struct samsung_usb2_phy_instance *);
 	These two callbacks are used to power on and power off the phy
 	by modifying appropriate registers.
 
 Final change to the driver is adding appropriate compatible value to the
 phy-samsung-usb2.c file. In case of Exynos 4210 the following lines were
-added to the struct of_device_id samsung_usb2_phy_of_match[] array:
+added to the struct of_device_id samsung_usb2_phy_of_match[] array::
 
-#ifdef CONFIG_PHY_EXYNOS4210_USB2
+  #ifdef CONFIG_PHY_EXYNOS4210_USB2
 	{
 		.compatible = "samsung,exynos4210-usb2-phy",
 		.data = &exynos4210_usb2_phy_config,
 	},
-#endif
+  #endif
 
 To add further flexibility to the driver the Kconfig file enables to
 include support for selected SoCs in the compiled driver. The Kconfig
-entry for Exynos 4210 is following:
+entry for Exynos 4210 is following::
 
-config PHY_EXYNOS4210_USB2
+  config PHY_EXYNOS4210_USB2
 	bool "Support for Exynos 4210"
 	depends on PHY_SAMSUNG_USB2
 	depends on CPU_EXYNOS4210
@@ -128,8 +132,8 @@ config PHY_EXYNOS4210_USB2
 	  phys are available - device, host, HSCI0 and HSCI1.
 
 The newly created file that supports the new SoC has to be also added to the
-Makefile. In case of Exynos 4210 the added line is following:
+Makefile. In case of Exynos 4210 the added line is following::
 
-obj-$(CONFIG_PHY_EXYNOS4210_USB2)       += phy-exynos4210-usb2.o
+  obj-$(CONFIG_PHY_EXYNOS4210_USB2)       += phy-exynos4210-usb2.o
 
 After completing these steps the support for the new SoC should be ready.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9958d322e355..8941a73880e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13966,7 +13966,7 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/samsung-phy.txt
-F:	Documentation/phy/samsung-usb2.txt
+F:	Documentation/phy/samsung-usb2.rst
 F:	drivers/phy/samsung/phy-exynos4210-usb2.c
 F:	drivers/phy/samsung/phy-exynos4x12-usb2.c
 F:	drivers/phy/samsung/phy-exynos5250-usb2.c
-- 
2.21.0

