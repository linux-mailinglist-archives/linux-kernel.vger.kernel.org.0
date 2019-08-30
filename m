Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3EA3A09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfH3PKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbfH3PJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD042342A;
        Fri, 30 Aug 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177765;
        bh=M3Fl0uQFBB1nB7g0eSzHp8Gkjc0rQVUxsBYc58NL1Ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mb9SoIQYAchwKNOyX9XLVV1AI0H5MpUnaNYXOr0yURusYgCVdbwjxiAxT1yykMvxE
         Iid4xCC1puokSs3ZcRdCSepqSTsVwReUGd8Kmdd5HUHm0QMkGD17G8o4rcDjomWGkN
         nFJ0G3HLvUf+m2lgg9rYPUue/l1YRXAd/3OP5xbk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/12] clk: fixed-rate: Remove clk_register_fixed_rate_with_accuracy()
Date:   Fri, 30 Aug 2019 08:09:14 -0700
Message-Id: <20190830150923.259497-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't any users of this API anymore. Remove it.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-fixed-rate.c | 23 +++++++----------------
 include/linux/clk-provider.h |  3 ---
 2 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index eed0be664c07..f4044091907f 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -89,20 +89,6 @@ struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_rate_with_accuracy);
 
-struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate, unsigned long fixed_accuracy)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
-			flags, fixed_rate, fixed_accuracy);
-	if (IS_ERR(hw))
-		return ERR_CAST(hw);
-	return hw->clk;
-}
-EXPORT_SYMBOL_GPL(clk_register_fixed_rate_with_accuracy);
-
 /**
  * clk_hw_register_fixed_rate - register fixed-rate clock with the clock
  * framework
@@ -125,8 +111,13 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate)
 {
-	return clk_register_fixed_rate_with_accuracy(dev, name, parent_name,
-						     flags, fixed_rate, 0);
+	struct clk_hw *hw;
+
+	hw = clk_hw_register_fixed_rate_with_accuracy(dev, name, parent_name,
+						      flags, fixed_rate, 0);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+	return hw->clk;
 }
 EXPORT_SYMBOL_GPL(clk_register_fixed_rate);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 32beac39e5a3..52c08fd0211c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -336,9 +336,6 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
 struct clk_hw *clk_hw_register_fixed_rate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		unsigned long fixed_rate);
-struct clk *clk_register_fixed_rate_with_accuracy(struct device *dev,
-		const char *name, const char *parent_name, unsigned long flags,
-		unsigned long fixed_rate, unsigned long fixed_accuracy);
 void clk_unregister_fixed_rate(struct clk *clk);
 struct clk_hw *clk_hw_register_fixed_rate_with_accuracy(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
Sent by a computer through tubes

