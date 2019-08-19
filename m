Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0716F94F45
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 22:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfHSUqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 16:46:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:38630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfHSUqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 13:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="202443692"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 19 Aug 2019 13:46:18 -0700
From:   thor.thayer@linux.intel.com
To:     mdf@kernel.org, richard.gong@intel.com, agust@denx.de
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND PATCHv4 2/3] fpga: altera-cvp: Preparation for V2 parts.
Date:   Mon, 19 Aug 2019 15:48:07 -0500
Message-Id: <1566247688-26070-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
References: <1566247688-26070-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

In preparation for adding newer V2 parts that use a FIFO,
reorganize altera_cvp_chk_error() and change the write
function to block based.
V2 parts have a block size matching the FIFO while older
V1 parts write a 32 bit word at a time.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 Remove inline function declaration
   Reverse Christmas Tree format for local variables
v3 Add return code check in altera_cvp_chk_error()
v4 Use min() function to determine block length
---
 drivers/fpga/altera-cvp.c | 69 +++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 9df2073331cb..3b8386fd32e7 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -143,6 +143,42 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
 	return -ETIMEDOUT;
 }
 
+static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
+{
+	struct altera_cvp_conf *conf = mgr->priv;
+	u32 val;
+	int ret;
+
+	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
+	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
+		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
+			bytes);
+		return -EPROTO;
+	}
+	return 0;
+}
+
+static int altera_cvp_send_block(struct altera_cvp_conf *conf,
+				 const u32 *data, size_t len)
+{
+	u32 mask, words = len / sizeof(u32);
+	int i, remainder;
+
+	for (i = 0; i < words; i++)
+		conf->write_data(conf, *data++);
+
+	/* write up to 3 trailing bytes, if any */
+	remainder = len % sizeof(u32);
+	if (remainder) {
+		mask = BIT(remainder * 8) - 1;
+		if (mask)
+			conf->write_data(conf, *data & mask);
+	}
+
+	return 0;
+}
+
 static int altera_cvp_teardown(struct fpga_manager *mgr,
 			       struct fpga_image_info *info)
 {
@@ -265,39 +301,25 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
 	return 0;
 }
 
-static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
-{
-	struct altera_cvp_conf *conf = mgr->priv;
-	u32 val;
-
-	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
-	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
-	if (val & VSE_CVP_STATUS_CFG_ERR) {
-		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
-			bytes);
-		return -EPROTO;
-	}
-	return 0;
-}
-
 static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 			    size_t count)
 {
 	struct altera_cvp_conf *conf = mgr->priv;
+	size_t done, remaining, len;
 	const u32 *data;
-	size_t done, remaining;
 	int status = 0;
-	u32 mask;
 
 	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
 	data = (u32 *)buf;
 	remaining = count;
 	done = 0;
 
-	while (remaining >= 4) {
-		conf->write_data(conf, *data++);
-		done += 4;
-		remaining -= 4;
+	while (remaining) {
+		len = min(sizeof(u32), remaining);
+		altera_cvp_send_block(conf, data, len);
+		data++;
+		done += len;
+		remaining -= len;
 
 		/*
 		 * STEP 10 (optional) and STEP 11
@@ -315,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 	}
 
-	/* write up to 3 trailing bytes, if any */
-	mask = BIT(remaining * 8) - 1;
-	if (mask)
-		conf->write_data(conf, *data & mask);
-
 	if (altera_cvp_chkcfg)
 		status = altera_cvp_chk_error(mgr, count);
 
-- 
2.7.4

