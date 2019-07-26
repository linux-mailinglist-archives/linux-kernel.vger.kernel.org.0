Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25487696F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 15:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfGZNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 09:52:04 -0400
Received: from foss.arm.com ([217.140.110.172]:44550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388680AbfGZNwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:52:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06B9F152D;
        Fri, 26 Jul 2019 06:52:02 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8C9303F694;
        Fri, 26 Jul 2019 06:52:00 -0700 (PDT)
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
Subject: [PATCH v2 10/10] firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible
Date:   Fri, 26 Jul 2019 14:51:38 +0100
Message-Id: <20190726135138.9858-11-sudeep.holla@arm.com>
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

Tracking the current count of pending asynchronous clock set rate
requests, we can decide if the incoming/new request for clock set rate
can be handled asynchronously or not until the maximum limit is
reached.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index dd215bd11a58..4a32ae1822a3 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -56,7 +56,7 @@ struct scmi_msg_resp_clock_describe_rates {
 struct scmi_clock_set_rate {
 	__le32 flags;
 #define CLOCK_SET_ASYNC		BIT(0)
-#define CLOCK_SET_DELAYED	BIT(1)
+#define CLOCK_SET_IGNORE_RESP	BIT(1)
 #define CLOCK_SET_ROUND_UP	BIT(2)
 #define CLOCK_SET_ROUND_AUTO	BIT(3)
 	__le32 id;
@@ -67,6 +67,7 @@ struct scmi_clock_set_rate {
 struct clock_info {
 	int num_clocks;
 	int max_async_req;
+	atomic_t cur_async_req;
 	struct scmi_clock_info *clk;
 };
 
@@ -221,21 +222,33 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 			       u64 rate)
 {
 	int ret;
+	u32 flags = 0;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
+	struct clock_info *ci = handle->clk_priv;
 
 	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
+	if (ci->max_async_req &&
+	    atomic_inc_return(&ci->cur_async_req) < ci->max_async_req)
+		flags |= CLOCK_SET_ASYNC;
+
 	cfg = t->tx.buf;
-	cfg->flags = cpu_to_le32(0);
+	cfg->flags = cpu_to_le32(flags);
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
-	ret = scmi_do_xfer(handle, t);
+	if (flags & CLOCK_SET_ASYNC)
+		ret = scmi_do_xfer_with_response(handle, t);
+	else
+		ret = scmi_do_xfer(handle, t);
+
+	if (ci->max_async_req)
+		atomic_dec(&ci->cur_async_req);
 
 	scmi_xfer_put(handle, t);
 	return ret;
-- 
2.17.1

