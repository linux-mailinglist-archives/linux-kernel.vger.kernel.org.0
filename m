Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99C77657F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 14:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfGZMSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 08:18:24 -0400
Received: from mga09.intel.com ([134.134.136.24]:41703 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfGZMSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 08:18:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 05:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="345809256"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2019 05:18:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BBB8245; Fri, 26 Jul 2019 15:18:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] extcon: axp288: Use for_each_set_bit() in axp288_extcon_log_rsi()
Date:   Fri, 26 Jul 2019 15:18:20 +0300
Message-Id: <20190726121820.69679-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726121820.69679-1-andriy.shevchenko@linux.intel.com>
References: <20190726121820.69679-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies and standardizes axp288_extcon_log_rsi()
by using for_each_set_bit() library function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 694a8d4a57ff..415afaf479e7 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -121,7 +121,6 @@ static const char * const axp288_pwr_up_down_info[] = {
 	"Last shutdown caused by PMIC UVLO threshold",
 	"Last shutdown caused by SOC initiated cold off",
 	"Last shutdown caused by user pressing the power button",
-	NULL,
 };
 
 /*
@@ -130,8 +129,8 @@ static const char * const axp288_pwr_up_down_info[] = {
  */
 static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 {
-	const char * const *rsi;
 	unsigned int val, i, clear_mask = 0;
+	unsigned long bits;
 	int ret;
 
 	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
@@ -140,12 +139,10 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 		return;
 	}
 
-	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
-		if (val & BIT(i)) {
-			dev_dbg(info->dev, "%s\n", *rsi);
-			clear_mask |= BIT(i);
-		}
-	}
+	bits = val & GENMASK(ARRAY_SIZE(axp288_pwr_up_down_info) - 1, 0);
+	for_each_set_bit(i, &bits, ARRAY_SIZE(axp288_pwr_up_down_info))
+		dev_dbg(info->dev, "%s\n", axp288_pwr_up_down_info[i]);
+	clear_mask = bits;
 
 	/* Clear the register value for next reboot (write 1 to clear bit) */
 	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
-- 
2.20.1

