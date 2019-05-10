Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A16B198E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEJHT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 03:19:27 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:13087 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfEJHT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:19:26 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x4A7JHt6076937;
        Fri, 10 May 2019 15:19:17 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     bbrezillon@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     juliensu@mxic.com.tw, masonccyang@mxic.com.tw
Subject: [PATCH v1] mtd: rawnand: Add Macronix NAND read retry support
Date:   Fri, 10 May 2019 15:41:02 +0800
Message-Id: <1557474062-4949-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com x4A7JHt6076937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Macronix NAND read retry.

Macronix NAND supports specfical read for data recovery and enabled
it by Set Feature.
Driver check byte 167 of Vendor Blocks in ONFI parameter page table
to see if this high reliability function is support or not.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/nand/raw/nand_macronix.c | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_macronix.c b/drivers/mtd/nand/raw/nand_macronix.c
index 47d8cda..5cd1e5f 100644
--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -17,6 +17,57 @@
 
 #include "internals.h"
 
+#define MACRONIX_READ_RETRY_BIT BIT(0)
+#define MACRONIX_READ_RETRY_MODE 5
+
+struct nand_onfi_vendor_macronix {
+	u8 reserved[1];
+	u8 reliability_func;
+} __packed;
+
+static int macronix_nand_setup_read_retry(struct nand_chip *chip, int mode)
+{
+	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = {0};
+	int ret;
+
+	if (mode > MACRONIX_READ_RETRY_MODE)
+		mode = MACRONIX_READ_RETRY_MODE;
+
+	feature[0] = mode;
+	ret =  nand_set_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
+	if (ret)
+		pr_err("set feature failed to read retry moded:%d\n", mode);
+
+	ret =  nand_get_features(chip, ONFI_FEATURE_ADDR_READ_RETRY, feature);
+	if (ret || feature[0] != mode)
+		pr_err("get feature failed to read retry moded:%d(%d)\n",
+		       mode, feature[0]);
+
+	return ret;
+}
+
+static void macronix_nand_onfi_init(struct nand_chip *chip)
+{
+	struct nand_parameters *p = &chip->parameters;
+
+	if (p->onfi) {
+		struct nand_onfi_vendor_macronix *mxic =
+				(void *)p->onfi->vendor;
+
+		if (mxic->reliability_func & MACRONIX_READ_RETRY_BIT) {
+			chip->read_retries = MACRONIX_READ_RETRY_MODE + 1;
+			chip->setup_read_retry =
+				 macronix_nand_setup_read_retry;
+			if (p->supports_set_get_features) {
+				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
+					p->set_feature_list);
+				set_bit(ONFI_FEATURE_ADDR_READ_RETRY,
+					p->get_feature_list);
+			}
+		}
+	}
+}
+
 /*
  * Macronix AC series does not support using SET/GET_FEATURES to change
  * the timings unlike what is declared in the parameter page. Unflag
@@ -65,6 +116,7 @@ static int macronix_nand_init(struct nand_chip *chip)
 		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
 
 	macronix_nand_fix_broken_get_timings(chip);
+	macronix_nand_onfi_init(chip);
 
 	return 0;
 }
-- 
1.9.1

