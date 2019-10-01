Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA09C363C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbfJANrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 09:47:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:25358 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388352AbfJANrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:47:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 06:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="205065286"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Oct 2019 06:47:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2F0F3234; Tue,  1 Oct 2019 16:47:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v2 3/4] [media] usb: pulse8-cec: Switch to use %ptT
Date:   Tue,  1 Oct 2019 16:47:16 +0300
Message-Id: <20191001134717.81282-4-andriy.shevchenko@linux.intel.com>
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

Cc: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/pulse8-cec/pulse8-cec.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
index ac88ade94cda..4299cf924f21 100644
--- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
+++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
@@ -323,7 +323,6 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 	u8 *data = pulse8->data + 1;
 	u8 cmd[2];
 	int err;
-	struct tm tm;
 	time64_t date;
 
 	pulse8->vers = 0;
@@ -344,10 +343,7 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
 	if (err)
 		return err;
 	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
-	time64_to_tm(date, 0, &tm);
-	dev_info(pulse8->dev, "Firmware build date %04ld.%02d.%02d %02d:%02d:%02d\n",
-		 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-		 tm.tm_hour, tm.tm_min, tm.tm_sec);
+	dev_info(pulse8->dev, "Firmware build date %ptT\n", &date);
 
 	dev_dbg(pulse8->dev, "Persistent config:\n");
 	cmd[0] = MSGCODE_GET_AUTO_ENABLED;
-- 
2.23.0

