Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD9A6635A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfGLB13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 21:27:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbfGLB13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 21:27:29 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3632CB191B82375CC4EC;
        Fri, 12 Jul 2019 09:27:26 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 12 Jul 2019 09:27:18 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <kishon@ti.com>
CC:     <prime.zeng@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] phy: Change the configuration interface param to void* to make it more general
Date:   Fri, 12 Jul 2019 17:26:04 +0800
Message-ID: <1562923580-47746-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy framework now allows runtime configurations, but only limited
to mipi now, and it's not reasonable to introduce user specified
configurations into the union phy_configure_opts structure. An simple
way is to replace with a void *.

We have already got some phy drivers which introduce private phy API
for runtime configurations, and with this patch, they can switch to
the phy_configure as a replace.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c |  4 ++--
 drivers/phy/cadence/cdns-dphy.c             |  8 ++++----
 drivers/phy/phy-core.c                      |  4 ++--
 include/linux/phy/phy.h                     | 24 ++++++------------------
 4 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index 79c8af5..6a60473 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -105,12 +105,12 @@ static int sun6i_dphy_init(struct phy *phy)
 	return 0;
 }
 
-static int sun6i_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+static int sun6i_dphy_configure(struct phy *phy, void *opts)
 {
 	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
 	int ret;
 
-	ret = phy_mipi_dphy_config_validate(&opts->mipi_dphy);
+	ret = phy_mipi_dphy_config_validate(opts);
 	if (ret)
 		return ret;
 
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 90c4e9b..0ec5013 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -233,23 +233,23 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 }
 
 static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
-			      union phy_configure_opts *opts)
+			      void *opts)
 {
 	struct cdns_dphy_cfg cfg = { 0 };
 
 	if (mode != PHY_MODE_MIPI_DPHY)
 		return -EINVAL;
 
-	return cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
+	return cdns_dphy_config_from_opts(phy, opts, &cfg);
 }
 
-static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
+static int cdns_dphy_configure(struct phy *phy, void *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
 	struct cdns_dphy_cfg cfg = { 0 };
 	int ret;
 
-	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
+	ret = cdns_dphy_config_from_opts(phy, opts, &cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index e3880c4a1..048d4d6 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -420,7 +420,7 @@ EXPORT_SYMBOL_GPL(phy_calibrate);
  *
  * Returns: 0 if successful, an negative error code otherwise
  */
-int phy_configure(struct phy *phy, union phy_configure_opts *opts)
+int phy_configure(struct phy *phy, void *opts)
 {
 	int ret;
 
@@ -455,7 +455,7 @@ EXPORT_SYMBOL_GPL(phy_configure);
  * Returns: 0 if successful, an negative error code otherwise
  */
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
-		 union phy_configure_opts *opts)
+		 void *opts)
 {
 	int ret;
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 15032f14..8948f94 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -16,8 +16,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
-#include <linux/phy/phy-mipi-dphy.h>
-
 struct phy;
 
 enum phy_mode {
@@ -41,15 +39,6 @@ enum phy_mode {
 	PHY_MODE_SATA
 };
 
-/**
- * union phy_configure_opts - Opaque generic phy configuration
- *
- * @mipi_dphy:	Configuration set applicable for phys supporting
- *		the MIPI_DPHY phy mode.
- */
-union phy_configure_opts {
-	struct phy_configure_opts_mipi_dphy	mipi_dphy;
-};
 
 /**
  * struct phy_ops - set of function pointers for performing phy operations
@@ -80,7 +69,7 @@ struct phy_ops {
 	 *
 	 * Returns: 0 if successful, an negative error code otherwise
 	 */
-	int	(*configure)(struct phy *phy, union phy_configure_opts *opts);
+	int	(*configure)(struct phy *phy, void *opts);
 
 	/**
 	 * @validate:
@@ -99,7 +88,7 @@ struct phy_ops {
 	 * error code otherwise
 	 */
 	int	(*validate)(struct phy *phy, enum phy_mode mode, int submode,
-			    union phy_configure_opts *opts);
+			    void *opts);
 	int	(*reset)(struct phy *phy);
 	int	(*calibrate)(struct phy *phy);
 	void	(*release)(struct phy *phy);
@@ -207,9 +196,9 @@ int phy_power_off(struct phy *phy);
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
 #define phy_set_mode(phy, mode) \
 	phy_set_mode_ext(phy, mode, 0)
-int phy_configure(struct phy *phy, union phy_configure_opts *opts);
+int phy_configure(struct phy *phy, void *opts);
 int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
-		 union phy_configure_opts *opts);
+		 void *opts);
 
 static inline enum phy_mode phy_get_mode(struct phy *phy)
 {
@@ -354,8 +343,7 @@ static inline int phy_calibrate(struct phy *phy)
 	return -ENOSYS;
 }
 
-static inline int phy_configure(struct phy *phy,
-				union phy_configure_opts *opts)
+static inline int phy_configure(struct phy *phy, void *opts)
 {
 	if (!phy)
 		return 0;
@@ -364,7 +352,7 @@ static inline int phy_configure(struct phy *phy,
 }
 
 static inline int phy_validate(struct phy *phy, enum phy_mode mode, int submode,
-			       union phy_configure_opts *opts)
+			       void *opts)
 {
 	if (!phy)
 		return 0;
-- 
2.7.4

