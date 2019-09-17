Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3BB48EB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404730AbfIQINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:13:30 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46292 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbfIQIN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:13:28 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8c0-0005RU-Hh; Tue, 17 Sep 2019 10:13:24 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, d.schultz@phytec.de,
        linux-rockchip@lists.infradead.org,
        christoph.muellner@theobroma-systems.com, tony.xie@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/4] mfd: rk808: set rk817 interrupt polarity to low
Date:   Tue, 17 Sep 2019 10:12:55 +0200
Message-Id: <20190917081256.24919-3-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917081256.24919-1-heiko@sntech.de>
References: <20190917081256.24919-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other rk8xx operate with the polarity on low and even the old
submitted devicetree snippet for the px30-evb declared the irq as low.
So bring the rk817 preset in line with this, as there is really no
reason for it to be the only with with a high polarity.

The rk809/rk817 hasn't been added to any devicetrees so far, so this
won't break anything.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/rk808.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 966841744ee6..c0e5e921766d 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -207,7 +207,7 @@ static const struct rk808_reg_data rk808_pre_init_reg[] = {
 
 static const struct rk808_reg_data rk817_pre_init_reg[] = {
 	{RK817_RTC_CTRL_REG, RTC_STOP, RTC_STOP},
-	{RK817_GPIO_INT_CFG, RK817_INT_POL_MSK, RK817_INT_POL_H},
+	{RK817_GPIO_INT_CFG, RK817_INT_POL_MSK, RK817_INT_POL_L},
 	{RK817_SYS_CFG(1), RK817_HOTDIE_TEMP_MSK | RK817_TSD_TEMP_MSK,
 					   RK817_HOTDIE_105 | RK817_TSD_140},
 };
-- 
2.20.1

