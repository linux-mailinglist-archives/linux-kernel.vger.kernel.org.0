Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE98102BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2019 19:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfKSSs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 13:48:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKSSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:48:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id j12so12229678plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16iK/qodEsZEc13MhbzkhVSjJ5tU0A4IyunR6br7n40=;
        b=nxbeYZk/f9Hsl3iCWNMSxDHtTdUiWPToOeg9Eu4gWgjYDk1bo/sHEUOL5kbZ0HvFdr
         4IOzv+wloKTAAslqfjlZRqxb4DrdCbIP2O5Ta2vxPH+5sNhVUj+4P6GraS9L3OH4WphY
         5Olb9PFF4hFOI+Sf4Oaov9DfBYCzVrDIMyLmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16iK/qodEsZEc13MhbzkhVSjJ5tU0A4IyunR6br7n40=;
        b=n9rxQO3h/XwKKbePW6Po1zp2ru5+flmEgJVTsA6+tQAyRZWQbmufY5H9rOOyHLoTqG
         QluiTxlov8L+5CwRBIgR9oHN2sC48zlQ6XblVs+RLM74iRGRzYg4ygu+tKAAg1G/GY+d
         KsPGG4FLFDpZzXxtbtZcAM5fFdtVbZnQYEwsbZD9R5F4TD37mNUatSCQhd/ayoZhmR6J
         /HuGC499p9feolGDjvKS9kRSiTPFIEPp69ZF0/YBDAiIfIYyR8Q7Qbppcfe/CJByaw2z
         Afibk+ZhFJqgg5RVTe/WSLHSU37nA3/n/QyGFjANK8YssLQfhi1LpY5Rs9/iIq7xk61v
         dFMA==
X-Gm-Message-State: APjAAAVH61RLeAKAmky3YODrcSTB1LCPsFgwgqNa2/EiuQnW2DX6y2hG
        LzChV0rvexQRtRi7SClu+n0yqQ==
X-Google-Smtp-Source: APXvYqyB7pCfZUPOLj6YBYWXv8jFgx9sCeSJqBJAi5bZxKygN9RUDSgaEKJxLWbcaGV2wZbuiUh2Xg==
X-Received: by 2002:a17:902:bd45:: with SMTP id b5mr11443070plx.247.1574189334417;
        Tue, 19 Nov 2019 10:48:54 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i26sm19920567pfr.151.2019.11.19.10.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:48:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm/dpu: Mark various data tables as const
Date:   Tue, 19 Nov 2019 10:48:53 -0800
Message-Id: <20191119184853.107512-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These structures look like a bunch of data tables that aren't going to
change after boot. Let's move them to the const RO section of memory so
that they can't be modified at runtime on modern machines.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 30 +++++++++----------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    | 26 ++++++++--------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c    |  8 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h    |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c   |  8 ++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c     | 10 +++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h     |  2 +-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   |  8 ++---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   |  4 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        |  6 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c      |  6 ++--
 14 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 04c8c44f5b9c..dd096b6b7bfa 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -60,7 +60,7 @@ static const struct dpu_caps sdm845_dpu_caps = {
 	.has_idle_pc = true,
 };
 
