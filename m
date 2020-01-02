Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D8812E166
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 01:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgABAzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 19:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgABAzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 19:55:04 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C823520672;
        Thu,  2 Jan 2020 00:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577926504;
        bh=02ddkc4IuEFd4qv72kki08C8Gcv7p2IILwkeVV46LsE=;
        h=From:To:Cc:Subject:Date:From;
        b=nHQzcjMQQC39TSD7OPgfPBTs3oMg7Zrkg9UsB6Qw+1P1Fp3OlC3ZfDWS+7mrNJefg
         H6Fy+IhS4DTnEETy5gxA/Bke33bbNr4Ha1NsEqlUR7VxHB/46kj4natL01NEHtKNwi
         H/L9N5zhMJjkOEkhCToIEmPMtlUCZ6oEoUUCOy9E=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] clk: Warn about critical clks that fail to enable
Date:   Wed,  1 Jan 2020 16:55:03 -0800
Message-Id: <20200102005503.71923-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't warn here users of the CLK_IS_CRITICAL flag may not know
that their clk isn't actually enabled because it silently fails to
enable. Let's print a warning in that case so developers find these
problems faster.

Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Changes from v1:
 * Switched to pr_warn and indicated clk name

 drivers/clk/clk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 772258de2d1f..b03c2be4014b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3427,13 +3427,18 @@ static int __clk_core_init(struct clk_core *core)
 		unsigned long flags;
 
 		ret = clk_core_prepare(core);
-		if (ret)
+		if (ret) {
+			pr_warn("%s: critical clk '%s' failed to prepare\n",
+			       __func__, core->name);
 			goto out;
+		}
 
 		flags = clk_enable_lock();
 		ret = clk_core_enable(core);
 		clk_enable_unlock(flags);
 		if (ret) {
+			pr_warn("%s: critical clk '%s' failed to enable\n",
+			       __func__, core->name);
 			clk_core_unprepare(core);
 			goto out;
 		}

base-commit: 12ead77432f2ce32dea797742316d15c5800cb32
-- 
Sent by a computer, using git, on the internet

