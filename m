Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE517EBBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCIWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgCIWMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:12:34 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B1624670;
        Mon,  9 Mar 2020 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583791953;
        bh=h8sakRMv+8CrKCgzzo0hVw4JtHbhRi2pD9uJg0Qwmcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9WOrBjWKLT56MoLZT4EI7kxCaZi3nZFVGmh14/1ZCqfcP7F2wnx34Rm7BwTsFioU
         K+j0KBVwGz8j4ewCUdgxGDoaB0AvofWSpET39X4NPhwFDjiHIXscm9ziY6JrphkQKK
         Q9MB6uexbKRWK2HDnMC2SlMmRe1PgihkjKME8X8Y=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 1/2] clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()
Date:   Mon,  9 Mar 2020 15:12:31 -0700
Message-Id: <20200309221232.145630-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309221232.145630-1-sboyd@kernel.org>
References: <20200309221232.145630-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has some duplication in unlocking a mutex and returns in a
few different places. Let's use some if statements to consolidate code
and make this a bit easier to read.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index bfc29aec3a78..b1b277b55682 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -259,38 +259,33 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 {
 	struct tcs_cmd cmd = { 0 };
 	u32 cmd_state;
-	int ret;
+	int ret = 0;
 
 	mutex_lock(&rpmh_clk_lock);
-
-	cmd_state = 0;
 	if (enable) {
 		cmd_state = 1;
 		if (c->aggr_state)
 			cmd_state = c->aggr_state;
+	} else {
+		cmd_state = 0;
 	}
 
-	if (c->last_sent_aggr_state == cmd_state) {
-		mutex_unlock(&rpmh_clk_lock);
-		return 0;
-	}
-
-	cmd.addr = c->res_addr;
-	cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
+	if (c->last_sent_aggr_state != cmd_state) {
+		cmd.addr = c->res_addr;
+		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
 
-	ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
-	if (ret) {
-		dev_err(c->dev, "set active state of %s failed: (%d)\n",
-			c->res_name, ret);
-		mutex_unlock(&rpmh_clk_lock);
-		return ret;
+		ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
+		if (ret) {
+			dev_err(c->dev, "set active state of %s failed: (%d)\n",
+				c->res_name, ret);
+		} else {
+			c->last_sent_aggr_state = cmd_state;
+		}
 	}
 
-	c->last_sent_aggr_state = cmd_state;
-
 	mutex_unlock(&rpmh_clk_lock);
 
-	return 0;
+	return ret;
 }
 
 static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
-- 
Sent by a computer, using git, on the internet

