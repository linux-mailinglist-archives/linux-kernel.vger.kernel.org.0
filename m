Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF14F8E3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 06:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfHOEZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 00:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfHOEZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:25:02 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DF1206C1;
        Thu, 15 Aug 2019 04:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565843101;
        bh=QCJFL84q5yDVzQW5SRwQhsQeYtiKywAt5IGPJyVK3dY=;
        h=From:To:Cc:Subject:Date:From;
        b=m5MKGdrQvPCS6uFk112joCYiDDbAmBWAyUQ1qW0c4EERo1bqWgOAFQCKmGYPwjccG
         xY3AG4oWdgd5W21WKejrqHWhleuYT+RTPmvTXUNbmARUz30EucPfIa8o/nYp5qLXsi
         9qTwM6lGy9uDp1ZZiq84mQTAnC1PG009pXGq8OKA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: composite: Drop unused clk.h include
Date:   Wed, 14 Aug 2019 21:25:00 -0700
Message-Id: <20190815042500.9519-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This include isn't used. Drop it.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-composite.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index b06038b8f658..4f13a681ddfc 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-- 
Sent by a computer through tubes

