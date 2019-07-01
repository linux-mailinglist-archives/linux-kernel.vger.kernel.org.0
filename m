Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDC47D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 10:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfFQIqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 04:46:50 -0400
Received: from foss.arm.com ([217.140.110.172]:41836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfFQIqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 04:46:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FA8E28;
        Mon, 17 Jun 2019 01:46:46 -0700 (PDT)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41CC63F246;
        Mon, 17 Jun 2019 01:46:45 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] crypto: ccree: add HW engine config check
Date:   Mon, 17 Jun 2019 11:46:30 +0300
Message-Id: <20190617084631.23551-5-gilad@benyossef.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617084631.23551-1-gilad@benyossef.com>
References: <20190617084631.23551-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check to verify the stated device tree HW configuration
matches the HW.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c    | 18 ++++++++++++++++++
 drivers/crypto/ccree/cc_driver.h    |  3 +++
 drivers/crypto/ccree/cc_host_regs.h | 17 +++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 667bc73d7a00..980aa04b655b 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -408,6 +408,24 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		}
 		sig_cidr = val;
 
+		/* Check HW engine configuration */
+		val = cc_ioread(new_drvdata, CC_REG(HOST_REMOVE_INPUT_PINS));
+		switch (val) {
+		case CC_PINS_FULL:
+			/* This is fine */
+			break;
+		case CC_PINS_SLIM:
+			if (new_drvdata->std_bodies & CC_STD_NIST) {
+				dev_warn(dev, "703 mode forced due to HW configuration.\n");
+				new_drvdata->std_bodies = CC_STD_OSCCA;
+			}
+			break;
+		default:
+			dev_err(dev, "Unsupported engines configration.\n");
+			rc = -EINVAL;
+			goto post_clk_err;
+		}
+
 		/* Check security disable state */
 		val = cc_ioread(new_drvdata, CC_REG(SECURITY_DISABLED));
 		val &= CC_SECURITY_DISABLED_MASK;
diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index 556b3322667e..6448b2b9794b 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -58,6 +58,9 @@ enum cc_std_body {
 
 #define CC_COHERENT_CACHE_PARAMS 0xEEE
 
+#define CC_PINS_FULL	0x0
+#define CC_PINS_SLIM	0x9F
+
 /* Maximum DMA mask supported by IP */
 #define DMA_BIT_MASK_LEN 48
 
diff --git a/drivers/crypto/ccree/cc_host_regs.h b/drivers/crypto/ccree/cc_host_regs.h
index ad1acb105f2d..efe3e1d8b87b 100644
--- a/drivers/crypto/ccree/cc_host_regs.h
+++ b/drivers/crypto/ccree/cc_host_regs.h
@@ -206,6 +206,23 @@
 #define CC_HOST_POWER_DOWN_EN_REG_OFFSET	0xA78UL
 #define CC_HOST_POWER_DOWN_EN_VALUE_BIT_SHIFT	0x0UL
 #define CC_HOST_POWER_DOWN_EN_VALUE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REG_OFFSET	0x0A7CUL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_AES_ENGINE_BIT_SHIFT	0x0UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_AES_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_AES_MAC_ENGINE_BIT_SHIFT	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_AES_MAC_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_GHASH_ENGINE_BIT_SHIFT	0x2UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_GHASH_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_DES_ENGINE_BIT_SHIFT	0x3UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_DES_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_HASH_ENGINE_BIT_SHIFT	0x4UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_HASH_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_SM3_ENGINE_BIT_SHIFT	0x5UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_SM3_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_SM4_ENGINE_BIT_SHIFT	0x6UL
+#define CC_HOST_REMOVE_INPUT_PINS_REMOVE_SM4_ENGINE_BIT_SIZE	0x1UL
+#define CC_HOST_REMOVE_INPUT_PINS_OTP_DISCONNECTED_BIT_SHIFT	0x7UL
+#define CC_HOST_REMOVE_INPUT_PINS_OTP_DISCONNECTED_BIT_SIZE	0x1UL
 // --------------------------------------
 // BLOCK: ID_REGISTERS
 // --------------------------------------
-- 
2.21.0

