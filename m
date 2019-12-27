Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C6612B052
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Dec 2019 02:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfL0BmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 20:42:12 -0500
Received: from mx.socionext.com ([202.248.49.38]:5569 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfL0BmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 20:42:11 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 27 Dec 2019 10:42:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id ED167603AB;
        Fri, 27 Dec 2019 10:42:09 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 27 Dec 2019 10:43:02 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 677131A01BB;
        Fri, 27 Dec 2019 10:42:09 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] clk: uniphier: Add SCSSI clock gate for each channel
Date:   Fri, 27 Dec 2019 10:42:05 +0900
Message-Id: <1577410925-22021-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCSSI has clock gates for each channel in the SoCs newer than Pro4,
so this adds missing clock gates for channel 1, 2 and 3. And more, this
moves MCSSI clock ID after SCSSI.

Fixes: ff388ee36516 ("clk: uniphier: add clock frequency support for SPI")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---
Changes since v1:
- Add 'Fixes' and 'Acked-by' tags

drivers/clk/uniphier/clk-uniphier-peri.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-peri.c b/drivers/clk/uniphier/clk-uniphier-peri.c
index 9caa529..3e32db9 100644
--- a/drivers/clk/uniphier/clk-uniphier-peri.c
+++ b/drivers/clk/uniphier/clk-uniphier-peri.c
@@ -18,8 +18,8 @@
 #define UNIPHIER_PERI_CLK_FI2C(idx, ch)					\
 	UNIPHIER_CLK_GATE("i2c" #ch, (idx), "i2c", 0x24, 24 + (ch))
 
-#define UNIPHIER_PERI_CLK_SCSSI(idx)					\
-	UNIPHIER_CLK_GATE("scssi", (idx), "spi", 0x20, 17)
+#define UNIPHIER_PERI_CLK_SCSSI(idx, ch)				\
+	UNIPHIER_CLK_GATE("scssi" #ch, (idx), "spi", 0x20, 17 + (ch))
 
 #define UNIPHIER_PERI_CLK_MCSSI(idx)					\
 	UNIPHIER_CLK_GATE("mcssi", (idx), "spi", 0x24, 14)
@@ -35,7 +35,7 @@ const struct uniphier_clk_data uniphier_ld4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_I2C(6, 2),
 	UNIPHIER_PERI_CLK_I2C(7, 3),
 	UNIPHIER_PERI_CLK_I2C(8, 4),
-	UNIPHIER_PERI_CLK_SCSSI(11),
+	UNIPHIER_PERI_CLK_SCSSI(11, 0),
 	{ /* sentinel */ }
 };
 
@@ -51,7 +51,10 @@ const struct uniphier_clk_data uniphier_pro4_peri_clk_data[] = {
 	UNIPHIER_PERI_CLK_FI2C(8, 4),
 	UNIPHIER_PERI_CLK_FI2C(9, 5),
 	UNIPHIER_PERI_CLK_FI2C(10, 6),
-	UNIPHIER_PERI_CLK_SCSSI(11),
-	UNIPHIER_PERI_CLK_MCSSI(12),
+	UNIPHIER_PERI_CLK_SCSSI(11, 0),
+	UNIPHIER_PERI_CLK_SCSSI(12, 1),
+	UNIPHIER_PERI_CLK_SCSSI(13, 2),
+	UNIPHIER_PERI_CLK_SCSSI(14, 3),
+	UNIPHIER_PERI_CLK_MCSSI(15),
 	{ /* sentinel */ }
 };
-- 
2.7.4

