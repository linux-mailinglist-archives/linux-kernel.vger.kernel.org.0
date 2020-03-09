Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9DA17EBC2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 23:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgCIWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 18:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:12:34 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51B824673;
        Mon,  9 Mar 2020 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583791954;
        bh=GzADGU/Q3vjNfc3qU133TiVe59BHAmKdHYoUdA2U4MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YP9/FeNCVMoh0jQChEYBLM2pUDwD4+4EMT87yxgaEzttLFQ82yQinmICxR1B0vwu7
         LxDjBoKMxfl9OGJ83/9R+45TlMkQV7Bzg7n9vTsselku8pPIS1EPR87HMzGDnSFTUP
         v+z3pZLFOvR1/6VUgZKI4U46MCU1ybB0gFh59/xg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 2/2] clk: qcom: rpmh: Drop unnecessary semicolons
Date:   Mon,  9 Mar 2020 15:12:32 -0700
Message-Id: <20200309221232.145630-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309221232.145630-1-sboyd@kernel.org>
References: <20200309221232.145630-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions end in }; which is just bad style. Remove the extra
semicolon.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index b1b277b55682..e2c669b08aff 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -227,7 +227,7 @@ static int clk_rpmh_prepare(struct clk_hw *hw)
 	mutex_unlock(&rpmh_clk_lock);
 
 	return ret;
-};
+}
 
 static void clk_rpmh_unprepare(struct clk_hw *hw)
 {
@@ -293,14 +293,14 @@ static int clk_rpmh_bcm_prepare(struct clk_hw *hw)
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
 	return clk_rpmh_bcm_send_cmd(c, true);
-};
+}
 
 static void clk_rpmh_bcm_unprepare(struct clk_hw *hw)
 {
 	struct clk_rpmh *c = to_clk_rpmh(hw);
 
 	clk_rpmh_bcm_send_cmd(c, false);
-};
+}
 
 static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long parent_rate)
@@ -316,7 +316,7 @@ static int clk_rpmh_bcm_set_rate(struct clk_hw *hw, unsigned long rate,
 		clk_rpmh_bcm_send_cmd(c, true);
 
 	return 0;
-};
+}
 
 static long clk_rpmh_round_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long *parent_rate)
-- 
Sent by a computer, using git, on the internet