-static struct dpu_mdp_cfg sdm845_mdp[] = {
+static const struct dpu_mdp_cfg sdm845_mdp[] = {
 	{
 	.name = "top_0", .id = MDP_TOP,
 	.base = 0x0, .len = 0x45C,
@@ -88,7 +88,7 @@ static struct dpu_mdp_cfg sdm845_mdp[] = {
 /*************************************************************
  * CTL sub blocks config
  *************************************************************/
-static struct dpu_ctl_cfg sdm845_ctl[] = {
+static const struct dpu_ctl_cfg sdm845_ctl[] = {
 	{
 	.name = "ctl_0", .id = CTL_0,
 	.base = 0x1000, .len = 0xE4,
@@ -184,7 +184,7 @@ static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK("11", 4);
 	.clk_ctrl = _clkctrl \
 	}
 
-static struct dpu_sspp_cfg sdm845_sspp[] = {
+static const struct dpu_sspp_cfg sdm845_sspp[] = {
 	SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SDM845_MASK,
 		sdm845_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
 	SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SDM845_MASK,
@@ -225,7 +225,7 @@ static const struct dpu_lm_sub_blks sdm845_lm_sblk = {
 	.lm_pair_mask = (1 << _lmpair) \
 	}
 
-static struct dpu_lm_cfg sdm845_lm[] = {
+static const struct dpu_lm_cfg sdm845_lm[] = {
 	LM_BLK("lm_0", LM_0, 0x44000, PINGPONG_0, LM_1),
 	LM_BLK("lm_1", LM_1, 0x45000, PINGPONG_1, LM_0),
 	LM_BLK("lm_2", LM_2, 0x46000, PINGPONG_2, LM_5),
@@ -264,7 +264,7 @@ static const struct dpu_pingpong_sub_blks sdm845_pp_sblk = {
 	.sblk = &sdm845_pp_sblk \
 	}
 
-static struct dpu_pingpong_cfg sdm845_pp[] = {
+static const struct dpu_pingpong_cfg sdm845_pp[] = {
 	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x70000),
 	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x70800),
 	PP_BLK("pingpong_2", PINGPONG_2, 0x71000),
@@ -283,7 +283,7 @@ static struct dpu_pingpong_cfg sdm845_pp[] = {
 	.prog_fetch_lines_worst_case = 24 \
 	}
 
-static struct dpu_intf_cfg sdm845_intf[] = {
+static const struct dpu_intf_cfg sdm845_intf[] = {
 	INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0),
 	INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0),
 	INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1),
@@ -294,10 +294,10 @@ static struct dpu_intf_cfg sdm845_intf[] = {
  * VBIF sub blocks config
  *************************************************************/
 /* VBIF QOS remap */
-static u32 sdm845_rt_pri_lvl[] = {3, 3, 4, 4, 5, 5, 6, 6};
-static u32 sdm845_nrt_pri_lvl[] = {3, 3, 3, 3, 3, 3, 3, 3};
+static const u32 sdm845_rt_pri_lvl[] = {3, 3, 4, 4, 5, 5, 6, 6};
+static const u32 sdm845_nrt_pri_lvl[] = {3, 3, 3, 3, 3, 3, 3, 3};
 
-static struct dpu_vbif_cfg sdm845_vbif[] = {
+static const struct dpu_vbif_cfg sdm845_vbif[] = {
 	{
 	.name = "vbif_0", .id = VBIF_0,
 	.base = 0, .len = 0x1040,
@@ -316,7 +316,7 @@ static struct dpu_vbif_cfg sdm845_vbif[] = {
 	},
 };
 
-static struct dpu_reg_dma_cfg sdm845_regdma = {
+static const struct dpu_reg_dma_cfg sdm845_regdma = {
 	.base = 0x0, .version = 0x1, .trigger_sel_off = 0x119c
 };
 
@@ -325,7 +325,7 @@ static struct dpu_reg_dma_cfg sdm845_regdma = {
  *************************************************************/
 
 /* SSPP QOS LUTs */
-static struct dpu_qos_lut_entry sdm845_qos_linear[] = {
+static const struct dpu_qos_lut_entry sdm845_qos_linear[] = {
 	{.fl = 4, .lut = 0x357},
 	{.fl = 5, .lut = 0x3357},
 	{.fl = 6, .lut = 0x23357},
@@ -340,7 +340,7 @@ static struct dpu_qos_lut_entry sdm845_qos_linear[] = {
 	{.fl = 0, .lut = 0x11222222223357}
 };
 
-static struct dpu_qos_lut_entry sdm845_qos_macrotile[] = {
+static const struct dpu_qos_lut_entry sdm845_qos_macrotile[] = {
 	{.fl = 10, .lut = 0x344556677},
 	{.fl = 11, .lut = 0x3344556677},
 	{.fl = 12, .lut = 0x23344556677},
@@ -349,11 +349,11 @@ static struct dpu_qos_lut_entry sdm845_qos_macrotile[] = {
 	{.fl = 0, .lut = 0x112233344556677},
 };
 
-static struct dpu_qos_lut_entry sdm845_qos_nrt[] = {
+static const struct dpu_qos_lut_entry sdm845_qos_nrt[] = {
 	{.fl = 0, .lut = 0x0},
 };
 
-static struct dpu_perf_cfg sdm845_perf_data = {
+static const struct dpu_perf_cfg sdm845_perf_data = {
 	.max_bw_low = 6800000,
 	.max_bw_high = 6800000,
 	.min_core_ib = 2400000,
@@ -424,7 +424,7 @@ static void sdm845_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
 	};
 }
 
-static struct dpu_mdss_hw_cfg_handler cfg_handler[] = {
+static const struct dpu_mdss_hw_cfg_handler cfg_handler[] = {
 	{ .hw_rev = DPU_HW_VER_400, .cfg_init = sdm845_cfg_init},
 	{ .hw_rev = DPU_HW_VER_401, .cfg_init = sdm845_cfg_init},
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index ec76b8687a98..79875195cd9c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -269,7 +269,7 @@ struct dpu_qos_lut_entry {
  */
 struct dpu_qos_lut_tbl {
 	u32 nentry;
-	struct dpu_qos_lut_entry *entries;
+	const struct dpu_qos_lut_entry *entries;
 };
 
 /**
@@ -511,7 +511,7 @@ struct dpu_vbif_dynamic_ot_cfg {
  */
 struct dpu_vbif_dynamic_ot_tbl {
 	u32 count;
-	struct dpu_vbif_dynamic_ot_cfg *cfg;
+	const struct dpu_vbif_dynamic_ot_cfg *cfg;
 };
 
 /**
@@ -521,7 +521,7 @@ struct dpu_vbif_dynamic_ot_tbl {
  */
 struct dpu_vbif_qos_tbl {
 	u32 npriority_lvl;
-	u32 *priority_lvl;
+	const u32 *priority_lvl;
 };
 
 /**
@@ -653,25 +653,25 @@ struct dpu_mdss_cfg {
 	const struct dpu_caps *caps;
 
 	u32 mdp_count;
-	struct dpu_mdp_cfg *mdp;
+	const struct dpu_mdp_cfg *mdp;
 
 	u32 ctl_count;
-	struct dpu_ctl_cfg *ctl;
+	const struct dpu_ctl_cfg *ctl;
 
 	u32 sspp_count;
-	struct dpu_sspp_cfg *sspp;
+	const struct dpu_sspp_cfg *sspp;
 
 	u32 mixer_count;
-	struct dpu_lm_cfg *mixer;
+	const struct dpu_lm_cfg *mixer;
 
 	u32 pingpong_count;
-	struct dpu_pingpong_cfg *pingpong;
+	const struct dpu_pingpong_cfg *pingpong;
 
 	u32 intf_count;
-	struct dpu_intf_cfg *intf;
+	const struct dpu_intf_cfg *intf;
 
 	u32 vbif_count;
-	struct dpu_vbif_cfg *vbif;
+	const struct dpu_vbif_cfg *vbif;
 
 	u32 reg_dma_count;
 	struct dpu_reg_dma_cfg dma_cfg;
@@ -681,9 +681,9 @@ struct dpu_mdss_cfg {
 	/* Add additional block data structures here */
 
 	struct dpu_perf_cfg perf;
-	struct dpu_format_extended *dma_formats;
-	struct dpu_format_extended *cursor_formats;
-	struct dpu_format_extended *vig_formats;
+	const struct dpu_format_extended *dma_formats;
+	const struct dpu_format_extended *cursor_formats;
+	const struct dpu_format_extended *vig_formats;
 };
 
 struct dpu_mdss_hw_cfg_handler {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 179e8d52cadb..d3a96f350cad 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -28,8 +28,8 @@
 
 #define DPU_REG_RESET_TIMEOUT_US        2000
 
-static struct dpu_ctl_cfg *_ctl_offset(enum dpu_ctl ctl,
-		struct dpu_mdss_cfg *m,
+static const struct dpu_ctl_cfg *_ctl_offset(enum dpu_ctl ctl,
+		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,
 		struct dpu_hw_blk_reg_map *b)
 {
@@ -476,10 +476,10 @@ static struct dpu_hw_blk_ops dpu_hw_ops;
 
 struct dpu_hw_ctl *dpu_hw_ctl_init(enum dpu_ctl idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m)
+		const struct dpu_mdss_cfg *m)
 {
 	struct dpu_hw_ctl *c;
-	struct dpu_ctl_cfg *cfg;
+	const struct dpu_ctl_cfg *cfg;
 
 	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
index d3ae939ef9f8..b92aaee69f78 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
@@ -195,7 +195,7 @@ static inline struct dpu_hw_ctl *to_dpu_hw_ctl(struct dpu_hw_blk *hw)
  */
 struct dpu_hw_ctl *dpu_hw_ctl_init(enum dpu_ctl idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m);
+		const struct dpu_mdss_cfg *m);
 
 /**
  * dpu_hw_ctl_destroy(): Destroys ctl driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
index dcd87cda13fe..85b32ec18609 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
@@ -56,8 +56,8 @@
 #define   INTF_FRAME_COUNT              0x0AC
 #define   INTF_LINE_COUNT               0x0B0
 
-static struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
-		struct dpu_mdss_cfg *m,
+static const struct dpu_intf_cfg *_intf_offset(enum dpu_intf intf,
+		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,
 		struct dpu_hw_blk_reg_map *b)
 {
@@ -260,10 +260,10 @@ static struct dpu_hw_blk_ops dpu_hw_ops;
 
 struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m)
+		const struct dpu_mdss_cfg *m)
 {
 	struct dpu_hw_intf *c;
-	struct dpu_intf_cfg *cfg;
+	const struct dpu_intf_cfg *cfg;
 
 	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
index b03acc225c9b..fb8ff05970c6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
@@ -92,7 +92,7 @@ struct dpu_hw_intf {
  */
 struct dpu_hw_intf *dpu_hw_intf_init(enum dpu_intf idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m);
+		const struct dpu_mdss_cfg *m);
 
 /**
  * dpu_hw_intf_destroy(): Destroys INTF driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 5bc39baa746a..55ea90ce80cc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -24,8 +24,8 @@
 #define LM_BLEND0_FG_ALPHA               0x04
 #define LM_BLEND0_BG_ALPHA               0x08
 
-static struct dpu_lm_cfg *_lm_offset(enum dpu_lm mixer,
-		struct dpu_mdss_cfg *m,
+static const struct dpu_lm_cfg *_lm_offset(enum dpu_lm mixer,
+		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,
 		struct dpu_hw_blk_reg_map *b)
 {
@@ -147,7 +147,7 @@ static void dpu_hw_lm_setup_color3(struct dpu_hw_mixer *ctx,
 	DPU_REG_WRITE(c, LM_OP_MODE, op_mode);
 }
 
-static void _setup_mixer_ops(struct dpu_mdss_cfg *m,
+static void _setup_mixer_ops(const struct dpu_mdss_cfg *m,
 		struct dpu_hw_lm_ops *ops,
 		unsigned long features)
 {
@@ -164,10 +164,10 @@ static struct dpu_hw_blk_ops dpu_hw_ops;
 
 struct dpu_hw_mixer *dpu_hw_lm_init(enum dpu_lm idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m)
+		const struct dpu_mdss_cfg *m)
 {
 	struct dpu_hw_mixer *c;
-	struct dpu_lm_cfg *cfg;
+	const struct dpu_lm_cfg *cfg;
 
 	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
index 147ace31cfc2..4a6b2de19ef6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h
@@ -91,7 +91,7 @@ static inline struct dpu_hw_mixer *to_dpu_hw_mixer(struct dpu_hw_blk *hw)
  */
 struct dpu_hw_mixer *dpu_hw_lm_init(enum dpu_lm idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m);
+		const struct dpu_mdss_cfg *m);
 
 /**
  * dpu_hw_lm_destroy(): Destroys layer mixer driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 5dbaba9fd180..d110a40f0e73 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -28,8 +28,8 @@
 #define PP_FBC_BUDGET_CTL               0x038
 #define PP_FBC_LOSSY_MODE               0x03C
 
-static struct dpu_pingpong_cfg *_pingpong_offset(enum dpu_pingpong pp,
-		struct dpu_mdss_cfg *m,
+static const struct dpu_pingpong_cfg *_pingpong_offset(enum dpu_pingpong pp,
+		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,
 		struct dpu_hw_blk_reg_map *b)
 {
@@ -195,10 +195,10 @@ static struct dpu_hw_blk_ops dpu_hw_ops;
 
 struct dpu_hw_pingpong *dpu_hw_pingpong_init(enum dpu_pingpong idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m)
+		const struct dpu_mdss_cfg *m)
 {
 	struct dpu_hw_pingpong *c;
-	struct dpu_pingpong_cfg *cfg;
+	const struct dpu_pingpong_cfg *cfg;
 
 	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index 58bdb9279aa8..3d6f46b1db30 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -106,7 +106,7 @@ struct dpu_hw_pingpong {
  */
 struct dpu_hw_pingpong *dpu_hw_pingpong_init(enum dpu_pingpong idx,
 		void __iomem *addr,
-		struct dpu_mdss_cfg *m);
+		const struct dpu_mdss_cfg *m);
 
 /**
  * dpu_hw_pingpong_destroy - destroys pingpong driver context
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 4f8b813aab81..a315c54b5a64 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -666,7 +666,7 @@ static void _setup_layer_ops(struct dpu_hw_pipe *c,
 		c->ops.setup_cdp = dpu_hw_sspp_setup_cdp;
 }
 
-static struct dpu_sspp_cfg *_sspp_offset(enum dpu_sspp sspp,
+static const struct dpu_sspp_cfg *_sspp_offset(enum dpu_sspp sspp,
 		void __iomem *addr,
 		struct dpu_mdss_cfg *catalog,
 		struct dpu_hw_blk_reg_map *b)
@@ -696,7 +696,7 @@ struct dpu_hw_pipe *dpu_hw_sspp_init(enum dpu_sspp idx,
 		bool is_virtual_pipe)
 {
 	struct dpu_hw_pipe *hw_pipe;
-	struct dpu_sspp_cfg *cfg;
+	const struct dpu_sspp_cfg *cfg;
 
 	if (!addr || !catalog)
 		return ERR_PTR(-EINVAL);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
index a3680b482b41..31ec12d03bcd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h
@@ -373,7 +373,7 @@ struct dpu_hw_pipe {
 	struct dpu_hw_blk base;
 	struct dpu_hw_blk_reg_map hw;
 	struct dpu_mdss_cfg *catalog;
-	struct dpu_mdp_cfg *mdp;
+	const struct dpu_mdp_cfg *mdp;
 
 	/* Pipe */
 	enum dpu_sspp idx;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index ddc8412731af..23f5b1433b35 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -141,11 +141,11 @@ int dpu_rm_destroy(struct dpu_rm *rm)
 
 static int _dpu_rm_hw_blk_create(
 		struct dpu_rm *rm,
-		struct dpu_mdss_cfg *cat,
+		const struct dpu_mdss_cfg *cat,
 		void __iomem *mmio,
 		enum dpu_hw_blk_type type,
 		uint32_t id,
-		void *hw_catalog_info)
+		const void *hw_catalog_info)
 {
 	struct dpu_rm_hw_blk *blk;
 	void *hw;
@@ -215,7 +215,7 @@ int dpu_rm_init(struct dpu_rm *rm,
 
 	/* Interrogate HW catalog and create tracking items for hw blocks */
 	for (i = 0; i < cat->mixer_count; i++) {
-		struct dpu_lm_cfg *lm = &cat->mixer[i];
+		const struct dpu_lm_cfg *lm = &cat->mixer[i];
 
 		if (lm->pingpong == PINGPONG_MAX) {
 			DPU_DEBUG("skip mixer %d without pingpong\n", lm->id);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
index 991f4c8f8a12..93ab36bd8df3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
@@ -299,7 +299,7 @@ void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root)
 	entry = debugfs_create_dir("vbif", debugfs_root);
 
 	for (i = 0; i < dpu_kms->catalog->vbif_count; i++) {
-		struct dpu_vbif_cfg *vbif = &dpu_kms->catalog->vbif[i];
+		const struct dpu_vbif_cfg *vbif = &dpu_kms->catalog->vbif[i];
 
 		snprintf(vbif_name, sizeof(vbif_name), "%d", vbif->id);
 
@@ -318,7 +318,7 @@ void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root)
 			(u32 *)&vbif->default_ot_wr_limit);
 
 		for (j = 0; j < vbif->dynamic_ot_rd_tbl.count; j++) {
-			struct dpu_vbif_dynamic_ot_cfg *cfg =
+			const struct dpu_vbif_dynamic_ot_cfg *cfg =
 					&vbif->dynamic_ot_rd_tbl.cfg[j];
 
 			snprintf(vbif_name, sizeof(vbif_name),
@@ -332,7 +332,7 @@ void dpu_debugfs_vbif_init(struct dpu_kms *dpu_kms, struct dentry *debugfs_root)
 		}
 
 		for (j = 0; j < vbif->dynamic_ot_wr_tbl.count; j++) {
-			struct dpu_vbif_dynamic_ot_cfg *cfg =
+			const struct dpu_vbif_dynamic_ot_cfg *cfg =
 					&vbif->dynamic_ot_wr_tbl.cfg[j];
 
 			snprintf(vbif_name, sizeof(vbif_name),
-- 
Sent by a computer through tubes

