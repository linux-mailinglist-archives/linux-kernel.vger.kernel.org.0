Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D49D500
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfHZRc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 13:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbfHZRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:32:54 -0400
Received: from localhost.localdomain (unknown [122.178.200.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5AE021872;
        Mon, 26 Aug 2019 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566840773;
        bh=/bpf7xC2H//gRGlYPbogjUfpowEtufJcXobWye4Cnlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku/zyUq//J5sP5b/Jc4aUd/6Qs8Ci3Ac9uMLwlQI2K4DUTxDW1HXebjnTDhl1RB1S
         eUX9JmFeIGQjvCqit+C980G5SLh9DnmmZ8NjkBtNT86E7B9MMdTxTSZGTDA/HYJcWt
         cI+GHVXUB/KIWGVbVy72ZT4uZAtNFgagPaiU4Q0E=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Date:   Mon, 26 Aug 2019 23:01:18 +0530
Message-Id: <20190826173120.2971-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826173120.2971-1-vkoul@kernel.org>
References: <20190826173120.2971-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rpmh clock driver to use the new parent data scheme by
specifying the parent data for board clock.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c3fd632af119..35d55aee6a01 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name,					\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo",		\
+					.name = "xo_board",		\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	};								\
@@ -110,7 +113,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name_active,				\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo",		\
+					.name = "xo_board",		\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	}
-- 
2.20.1

