Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD968EFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHOQAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 12:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbfHOQAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:00:23 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A252133F;
        Thu, 15 Aug 2019 16:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565884822;
        bh=gocEmGOTZWJfwU63JkLjs2GgZL/h/Eci4v4XP4SbSVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Apy6m9Syl5bjhUbw6eI9DRferjvCLnyi2XhRcBYxLS0PIg8LpMQa/cCkFQHrlXaEa
         cVYueYZa/D+7v8yhcGtXYuZOnNsrsH9z0KafKViDTcGB9jGRzvVM9eVOiyBHvAXzGE
         KRPBOuFUA8K68t49izdlhbTRW7kK03YpdHZpQiSU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: [PATCH 1/4] clk: milbeaut:  Don't reference clk_init_data after registration
Date:   Thu, 15 Aug 2019 09:00:17 -0700
Message-Id: <20190815160020.183334-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190815160020.183334-1-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Sugaya Taichi <sugaya.taichi@socionext.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-milbeaut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-milbeaut.c b/drivers/clk/clk-milbeaut.c
index 5fc78faf820c..80b9d78493bc 100644
--- a/drivers/clk/clk-milbeaut.c
+++ b/drivers/clk/clk-milbeaut.c
@@ -437,7 +437,7 @@ static int m10v_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 		if (readl_poll_timeout(divider->write_valid_reg, val,
 			!val, M10V_UPOLL_RATE, M10V_UTIMEOUT))
 			pr_err("%s:%s couldn't stabilize\n",
-				__func__, divider->hw.init->name);
+				__func__, clk_hw_get_name(hw));
 	}
 
 	if (divider->lock)
-- 
Sent by a computer through tubes

