Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142D1163DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2020 08:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBSHeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 02:34:13 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35154 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726996AbgBSHeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4021FE006F;
        Wed, 19 Feb 2020 07:34:24 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id obBDEgqxufYX; Wed, 19 Feb 2020 07:34:19 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9E60EE0051;
        Wed, 19 Feb 2020 07:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T9OzMkojXK5b; Wed, 19 Feb 2020 07:34:16 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 0EC1EE0070;
        Wed, 19 Feb 2020 07:34:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 09/10] clk: mmp2: Add PLLs that are available on MMP3
Date:   Wed, 19 Feb 2020 08:33:52 +0100
Message-Id: <20200219073353.184336-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219073353.184336-1-lkundrak@v3.sk>
References: <20200219073353.184336-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more PLLs on MMP3 and are configured slightly differently.
Tested on a MMP3-based Dell Wyse 3020 machine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 7594a8280b93a..310d77855f03f 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -57,10 +57,16 @@
 #define APMU_USBHSIC0	0xf8
 #define APMU_USBHSIC1	0xfc
=20
-#define MPMU_FCCR	0x8
-#define MPMU_POSR	0x10
-#define MPMU_UART_PLL	0x14
-#define MPMU_PLL2_CR	0x34
+#define MPMU_FCCR		0x8
+#define MPMU_POSR		0x10
+#define MPMU_UART_PLL		0x14
+#define MPMU_PLL2_CR		0x34
+/* MMP3 specific below */
+#define MPMU_PLL3_CR		0x50
+#define MPMU_PLL3_CTRL1		0x58
+#define MPMU_PLL1_CTRL		0x5c
+#define MPMU_PLL_DIFF_CTRL	0x68
+#define MPMU_PLL2_CTRL1		0x414
=20
 enum mmp2_clk_model {
 	CLK_MODEL_MMP2,
@@ -86,6 +92,14 @@ static struct mmp_param_pll_clk pll_clks[] =3D {
 	{MMP2_CLK_PLL2,   "pll2",           0, MPMU_PLL2_CR,       0x0300, MPMU=
_PLL2_CR, 10},
 };
=20
+static struct mmp_param_pll_clk mmp3_pll_clks[] =3D {
+	{MMP2_CLK_PLL2,   "pll1",   797330000, MPMU_FCCR,          0x4000, MPMU=
_POSR,     0,      26000000, MPMU_PLL1_CTRL,      25},
+	{MMP2_CLK_PLL2,   "pll2",           0, MPMU_PLL2_CR,       0x0300, MPMU=
_PLL2_CR, 10,      26000000, MPMU_PLL2_CTRL1,     25},
+	{MMP3_CLK_PLL1_P, "pll1_p",         0, MPMU_PLL_DIFF_CTRL, 0x0010, 0,  =
           0,     797330000, MPMU_PLL_DIFF_CTRL,   0},
+	{MMP3_CLK_PLL2_P, "pll2_p",         0, MPMU_PLL_DIFF_CTRL, 0x0100, MPMU=
_PLL2_CR, 10,      26000000, MPMU_PLL_DIFF_CTRL,   5},
+	{MMP3_CLK_PLL3,   "pll3",           0, MPMU_PLL3_CR,       0x0300, MPMU=
_PLL3_CR, 10,      26000000, MPMU_PLL3_CTRL1,     25},
+};
+
 static struct mmp_param_fixed_factor_clk fixed_factor_clks[] =3D {
 	{MMP2_CLK_PLL1_2, "pll1_2", "pll1", 1, 2, 0},
 	{MMP2_CLK_PLL1_4, "pll1_4", "pll1_2", 1, 2, 0},
@@ -127,9 +141,15 @@ static void mmp2_pll_init(struct mmp2_clk_unit *pxa_=
unit)
 	mmp_register_fixed_rate_clks(unit, fixed_rate_clks,
 					ARRAY_SIZE(fixed_rate_clks));
=20
-	mmp_register_pll_clks(unit, pll_clks,
-				pxa_unit->mpmu_base,
-				ARRAY_SIZE(pll_clks));
+	if (pxa_unit->model =3D=3D CLK_MODEL_MMP3) {
+		mmp_register_pll_clks(unit, mmp3_pll_clks,
+					pxa_unit->mpmu_base,
+					ARRAY_SIZE(mmp3_pll_clks));
+	} else {
+		mmp_register_pll_clks(unit, pll_clks,
+					pxa_unit->mpmu_base,
+					ARRAY_SIZE(pll_clks));
+	}
=20
 	mmp_register_fixed_factor_clks(unit, fixed_factor_clks,
 					ARRAY_SIZE(fixed_factor_clks));
--=20
2.24.1

