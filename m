Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68D16A115
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgBXJJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 04:09:34 -0500
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38349 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbgBXJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:23 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 6482C60B;
        Mon, 24 Feb 2020 04:09:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LObIfc2uPqHaL
        Eu4S6D78Ua8XtedAN9FGhZ26j8yxQA=; b=QpH/hA6mRczJnVXK5DEinGcV/68pd
        3gumyS2xzsqJ2Tx/pHiyvxWgDDKBqOvezAjJ0x9qiFWGVgia9I8ggBi0Jh4oPt4j
        Z/ehDvOqkzPsrl5O5OKMN3zEe42WbwVg8SZ3IFXVH4wwq7ZqEWmdqE1+DoW9yK4X
        OWUoMD9uCgyAE+kxXh+bQAd3px8b70MleFBxnrjqrovYnr86LW1s9CqUBmzos/LL
        xSn7jXSgMOoPYl0ZE6i+EU5Ml98lFhlQVALREV7J79KgIWGpjwyIT9LAZH9ov6z9
        IzMTyhxbgHgenk5uFB8wxm7ry6Zvw+BbV+l/R2eVnrZEFEQ6syCQtoaFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LObIfc2uPqHaLEu4S6D78Ua8XtedAN9FGhZ26j8yxQA=; b=vfXbYVrV
        vd+YtAWNMgMe8lzfTCJoxlSFDDhe9LXb5vPyMLdl5I4Ue0Q2FP2kwAd9kABnCJCt
        xhV+ohacF3k3v+jztHGFEM/oQV9FcWJ8xNUSDAp6NA0FmQZ7dToV7ZTx1Bx+H1xU
        H6NwDZHOeAKUs1HEA52PL6m03ADs6ezLsZCrQ39NDbjU/J2JpoodQKDuPtmy1Q7R
        ku7qF/rR2cdkWuQUOGF2nyJ6DcoRaB18Cl51xD9/AJayyZ3TtHf/VeYzxR4mEmxW
        2j75UdxmJpS8Pvxc7XHa6PNESeTIg694j73Kwwmi60soUXTW6j37rmJ3ZMWcI+dR
        +KfExCtHBlEUrQ==
X-ME-Sender: <xms:v5JTXjrMXTjlfx_By7AhMmkHJN0BiyxyQxuiQjbJYR5vKsfHfs7qMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgepudejnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:v5JTXuV-k2XhPX1eMfPPch0im3W9qGeqT553eOWVaG8Nn2Hl54ERfg>
    <xmx:v5JTXuaZn5zcL9uqUR_HhjMP6UnQC4JLGUFvY6z9xB5z91xf8jd7nA>
    <xmx:v5JTXreKjrpXjRwhcU_7Mk0j6ZxJjcMagtkjWOndeG6xsH6xWkPXUw>
    <xmx:wJJTXscKO0QPRpnaCvhRxk2WSJtg19EjLxEWjs8dLfVT3gJtnYtYJcwbR8o>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id A32D83060BD1;
        Mon, 24 Feb 2020 04:09:19 -0500 (EST)
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
Subject: [PATCH 21/89] clk: bcm: rpi: Add DT provider for the clocks
Date:   Mon, 24 Feb 2020 10:06:23 +0100
Message-Id: <f38e173f73f9c9c06291d96d095f5a42002720c9.1582533919.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming registration of the clocks provided by the firmware, make
sure it's exposed to the device tree providers.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index db5de9073930..3f21888a3e3e 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -31,6 +31,8 @@
 
 #define A2W_PLL_FRAC_BITS		20
 
+#define NUM_FW_CLKS			16
+
 struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
@@ -285,6 +287,7 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data;
 	struct device_node *firmware_node;
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
@@ -309,6 +312,11 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	rpi->firmware = firmware;
 	platform_set_drvdata(pdev, rpi);
 
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS),
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
 	hw = raspberrypi_register_pllb(rpi);
 	if (IS_ERR(hw)) {
 		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
@@ -318,6 +326,13 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	hw = raspberrypi_register_pllb_arm(rpi);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+	clk_data->hws[RPI_FIRMWARE_ARM_CLK_ID] = hw;
+	clk_data->num = RPI_FIRMWARE_ARM_CLK_ID + 1;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data);
+	if (ret)
+		return ret;
 
 	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
 						     -1, NULL, 0);
-- 
git-series 0.9.1
