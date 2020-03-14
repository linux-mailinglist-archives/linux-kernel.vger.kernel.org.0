Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9404C18525E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgCMXcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 19:32:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:60515 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMXcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:32:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 16:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="232571728"
Received: from perezpri-desk0.jf.intel.com ([134.134.159.53])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2020 16:32:42 -0700
From:   Bernardo Perez Priego <bernardo.perez.priego@intel.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Campello <campello@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: Provide correct output format to 'h1_gpio' file
Date:   Fri, 13 Mar 2020 16:27:18 -0700
Message-Id: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
this is being passed to 'send_ec_cmd' as type u8, thus, result
is stored in least significant byte. Due to output format,
the whole 'val' value was being displayed when any of the most
significant bytes are different than zero.

This fix will make sure only least significant byte is displayed
regardless of remaining bytes value.

Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>
---
 drivers/platform/chrome/wilco_ec/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index df5a5f6c3ec6..c775b7d58c6d 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -211,7 +211,7 @@ static int h1_gpio_get(void *arg, u64 *val)
 	return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02hhx\n");
 
 /**
  * test_event_set() - Sends command to EC to cause an EC test event.
-- 
2.17.1

