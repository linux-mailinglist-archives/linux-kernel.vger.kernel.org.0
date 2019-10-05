Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA2CCA5F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2019 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfJEOTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 10:19:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40548 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfJEOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id d26so5421912pgl.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3NxA/Yr80iVxdKub81APPkpdy1Qml/Yl3GutfXi9RDc=;
        b=YrrSlKQWQDx5ylGAdfIauv3lHB9Oak4L4iNrX08dGdQzvNF/GVgM5ikcJkkw4Yoaod
         LtTeWc+LKQ3n+2Fa3x8B4YL2a3EMIGzcOcxkU5SVsUJRn2Ll8ktBt1Yej3mlX8Rfozcy
         Y6sMA31Cpm/jDWq/o0rSo969bolIAGnpTHibQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3NxA/Yr80iVxdKub81APPkpdy1Qml/Yl3GutfXi9RDc=;
        b=nY8WvUafMYX26kpRTAQcMkIJ85CHjLF4aBviTk3ZXCPo6gPY8ssf1Sh8mUfjyaGOpi
         nYzBWbtwoQGlvXr0LcTDL/3jfp9SCq1DneJtQPxcpVJXNhxswpxYzECtZoRRS3ijBNLk
         zQuhX2IKhUZAJSgw4qGJVQdhD30mvVLcqV0tXCTeh8KJuIdBKQm7u18vK6uCo3MueUk2
         haSKlPLsF5LTb/FTsMxV0Cj5xZOMsOZhxGmq+1SKlkPOUoutS/nZ5E3CyRQRmstfTOk4
         Q8WU1A+fzUkyRTjQHYuif+6I3TkLW9lE9FOwnv7F07nuPHFaIlJE1SAWZLTV8Nx+Nh0T
         fxNA==
X-Gm-Message-State: APjAAAUSWr0WyUO4HnLbaUwwzjsrlm3fy5kuaV2Q9GeZYGYKDIfVWalK
        t6iQXp6mhYcuaAbD3XNNdjgjKg==
X-Google-Smtp-Source: APXvYqwOS0LD2HS1m+5XKVlRht04+Vt6iAydlUtKPt+uRbbxb1fyadX5tNpeeaNlC31fEo7gW7E91A==
X-Received: by 2002:a65:5802:: with SMTP id g2mr22108678pgr.333.1570285180636;
        Sat, 05 Oct 2019 07:19:40 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:40 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 4/6] drm/sun4i: dsi: Add Allwinner A64 MIPI DSI support
Date:   Sat,  5 Oct 2019 19:49:11 +0530
Message-Id: <20191005141913.22020-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191005141913.22020-1-jagan@amarulasolutions.com>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so add compatible
for Allwinner A64 with uninitialized has_mod_clk driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6724a14c816d..e3aab815fa73 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1241,11 +1241,18 @@ static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_mipi_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_mipi_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_mipi_dsi,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3

