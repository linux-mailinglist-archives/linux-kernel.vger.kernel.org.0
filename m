Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126AA48146
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfFQLvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 07:51:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:41177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFQLvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:51:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:51:08 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Jun 2019 04:51:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0432F162; Mon, 17 Jun 2019 14:51:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Input: mpr121 - Switch to use device_property_count_u32()
Date:   Mon, 17 Jun 2019 14:51:06 +0300
Message-Id: <20190617115106.29454-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use use device_property_count_u32() directly, that makes code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/keyboard/mpr121_touchkey.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 884a74d8a7ed..1119db6dbca5 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -257,8 +257,7 @@ static int mpr_touchkey_probe(struct i2c_client *client,
 
 	mpr121->client = client;
 	mpr121->input_dev = input_dev;
-	mpr121->keycount = device_property_read_u32_array(dev, "linux,keycodes",
-							  NULL, 0);
+	mpr121->keycount = device_property_count_u32(dev, "linux,keycodes");
 	if (mpr121->keycount > MPR121_MAX_KEY_COUNT) {
 		dev_err(dev, "too many keys defined (%d)\n", mpr121->keycount);
 		return -EINVAL;
-- 
2.20.1

