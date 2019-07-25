Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3939758E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfGYUeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 16:34:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:64560 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfGYUeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 13:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="172821942"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 25 Jul 2019 13:34:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D881381; Thu, 25 Jul 2019 23:34:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: [PATCH v1 1/2] extcon: axp288: Add missed error check
Date:   Thu, 25 Jul 2019 23:34:04 +0300
Message-Id: <20190725203405.65523-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems from the very beginning the error check has been missed
in axp288_extcon_log_rsi(). Add it here.

Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-axp288.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 7254852e6ec0..4cbcc3b1aa6b 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -135,6 +135,9 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 	int ret;
 
 	ret = regmap_read(info->regmap, AXP288_PS_BOOT_REASON_REG, &val);
+	if (ret < 0)
+		return;
+
 	for (i = 0, rsi = axp288_pwr_up_down_info; *rsi; rsi++, i++) {
 		if (val & BIT(i)) {
 			dev_dbg(info->dev, "%s\n", *rsi);
-- 
2.20.1

