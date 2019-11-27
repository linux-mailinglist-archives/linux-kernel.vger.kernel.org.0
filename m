Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99F810AD82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2019 11:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0KYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Nov 2019 05:24:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbfK0KYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:24:25 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARAMKPL028075;
        Wed, 27 Nov 2019 11:24:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=NGFn1INSjiFml8tyG7QtE320FjzT4hxnP0D7Gm8LUjM=;
 b=uME+JoZ+//t/DS+f6MAZex+Z9TXISsVsn5lhbai1DelE4ii2Ew9vpIylgLi6hfjVKvI4
 ZmjyIfAzdSlG11yX8kQVXhk3bss4hHlWY8sdJmtkax+oBFMs138y3dU4XcN1dHBzahUS
 pJ6v6phHMhlHkBeZ/437466BYpEzIWWCriT1LzEFFunp/1tUsdbBW97PsWQjPyeWldOj
 OSuZfXTcZ5m/0rOBCq0QxhLaLPr7/hYJpawKA5Andlix/2ajYuSBGNRGZ9fPQ28U8U+0
 TeFyQpcwDWy2xXlakHz+JDNT0hBm/daX3tStKgkJRXWq9uIGiPNuU/CctC1V0xDlnWB5 iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2whcxsb0sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 11:24:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4E46010002A;
        Wed, 27 Nov 2019 11:24:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1EF82B1218;
        Wed, 27 Nov 2019 11:24:16 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov 2019 11:24:15
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
Subject: [PATCH] Input: goodix - support gt9147 touchpanel
Date:   Wed, 27 Nov 2019 11:24:14 +0100
Message-ID: <1574850254-13381-1-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_02:2019-11-27,2019-11-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertré <yannick.fertre@st.com>

Add support for it by adding compatible and supported chip data
(default settings used).
The chip data on GT9147 is similar to GT912, like
- config data register has 0x8047 address
- config data register max len is 240
- config data checksum has 8-bit

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index fb43aa7..b470773 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1045,6 +1045,7 @@ static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt9271" },
 	{ .compatible = "goodix,gt928" },
 	{ .compatible = "goodix,gt967" },
+	{ .compatible = "goodix,gt9147",},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, goodix_of_match);
-- 
2.7.4

