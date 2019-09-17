Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C61B48F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404718AbfIQIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:13:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46294 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbfIQIN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:13:28 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8c0-0005RU-QY; Tue, 17 Sep 2019 10:13:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, d.schultz@phytec.de,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com, tony.xie@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4/4] mfd: rk808: use DEFINE_RES_IRQ for rk808 rtc alarm irq
Date:   Tue, 17 Sep 2019 10:12:56 +0200
Message-Id: <20190917081256.24919-4-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081256.24919-1-heiko@sntech.de>
References: <20190917081256.24919-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not open code the definition, instead use the nice DEFINE_RES_IRQ
macro for it.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/rk808.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index c0e5e921766d..a69a6742ecdc 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -109,11 +109,7 @@ static const struct regmap_config rk817_regmap_config = {
 };
 
 static struct resource rtc_resources[] = {
-	{
-		.start  = RK808_IRQ_RTC_ALARM,
-		.end    = RK808_IRQ_RTC_ALARM,
-		.flags  = IORESOURCE_IRQ,
-	}
+	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
 
 static struct resource rk817_rtc_resources[] = {
-- 
2.20.1

