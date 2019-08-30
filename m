Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42987A39F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfH3PJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfH3PJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870132342B;
        Fri, 30 Aug 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177765;
        bh=/hnuajz4jZZo0tGrLg5f+zF+jCL6MFUKdWmwpFV9keM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U20X+7lB/NHeQ4emHTkTmhQlvT5181BW1tE0zMyXVAHJQYzvAqhRJZBcZjnymOZH0
         Ea3apXK8hGJXYaDzP/IdnADijDyzniLDuvTYwJ0FCaXu2Cx5uwqv0nOaVmwHz8s9ka
         bL9QSeFNCVQ5ZH2bWa2yEyfcB0z3igr5s5sVjvAw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 04/12] clk: fixed-rate: Move to_clk_fixed_rate() to C file
Date:   Fri, 30 Aug 2019 08:09:15 -0700
Message-Id: <20190830150923.259497-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of this macro is the fixed rate basic type. Move it there
to avoid polluting provider drivers.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 2 ++
 include/linux/clk-provider.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index f4044091907f..ba626661535b 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -24,6 +24,8 @@
  * parent - fixed parent.  No clk_set_parent support
  */
 
+#define to_clk_fixed_rate(_hw) container_of(_hw, struct clk_fixed_rate, hw)
+
 static unsigned long clk_fixed_rate_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 52c08fd0211c..028f7d3cea85 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -327,8 +327,6 @@ struct clk_fixed_rate {
 	unsigned long	fixed_accuracy;
 };
 
-#define to_clk_fixed_rate(_hw) container_of(_hw, struct clk_fixed_rate, hw)
-
 extern const struct clk_ops clk_fixed_rate_ops;
 struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
-- 
Sent by a computer through tubes

