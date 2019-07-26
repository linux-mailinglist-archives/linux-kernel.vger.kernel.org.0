Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5647C76974
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbfGZNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:52:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388498AbfGZNwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:52:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5718B337;
        Fri, 26 Jul 2019 06:52:00 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DC5123F694;
        Fri, 26 Jul 2019 06:51:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v2 09/10] firmware: arm_scmi: Drop config flag in clk_ops->rate_set
Date:   Fri, 26 Jul 2019 14:51:37 +0100
Message-Id: <20190726135138.9858-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
number of pending asynchronous clock rate changes supported by the
platform. If it's non-zero, then we should be able to use asynchronous
clock rate set for any clocks until the maximum limit is reached.

In order to add that support, let's drop the config flag passed to
clk_ops->rate_set and handle the asynchronous requests dynamically.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scmi.c            | 2 +-
 drivers/firmware/arm_scmi/clock.c | 4 ++--
 include/linux/scmi_protocol.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index a2287c770d5c..886f7c5df51a 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -69,7 +69,7 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, 0, rate);
+	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, rate);
 }
 
 static int scmi_clk_enable(struct clk_hw *hw)
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 0a194af92438..dd215bd11a58 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -218,7 +218,7 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
 }
 
 static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
-			       u32 config, u64 rate)
+			       u64 rate)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -230,7 +230,7 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 		return ret;
 
 	cfg = t->tx.buf;
-	cfg->flags = cpu_to_le32(config);
+	cfg->flags = cpu_to_le32(0);
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
 	cfg->value_high = cpu_to_le32(rate >> 32);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index ae7381413f1f..f0f2b53a1dac 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -71,7 +71,7 @@ struct scmi_clk_ops {
 	int (*rate_get)(const struct scmi_handle *handle, u32 clk_id,
 			u64 *rate);
 	int (*rate_set)(const struct scmi_handle *handle, u32 clk_id,
-			u32 config, u64 rate);
+			u64 rate);
 	int (*enable)(const struct scmi_handle *handle, u32 clk_id);
 	int (*disable)(const struct scmi_handle *handle, u32 clk_id);
 };
-- 
2.17.1

