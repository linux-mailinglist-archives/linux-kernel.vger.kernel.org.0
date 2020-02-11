Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7F1594B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 17:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgBKQVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 11:21:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51982 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbgBKQVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:21:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j1YHT-0007Ai-Tl; Tue, 11 Feb 2020 16:21:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hwmon: axi-fan-control: fix uninitialized dereference of pointer res
Date:   Tue, 11 Feb 2020 16:20:59 +0000
Message-Id: <20200211162059.94233-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the resource pointer ret is uninitialized and it is
being dereferenced when printing out a debug message. Fix this
by fetching the resource and assigning pointer res.  It is
a moot point that we sanity check for a null res since a successful
call to devm_platform_ioremap_resource has already occurred so
in theory it should never be non-null.

Addresses-Coverity: ("Uninitialized pointer read")
Fixes: 690dd9ce04f6 ("hwmon: Support ADI Fan Control IP")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hwmon/axi-fan-control.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
index 8041ba7cc152..36e0d060510a 100644
--- a/drivers/hwmon/axi-fan-control.c
+++ b/drivers/hwmon/axi-fan-control.c
@@ -415,6 +415,9 @@ static int axi_fan_control_probe(struct platform_device *pdev)
 	if (!ctl->clk_rate)
 		return -EINVAL;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
 	dev_dbg(&pdev->dev, "Re-mapped from 0x%08llX to %p\n",
 		(unsigned long long)res->start, ctl->base);
 
-- 
2.25.0

