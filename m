Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52E5B4922
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbfIQIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 04:19:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46550 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388817AbfIQIT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:19:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iA8hl-0005Uf-PU; Tue, 17 Sep 2019 10:19:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        finley.xiao@rock-chips.com, zhangqing@rock-chips.com,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 1/5] clk: rockchip: Add div50 clock-ids for sdmmc on px30 and nandc
Date:   Tue, 17 Sep 2019 10:18:59 +0200
Message-Id: <20190917081903.25139-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

EMMC and SDIO already have these clock-ids (still unused) only sdmmc is
missing them, so fix that.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/dt-bindings/clock/px30-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/px30-cru.h b/include/dt-bindings/clock/px30-cru.h
index 00101479f7c4..5b1416fcde6f 100644
--- a/include/dt-bindings/clock/px30-cru.h
+++ b/include/dt-bindings/clock/px30-cru.h
@@ -85,6 +85,8 @@
 #define SCLK_EMMC_DIV50		83
 #define SCLK_DDRCLK		84
 #define SCLK_UART1_SRC		85
+#define SCLK_SDMMC_DIV		86
+#define SCLK_SDMMC_DIV50	87
 
 /* dclk gates */
 #define DCLK_VOPB		150
-- 
2.20.1

