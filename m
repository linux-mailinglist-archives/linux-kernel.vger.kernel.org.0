Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD2B1877F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 04:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCQDCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Mar 2020 23:02:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52670 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCQDCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 23:02:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0DB7200C60;
        Tue, 17 Mar 2020 04:01:59 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E184200C55;
        Tue, 17 Mar 2020 04:01:55 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B806402D0;
        Tue, 17 Mar 2020 11:01:49 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] clocksource: imx-sysctr: Remove unused includes
Date:   Tue, 17 Mar 2020 10:55:13 +0800
Message-Id: <1584413713-7376-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing in use from of_address.h/of_irq.h, remove them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clocksource/timer-imx-sysctr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/timer-imx-sysctr.c
index b7c80a3..18b90fc 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -4,8 +4,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
 
 #include "timer-of.h"
 
-- 
2.7.4

