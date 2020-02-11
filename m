Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89F159949
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbgBKTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 14:01:25 -0500
Received: from mailoutvs57.siol.net ([185.57.226.248]:37692 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731546AbgBKTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:01:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 2CA33520DE1;
        Tue, 11 Feb 2020 20:01:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WPWhKKgj2J2W; Tue, 11 Feb 2020 20:01:19 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E0A16520674;
        Tue, 11 Feb 2020 20:01:19 +0100 (CET)
Received: from localhost.localdomain (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6B3805215CF;
        Tue, 11 Feb 2020 20:01:17 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, icenowy@aosc.io,
        jernej.skrabec@siol.net, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] clk: sunxi-ng: sun8i-de2: Sort structures
Date:   Tue, 11 Feb 2020 19:59:36 +0100
Message-Id: <20200211185936.245174-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211185936.245174-1-jernej.skrabec@siol.net>
References: <20200211185936.245174-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3s quirks are not in right place. Move it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/=
ccu-sun8i-de2.c
index 5a278c391f1d..524f33275bc7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -248,6 +248,16 @@ static const struct sunxi_ccu_desc sun8i_r40_de2_clk=
_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
 };
=20
+static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
+	.ccu_clks	=3D sun8i_v3s_de2_clks,
+	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
+
+	.hw_clks	=3D &sun8i_v3s_de2_hw_clks,
+
+	.resets		=3D sun8i_a83t_de2_resets,
+	.num_resets	=3D ARRAY_SIZE(sun8i_a83t_de2_resets),
+};
+
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc =3D {
 	.ccu_clks	=3D sun50i_a64_de2_clks,
 	.num_ccu_clks	=3D ARRAY_SIZE(sun50i_a64_de2_clks),
@@ -268,16 +278,6 @@ static const struct sunxi_ccu_desc sun50i_h5_de2_clk=
_desc =3D {
 	.num_resets	=3D ARRAY_SIZE(sun50i_h5_de2_resets),
 };
=20
-static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc =3D {
-	.ccu_clks	=3D sun8i_v3s_de2_clks,
-	.num_ccu_clks	=3D ARRAY_SIZE(sun8i_v3s_de2_clks),
-
-	.hw_clks	=3D &sun8i_v3s_de2_hw_clks,
-
-	.resets		=3D sun8i_h3_de2_resets,
-	.num_resets	=3D ARRAY_SIZE(sun8i_h3_de2_resets),
-};
-
 static int sunxi_de2_clk_probe(struct platform_device *pdev)
 {
 	struct resource *res;
--=20
2.25.0

