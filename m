Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD935B3335
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 04:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbfIPCS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 22:18:57 -0400
Received: from aclms1.advantech.com.tw ([61.58.41.199]:49107 "EHLO
        ACLMS1.advantech.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfIPCS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 22:18:57 -0400
Received: from taipei08.ADVANTECH.CORP (unverified [172.20.0.235]) by ACLMS1.advantech.com.tw
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Tda45fdd0e4ac14014bf38@ACLMS1.advantech.com.tw>;
 Mon, 16 Sep 2019 10:18:52 +0800
From:   <Amy.Shih@advantech.com.tw>
To:     <she90122@gmail.com>
CC:     <amy.shih@advantech.com.tw>, <oakley.ding@advantech.com.tw>,
        <bichan.lu@advantech.com.tw>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [v1,1/1] hwmon: (nct7904) Fix the incorrect value of vsen_mask in nct7904_data struct.
Date:   Mon, 16 Sep 2019 10:18:36 +0800
Message-ID: <20190916021836.1945-1-Amy.Shih@advantech.com.tw>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.17.10.114]
X-ClientProxiedBy: ACLDAG.ADVANTECH.CORP (172.20.2.88) To
 taipei08.ADVANTECH.CORP (172.20.0.235)
X-StopIT: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "amy.shih" <amy.shih@advantech.com.tw>

Voltage sensors overlap with external temperature sensors. Detect
the multi-function of voltage, thermal diode and thermistor from
register VT_ADC_MD_REG to set value of vsen_mask in nct7904_data
struct.

Signed-off-by: amy.shih <amy.shih@advantech.com.tw>
---
 drivers/hwmon/nct7904.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 95b447cfa24c..ad61c3d92411 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -919,8 +919,11 @@ static int nct7904_probe(struct i2c_client *client,
 		bit = (1 << i);
 		if (val == 0)
 			data->tcpu_mask &= ~bit;
-		else if (val == 0x1 || val == 0x2)
+		else if (val == 0x1 || val == 0x2) {
 			data->temp_mode |= bit;
+			data->vsen_mask &= ~(0x06 << (i * 2));
+		} else
+			data->vsen_mask &= ~(0x06 << (i * 2));
 	}
 
 	/* PECI */
-- 
2.17.1

