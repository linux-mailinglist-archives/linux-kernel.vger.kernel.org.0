Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 240AB11F482
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 23:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLNWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 17:03:57 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40401 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:03:05 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A97A01BF204;
        Sat, 14 Dec 2019 22:03:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 05/17] rtc: pcf8523: return meaningful value for RTC_VL_READ
Date:   Sat, 14 Dec 2019 23:02:47 +0100
Message-Id: <20191214220259.621996-6-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
References: <20191214220259.621996-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REG_CONTROL3_BLF indicates the battery is low and needs to be replaced
soon.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf8523.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
index b24c908f5f06..47e0f411dd5c 100644
--- a/drivers/rtc/rtc-pcf8523.c
+++ b/drivers/rtc/rtc-pcf8523.c
@@ -282,11 +282,11 @@ static int pcf8523_rtc_ioctl(struct device *dev, unsigned int cmd,
 		ret = pcf8523_voltage_low(client);
 		if (ret < 0)
 			return ret;
+		if (ret)
+			ret = RTC_VL_BACKUP_LOW;
 
-		if (copy_to_user((void __user *)arg, &ret, sizeof(int)))
-			return -EFAULT;
+		return put_user(ret, (unsigned int __user *)arg);
 
-		return 0;
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.23.0

