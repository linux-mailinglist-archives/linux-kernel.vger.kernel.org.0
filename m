Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6110CB5E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 09:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfIRHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 03:32:01 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:18807 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbfIRHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:32:00 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x8I7VoOe060926;
        Wed, 18 Sep 2019 15:31:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, marek.vasut@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com
Cc:     marcel.ziswiler@toradex.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, frieder.schrempf@kontron.de,
        gregkh@linuxfoundation.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw, tglx@linutronix.de
Subject: [PATCH RFC 2/3] mtd: rawnand: Add support Macronix Block Protection function
Date:   Wed, 18 Sep 2019 15:56:25 +0800
Message-Id: <1568793387-25199-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
References: <1568793387-25199-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x8I7VoOe060926
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macronix AC series support using SET/GET_FEATURES to change
Block Protection and Unprotection.

MTD default _lock/_unlock function replacement by manufacturer
postponed initialization.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 80 +++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 58511ae..991c636 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -11,6 +11,10 @@
 #define MACRONIX_READ_RETRY_BIT BIT(0)
 #define MACRONIX_NUM_READ_RETRY_MODES 6
 
+#define ONFI_FEATURE_ADDR_MXIC_PROTECTION 0xA0
+#define MXIC_BLOCK_PROTECTION_ALL_LOCK 0x38
+#define MXIC_BLOCK_PROTECTION_ALL_UNLOCK 0x0
+
 struct nand_onfi_vendor_macronix {
 	u8 reserved;
 	u8 reliability_func;
@@ -57,10 +61,7 @@ static void macronix_nand_onfi_init(struct nand_chip *chip)
  * the timings unlike what is declared in the parameter page. Unflag
  * this feature to avoid unnecessary downturns.
  */
-static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
-{
-	unsigned int i;
-	static const char * const broken_get_timings[] = {
+static const char * const broken_get_timings[] = {
 		"MX30LF1G18AC",
 		"MX30LF1G28AC",
 		"MX30LF2G18AC",
@@ -75,7 +76,11 @@ static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
 		"MX30UF4G18AC",
 		"MX30UF4G16AC",
 		"MX30UF4G28AC",
-	};
+};
+
+static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
+{
+	unsigned int i;
 
 	if (!chip->parameters.supports_set_get_features)
 		return;
@@ -105,6 +110,71 @@ static int macronix_nand_init(struct nand_chip *chip)
 	return 0;
 }
 
+static int mxic_nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_LOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("%s all blocks failed\n", __func__);
+
+	return ret;
+}
+
+static int mxic_nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN];
+	int ret;
+
+	feature[0] = MXIC_BLOCK_PROTECTION_ALL_UNLOCK;
+	nand_select_target(chip, 0);
+	ret = nand_set_features(chip, ONFI_FEATURE_ADDR_MXIC_PROTECTION,
+				feature);
+	nand_deselect_target(chip);
+	if (ret)
+		pr_err("%s all blocks failed\n", __func__);
+
+	return ret;
+}
+
+/*
+ * Macronix AC series support using SET/GET_FEATURES to change
+ * Block Protection and Unprotection.
+ *
+ * MTD call-back function replacement by manufacturer postponed
+ * initialization.
+ */
+static void macronix_nand_post_init(struct nand_chip *chip)
+{
+	unsigned int i, blockprotected = 0;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	for (i = 0; i < ARRAY_SIZE(broken_get_timings); i++) {
+		if (!strcmp(broken_get_timings[i], chip->parameters.model)) {
+			blockprotected = 1;
+			break;
+		}
+	}
+
+	if (blockprotected && chip->parameters.supports_set_get_features) {
+		bitmap_set(chip->parameters.set_feature_list,
+			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
+		bitmap_set(chip->parameters.get_feature_list,
+			   ONFI_FEATURE_ADDR_MXIC_PROTECTION, 1);
+
+		mtd->_lock = mxic_nand_lock;
+		mtd->_unlock = mxic_nand_unlock;
+	}
+}
+
 const struct nand_manufacturer_ops macronix_nand_manuf_ops = {
 	.init = macronix_nand_init,
+	.post_init = macronix_nand_post_init,
 };
-- 
1.9.1

