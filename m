Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6C20D16
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfEPQdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:33:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51518 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfEPQdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:33:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DD521715;
        Thu, 16 May 2019 09:33:23 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 60D6E3F5AF;
        Thu, 16 May 2019 09:33:22 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] firmware: arm_scmi: fix bitfield definitions for SENSOR_DESC attributes
Date:   Thu, 16 May 2019 17:33:15 +0100
Message-Id: <20190516163315.18505-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the SCMI specification the bitfields for SENSOR_DESC attributes
are as follows:
attributes_low 	[7:0] 	Number of trip points supported
attributes_high	[15:11]	The power-of-10 multiplier in 2's-complement
			format that is applied to the sensor units

Looks like the code developed during the draft versions of the
specification slipped through and are wrong with respect to final
released version. Fix them by adjusting the bitfields appropriately.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Fixes: 5179c523c1ea ("firmware: arm_scmi: add initial support for sensor protocol")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/sensors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Hi Florian,

While testing your patches, I found this horrible/silly bug with bitfields
which initial made me think firmware is buggy but later found out driver
was buggy instead.

I updated your patch accordingly[1]

Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-next/scmi-updates

diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index b53d5cc9c9f6..c00287b5f2c2 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -30,10 +30,10 @@ struct scmi_msg_resp_sensor_description {
 		__le32 id;
 		__le32 attributes_low;
 #define SUPPORTS_ASYNC_READ(x)	((x) & BIT(31))
-#define NUM_TRIP_POINTS(x)	(((x) >> 4) & 0xff)
+#define NUM_TRIP_POINTS(x)	((x) & 0xff)
 		__le32 attributes_high;
 #define SENSOR_TYPE(x)		((x) & 0xff)
-#define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
+#define SENSOR_SCALE(x)		(((x) >> 11) & 0x1f)
 #define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
 #define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
 		    u8 name[SCMI_MAX_STR_SIZE];
-- 
2.17.1

