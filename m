Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B87C363D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbfJANrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 09:47:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:57244 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388754AbfJANrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="342977524"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 01 Oct 2019 06:47:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F3471DF; Tue,  1 Oct 2019 16:47:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/4] ARM: bcm2835: Switch to use %ptT
Date:   Tue,  1 Oct 2019 16:47:15 +0300
Message-Id: <20191001134717.81282-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
References: <20191001134717.81282-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptT instead of open coded variant to print content of
time64_t type in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/raspberrypi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index da26a584dca0..a3e85186f8e6 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -182,16 +182,10 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
 					&packet, sizeof(packet));
 
-	if (ret == 0) {
-		struct tm tm;
-
-		time64_to_tm(packet, 0, &tm);
+	if (ret)
+		return;
 
-		dev_info(fw->cl.dev,
-			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
-			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-			 tm.tm_hour, tm.tm_min);
-	}
+	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
 }
 
 static void
-- 
2.23.0

