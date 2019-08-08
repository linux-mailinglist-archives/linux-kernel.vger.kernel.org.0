Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9902485C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfHHIC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 04:02:59 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43395 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbfHHIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:02:56 -0400
Received: from [167.98.27.226] (helo=ct-lt-765.unassigned)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1hvdNq-0008KF-0C; Thu, 08 Aug 2019 09:02:50 +0100
Received: from ikerpalomar by ct-lt-765.unassigned with local (Exim 4.89)
        (envelope-from <ikerpalomar@ct-lt-765.unassigned>)
        id 1hvdNp-0002Bo-4a; Thu, 08 Aug 2019 09:02:49 +0100
From:   Iker Perez <iker.perez@codethink.co.uk>
To:     linux-hwmon@vger.kernel.org, linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        Iker Perez del Palomar Sustatxa 
        <iker.perez@codethink.co.uk>
Subject: [PATCH v2 3/4] hwmon: (lm75) Add new fields into lm75_params_
Date:   Thu,  8 Aug 2019 09:02:45 +0100
Message-Id: <20190808080246.8371-4-iker.perez@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190808080246.8371-1-iker.perez@codethink.co.uk>
References: <20190808080246.8371-1-iker.perez@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>

The new fields are included to prepare the driver for next patch. The
fields are:

* *resolutions: Stores all the supported resolutions by the device.
* num_sample_times: Stores the number of possible sample times.
* *sample_times: Stores all the possible sample times to be set.
* sample_set_masks: The set_masks for the possible sample times
* sample_clr_mask: Clear mask to set the default sample time.

Signed-off-by: Iker Perez del Palomar Sustatxa <iker.perez@codethink.co.uk>
---

Changes since v1:
- In the lm75_params structure documentation there have been the next changes:
        - @num_sample_times description has been extended.
        - @sample_times description has been extended.
        - @sample_set_masks description has been extended.
        - @resolutions description has been included.

 drivers/hwmon/lm75.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index a32d7952d799..ed72455bcfa3 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -61,15 +61,34 @@ enum lm75_type {		/* keep sorted in alphabetical order */
  * @resolution_limits:	Limit register resolution. Optional. Should be set if
  *			the resolution of limit registers does not match the
  *			resolution of the temperature register.
+ * @resolutions		List of resolutions associated with sample times.
+ *			Optional. Should be set if num_sample_times is larger
+ *			than 1, and if the resolution changes with sample times.
+ *			If set, number of entries must match num_sample_times.
  * default_sample_time:	Sample time to be set by default.
+ * @num_sample_times:	Number of possible sample times to be set. Optional.
+ *			Should be set if the number of sample times is larger
+ *			than one.
+ * @sample_times:	All the possible sample times to be set. Mandatory if
+ *			num_sample_times is larger than 1. If set, number of
+ *			entries must match num_sample_times.
+ * @sample_set_masks:	All the set_masks for the possible sample times.
+ *			Mandatory if num_sample_times is larger than 1.
+ *			If set, number of entries must match num_sample_times.
+ * @sample_clr_mask:	Clear mask to set the default sample time.
  */
 
 struct lm75_params {
-	u8		set_mask;
-	u8		clr_mask;
-	u8		default_resolution;
-	u8		resolution_limits;
-	unsigned int	default_sample_time;
+	u8			set_mask;
+	u8			clr_mask;
+	u8			default_resolution;
+	u8			resolution_limits;
+	const u8		*resolutions;
+	unsigned int		default_sample_time;
+	u8			num_sample_times;
+	const unsigned int	*sample_times;
+	const u8		*sample_set_masks;
+	u8			sample_clr_mask;
 };
 
 /* Addresses scanned */
@@ -221,7 +240,14 @@ static const struct lm75_params device_params[] = {
 	[tmp75b] = { /* not one-shot mode, Conversion rate 37Hz */
 		.clr_mask = 1 << 7 | 3 << 5,
 		.default_resolution = 12,
+		.sample_set_masks = (u8 []){ 0 << 5, 1 << 5, 2 << 5,
+			3 << 5 },
+		.sample_clr_mask = 3 << 5,
 		.default_sample_time = MSEC_PER_SEC / 37,
+		.sample_times = (unsigned int []){ MSEC_PER_SEC / 37,
+			MSEC_PER_SEC / 18,
+			MSEC_PER_SEC / 9, MSEC_PER_SEC / 4 },
+		.num_sample_times = 4,
 	},
 	[tmp75c] = {
 		.clr_mask = 1 << 5,	/*not one-shot mode*/
-- 
2.11.0

