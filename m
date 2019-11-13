Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C166BFAE62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 11:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKMKWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 05:22:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:33051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMKWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:22:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 02:22:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="355431695"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2019 02:22:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 505FFFD; Wed, 13 Nov 2019 12:22:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v1] Revert "mfd: syscon: Set name of regmap_config"
Date:   Wed, 13 Nov 2019 12:22:26 +0200
Message-Id: <20191113102226.71492-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 500f9ff518cf55930c670b0e2b8901caf70a7548.

The original commit is a duplication of the exactly previously added
commit 408d1d570a63 ("mfd: syscon: Set regmap name to DT node name").
Revert the unnecessary later one.

Cc: David Lechner <david@lechnology.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/syscon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 660723276481..e22197c832e8 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -105,7 +105,6 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
-	syscon_config.name = of_node_full_name(np);
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	if (IS_ERR(regmap)) {
-- 
2.24.0

