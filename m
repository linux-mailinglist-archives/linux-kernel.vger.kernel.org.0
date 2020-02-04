Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B42151E48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 17:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBDQ1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 11:27:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:9118 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgBDQ1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:27:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 08:27:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,402,1574150400"; 
   d="scan'208";a="429862758"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2020 08:27:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7933117C; Tue,  4 Feb 2020 18:27:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] platform/chrome: wilco_ec: Platform data shan't include kernel.h
Date:   Tue,  4 Feb 2020 18:27:29 +0200
Message-Id: <20200204162729.29175-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace with appropriate types.h.

Also there is no need to include device.h, but mutex.h.
For the pointers to unknown structures use forward declarations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/wilco-ec.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index afede15a95bf..25f46a939637 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -8,8 +8,8 @@
 #ifndef WILCO_EC_H
 #define WILCO_EC_H
 
-#include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
 
 /* Message flags for using the mailbox() interface */
 #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
@@ -17,6 +17,10 @@
 /* Normal commands have a maximum 32 bytes of data */
 #define EC_MAILBOX_DATA_SIZE		32
 
+struct device;
+struct resource;
+struct platform_device;
+
 /**
  * struct wilco_ec_device - Wilco Embedded Controller handle.
  * @dev: Device handle.
-- 
2.24.1

