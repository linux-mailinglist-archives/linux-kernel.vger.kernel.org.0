Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5864150F8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 19:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgBCScz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 13:32:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39580 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbgBCScZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:32:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so6186968plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MSI4H+vnNphLw5faqHnp3MUeoFOi/IN1Hvdc+rKzdpI=;
        b=G8Vtypw/RNqQzQg3VnLhFdak5DkoUc8ryrZs0/uUNoGJwM3iV0UcLXCCgTMpW2FqKA
         ne86youblkp0dHwcngjbMbJvfYW4JAeILE76CM9i2oLehNtOIuzvMAdJkALL+YG/2DDk
         XZU494m7qYiWJVJljSJvPKsBjiwt01lf4A7Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MSI4H+vnNphLw5faqHnp3MUeoFOi/IN1Hvdc+rKzdpI=;
        b=oYIpXjNiXAgpJeUFTnMbWWKOQPJ73DMeeGAIPLwNZAGQhxN6wZV3rD+ND/ybiKx7Z4
         GCgJnzkcb0UxAeWybhgx1Bm//ENe+vMYAgU5fssbypSS0kZ8e740n6ob6AZb8G+wZ5SY
         xQlE85lF3+V961AGtXkza3rlsMrt1F/o42Rot3fd5qVLdubkeOh4MoEceMPfXdH7bYQm
         0hSPfGf9CqGMXEO7eG5WeRypUTDEhrAL4nitvDgVpJHTS5gjwAwjB8WhQH+uxnCU/5Zx
         8iwqS09KIq2X+bvpoeUEIOCXsbYCukuUDzfuUol0hM4AG7PD36FPT4+/IY/RSqQ8p1VT
         Y1Mw==
X-Gm-Message-State: APjAAAWgFm7bVDwh2r6PHkS4DhUl9a/BVUxYcYXdlJ8REGBjZLjj0iQR
        tbbvCVEExe1jfNNXGrlLoNqd7Q==
X-Google-Smtp-Source: APXvYqxvJ1a0WHUO+6L0QwAnAxg7hwdfBonPe9QIOwzL2WSLXD2DT7nit74XUErFZh+hHzWwMNSddA==
X-Received: by 2002:a17:90b:87:: with SMTP id bb7mr409616pjb.49.1580754744140;
        Mon, 03 Feb 2020 10:32:24 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id f9sm21009137pfd.141.2020.02.03.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 10:32:23 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/15] clk: qcom: Get rid of the test clock for gpucc-sc7180
Date:   Mon,  3 Feb 2020 10:31:42 -0800
Message-Id: <20200203103049.v4.9.I6d5276b768f6593053be036a3e70cce298d39f0c@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200203183149.73842-1-dianders@chromium.org>
References: <20200203183149.73842-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test clock isn't in the bindings and apparently it's not used by
anyone upstream.  Remove it.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4: None
Changes in v3:
- Patch ("clk: qcom: Get rid of the test...gpucc-sc7180") split out for v3.

Changes in v2: None

 drivers/clk/qcom/gpucc-sc7180.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sc7180.c b/drivers/clk/qcom/gpucc-sc7180.c
index ec61194cceaf..c88f00125775 100644
--- a/drivers/clk/qcom/gpucc-sc7180.c
+++ b/drivers/clk/qcom/gpucc-sc7180.c
@@ -60,7 +60,6 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
 	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
 	{ P_GPLL0_OUT_MAIN, 5 },
 	{ P_GPLL0_OUT_MAIN_DIV, 6 },
-	{ P_CORE_BI_PLL_TEST_SE, 7 },
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_0[] = {
@@ -68,7 +67,6 @@ static const struct clk_parent_data gpu_cc_parent_data_0[] = {
 	{ .hw = &gpu_cc_pll1.clkr.hw },
 	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
 	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
-	{ .fw_name = "core_bi_pll_test_se", .name = "core_bi_pll_test_se" },
 };
 
 static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
@@ -86,7 +84,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_data = gpu_cc_parent_data_0,
-		.num_parents = 5,
+		.num_parents = 4,
 		.flags = CLK_SET_RATE_PARENT,
 		.ops = &clk_rcg2_shared_ops,
 	},
-- 
2.25.0.341.g760bfbb309-goog

