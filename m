Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB61A3A02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfH3PKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 11:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbfH3PJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E3E23430;
        Fri, 30 Aug 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177766;
        bh=dtzf0VENnVWFnjkfoR2AZeV3+JNCo1HqEP7PxgaJH8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVgKS2wlzKCgST3tSgszxFYcWIzIR/3LMnsan85YA7NSSjNWwK125DmPFfcInoIn9
         w7fEMi4fC1Urg1tNMTwigvTAN/roE0y3LZ/4z9/FMIgfbf7xAMQPKM6diXNk2RaLGA
         Zke33WeBr2lrj6eaUE5wh3rpRTo8H1wS9Cfg8aPI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/12] clk: fixed-rate: Document accuracy member
Date:   Fri, 30 Aug 2019 08:09:16 -0700
Message-Id: <20190830150923.259497-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This member isn't documented, leading to kernel-doc warnings. Document
it.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 028f7d3cea85..473e9d85bac0 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -320,6 +320,7 @@ struct clk_hw {
  * struct clk_fixed_rate - fixed-rate clock
  * @hw:		handle between common and hardware-specific interfaces
  * @fixed_rate:	constant frequency of clock
+ * @fixed_accuracy: constant accuracy of clock in ppb (parts per billion)
  */
 struct clk_fixed_rate {
 	struct		clk_hw hw;
-- 
Sent by a computer through tubes

