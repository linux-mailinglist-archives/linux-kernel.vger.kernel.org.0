Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA914BF3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgA1SKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 13:10:05 -0500
Received: from [65.157.77.67] ([65.157.77.67]:62512 "HELO ubuntu.localdomain"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1726276AbgA1SKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:10:04 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 13:09:53 EST
Received: by ubuntu.localdomain (Postfix, from userid 1000)
        id 2FE37465314; Tue, 28 Jan 2020 11:00:36 -0700 (MST)
From:   Mike Jones <michael-a1.jones@analog.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, Mike Jones <michael-a1.jones@analog.com>
Subject: [PATCH 2/3] hwmon: (pmbus/ltc2978): Fix PMBus polling of MFR_COMMON definitions.
Date:   Tue, 28 Jan 2020 10:59:59 -0700
Message-Id: <1580234400-2829-2-git-send-email-michael-a1.jones@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
References: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 21537dc driver PMBus polling of MFR_COMMON from bits 5/4 to
bits 6/5. This fixs a LTC297X family bug where polling always returns
not busy even when the part is busy. This fixes a LTC388X and
LTM467X bug where polling used PEND and NOT_IN_TRANS, and BUSY was
not polled, which can lead to NACKing of commands. LTC388X and
LTM467X modules now poll BUSY and PEND, increasing reliability by
eliminating NACKing of commands.

Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
---
 drivers/hwmon/pmbus/ltc2978.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index f01f488..a91ed01 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -82,8 +82,8 @@ enum chips { ltc2974, ltc2975, ltc2977, ltc2978, ltc2980, ltc3880, ltc3882,
 
 #define LTC_POLL_TIMEOUT		100	/* in milli-seconds */
 
-#define LTC_NOT_BUSY			BIT(5)
-#define LTC_NOT_PENDING			BIT(4)
+#define LTC_NOT_BUSY			BIT(6)
+#define LTC_NOT_PENDING			BIT(5)
 
 /*
  * LTC2978 clears peak data whenever the CLEAR_FAULTS command is executed, which
-- 
2.7.4

