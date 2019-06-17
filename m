Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CB4814B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 13:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfFQLyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 07:54:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:19314 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfFQLyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:54:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 04:54:06 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2019 04:54:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D4B1162; Mon, 17 Jun 2019 14:54:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: regmap: Switch to bitmap_zalloc()
Date:   Mon, 17 Jun 2019 14:54:03 +0300
Message-Id: <20190617115403.33241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regcache-lzo.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regcache-lzo.c b/drivers/base/regmap/regcache-lzo.c
index fc14e8b9344f..7886303eb026 100644
--- a/drivers/base/regmap/regcache-lzo.c
+++ b/drivers/base/regmap/regcache-lzo.c
@@ -148,20 +148,18 @@ static int regcache_lzo_init(struct regmap *map)
 	 * that register.
 	 */
 	bmp_size = map->num_reg_defaults_raw;
-	sync_bmp = kmalloc_array(BITS_TO_LONGS(bmp_size), sizeof(long),
-				 GFP_KERNEL);
+	sync_bmp = bitmap_zalloc(bmp_size, GFP_KERNEL);
 	if (!sync_bmp) {
 		ret = -ENOMEM;
 		goto err;
 	}
-	bitmap_zero(sync_bmp, bmp_size);
 
 	/* allocate the lzo blocks and initialize them */
 	for (i = 0; i < blkcount; i++) {
 		lzo_blocks[i] = kzalloc(sizeof **lzo_blocks,
 					GFP_KERNEL);
 		if (!lzo_blocks[i]) {
-			kfree(sync_bmp);
+			bitmap_free(sync_bmp);
 			ret = -ENOMEM;
 			goto err;
 		}
@@ -213,7 +211,7 @@ static int regcache_lzo_exit(struct regmap *map)
 	 * only once.
 	 */
 	if (lzo_blocks[0])
-		kfree(lzo_blocks[0]->sync_bmp);
+		bitmap_free(lzo_blocks[0]->sync_bmp);
 	for (i = 0; i < blkcount; i++) {
 		if (lzo_blocks[i]) {
 			kfree(lzo_blocks[i]->wmem);
-- 
2.20.1

