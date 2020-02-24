Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37616A176
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgBXJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:09:29 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:32985 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727581AbgBXJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:17 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 0EBDF601;
        Mon, 24 Feb 2020 04:09:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=CB7SzUe6JIoJx
        R6zFLxGf3ne1PVHiTVHh0yVa9JCn4s=; b=Iarp4NyUrldn+Fy5XRCH4Pa4Wh/X+
        z3eY5aNCUkb56hp4+mGhr26cO2Wwj8IDlfcd5aJabBiOEyw4MjnC9syyWfErr/zY
        pLr7IlwfHwYx+G8CSPHVIwEZkyj37T5TuC0RDxUIOCsczKYxhbrT35lCfKgz0EJl
        8f56n93ObLAL6U7ybEHvt9dBfu6ExYU6EKESRI87AwaoxOuOSLheoc/XZ8OLpz1f
        4GWTZZqViZmTqjHsrcqg+lMS4rOtTCBSPDwhpi6424pY0+8zdshF6TeNalbizO+E
        +bgKHHmtuSwmjg3UFR+1JDlY65dWu1XAwAg0CoYuIyVazzlp6zHxRanoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=CB7SzUe6JIoJxR6zFLxGf3ne1PVHiTVHh0yVa9JCn4s=; b=SS66gsoE
        6SabthsyYt7CiJnMhzSe9gBKbEq6Goj9uV9R3rCDBJzXFyhBWtaThIQ5EGGomWBk
        NqUop21jS+wN51CORWtkHLEqur28owvxbGkRVP4Um2JjN9OKphn1qvUCqNwrqjL4
        GwLeD6ztQZPgtSKkec2G8xTVwY377OKnZT+ZtAcTEB1kpO5DykztEfUfthKdxCUU
        8W3pQs9U8Y+DXQeLOH4ynvO8O0Fo/frM2xWK4ULlOrejNdAA6BWsjR6B0RXIaogr
        FS0dpZG19B7s5A5LG1nerJcbiKj3o2mMrDD3WJNMpyUMuf42VgnzVdFVqziMYWar
        Q1zBNpYirR2ztw==
X-ME-Sender: <xms:u5JTXg4W6s43O6ybYa7l3nFnwrbKBs31Si2Gm9zIuTLIh-8BIToy0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudefnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:u5JTXogR_y0aq2rRybWBvFD2E7PMKkyOm-h_xR8sCFJkoDyPz8phwA>
    <xmx:u5JTXmmU-ExXIbEx1oj2gvpz9stOAktRpYe0IeRnIduZ_8MeKyh1eA>
    <xmx:u5JTXiFeoEUZbmC3GDYYlZtxEy2B_u_nJn6nR9Mzs_9oYT5Ly8Mx-g>
    <xmx:u5JTXkb4b939jGeWbUpWvkiOdXcBwpIlG4jROppeQLLKRZNVfQt1tsIPhGY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4EBFA328005E;
        Mon, 24 Feb 2020 04:09:15 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 18/89] clk: bcm: rpi: Rename is_prepared function
Date:   Mon, 24 Feb 2020 10:06:20 +0100
Message-Id: <cdeaa4152ac84aecc362e09153d1427777e3d933.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The raspberrypi_fw_pll_is_on function doesn't only apply to PLL
registered in the driver, but any clock exposed by the firmware.

Since we also implement the is_prepared hook, make the function
consistent with the other function names, and drop the fw from the
function name.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 3b2da62a72f5..13b7ee148824 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -87,7 +87,7 @@ static int raspberrypi_clock_property(struct rpi_firmware *firmware,
 	return 0;
 }
 
-static int raspberrypi_fw_pll_is_on(struct clk_hw *hw)
+static int raspberrypi_fw_is_prepared(struct clk_hw *hw)
 {
 	struct raspberrypi_clk_data *data =
 		container_of(hw, struct raspberrypi_clk_data, hw);
@@ -170,7 +170,7 @@ static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops raspberrypi_firmware_pll_clk_ops = {
-	.is_prepared = raspberrypi_fw_pll_is_on,
+	.is_prepared = raspberrypi_fw_is_prepared,
 	.recalc_rate = raspberrypi_fw_pll_get_rate,
 	.set_rate = raspberrypi_fw_pll_set_rate,
 	.determine_rate = raspberrypi_pll_determine_rate,
-- 
git-series 0.9.1
