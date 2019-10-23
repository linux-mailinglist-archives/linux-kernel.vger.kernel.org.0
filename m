Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0D6E2011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392502AbfJWQAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 12:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390259AbfJWQAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:00:24 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C54020640;
        Wed, 23 Oct 2019 16:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571846424;
        bh=9unFG5jOth/SLmbsma9VXKmXB1glCuVYpFM25V1tJhc=;
        h=From:To:Cc:Subject:Date:From;
        b=bPqudU3bKvdvVC6f9Fca0bV2hsZ6QP68bieoJIzFLkljzYGj9nSOZrWDk/O/7kwZN
         KyC/Wl1UcDsjSVfBbMAekLhPO1QPblE6CB/x/9wbusmIWsKbK7p4AAQnkJkrArIJFY
         MZdFPKWP4zcmSp8OZE2h/Hr3PQsHzXCmvjYk/dwM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
Subject: [PATCH] clk: samsung: exynos5433: Add missing slab.h header for kfree()
Date:   Wed, 23 Oct 2019 18:00:00 +0200
Message-Id: <20191023160000.409-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of kfree() requires slab.h header.  Otherwise building on x86_64
with COMPILE_TEST fails with:

    drivers/clk/samsung/clk-exynos5433.c: In function ‘exynos5433_cmu_probe’:
    drivers/clk/samsung/clk-exynos5433.c:5598:4: error: implicit declaration of function ‘kfree’; did you mean ‘vfree’? [-Werror=implicit-function-declaration]

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5433.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 0b60316331a0..4b1aa9382ad2 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -13,6 +13,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include <dt-bindings/clock/exynos5433.h>
 
-- 
2.17.1

