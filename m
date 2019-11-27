Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE1DA10AD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 11:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfK0KYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 05:24:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18838 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726149AbfK0KYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:24:14 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARAMKPI028075;
        Wed, 27 Nov 2019 11:24:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=Bmi9ZxvHiIlWxe/sSml2LTtA26zSCPWx7oIRLedeHJE=;
 b=essqUBkxbMrrIuPbpzljeVkKukn47nmTXRvV9HLBD2v3JURaDG8dBcU17MDwF7T55mn2
 b6JllkFERRYnivQyKHDjbJVbVVGySsq5FOLd0Op0sBW2459+7cto8S1eLBwclSPmsMVM
 FZj8G4xjTtpAmI2diFvD61FuJfIeDPgeBoU8Lyx0fVz1wmbn5mBW+BoOwXeaccPS3Vns
 uwqCzwJ4wpws9WKcj+HEB1jy4dtc3OhD9jk5VUEmz5O4+lqrgWwlnFfT23QnYmWsGQj6
 eZcjhorvXJf921ohtHfc6gWkezI0bez9WVTfgkhlhl2pzYSsMrXt4lDboDNyTINnG+zR uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsb0rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:24:07 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 65C1110002A;
        Wed, 27 Nov 2019 11:24:06 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B85732B1216;
        Wed, 27 Nov 2019 11:24:06 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 11:24:05
 +0100
From:   Yannick Fertre <yannick.fertre@st.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Input: goodix: request_irq: convert gpio to irq
Date:   Wed, 27 Nov 2019 11:24:05 +0100
Message-ID: <1574850245-13325-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Convert gpio to irq if not already done by gpio lib.

Signed-off-by: Yannick Fertré <yannick.fertre
---
 drivers/input/touchscreen/goodix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b470773..f1d9d5e 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -392,6 +393,13 @@ static void goodix_free_irq(struct goodix_ts_data *ts)
 
 static int goodix_request_irq(struct goodix_ts_data *ts)
 {
+	int gpio;
+
+	gpio = desc_to_gpio(ts->gpiod_int);
+
+	if (gpio_is_valid(gpio))
+		ts->client->irq = gpio_to_irq(gpio);
+
 	return devm_request_threaded_irq(&ts->client->dev, ts->client->irq,
 					 NULL, goodix_ts_irq_handler,
 					 ts->irq_flags, ts->client->name, ts);
-- 
2.7.4

