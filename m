Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F847FF9EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2019 15:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfKQOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 09:00:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32796 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:59:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so16397827wrr.0;
        Sun, 17 Nov 2019 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wYheJOg1NZzECr658le7NqXjuqImUz/Kw+GoeDiCAg0=;
        b=Ci1s6DmFUtw7M7Vs9pzJsGsOCzUinirsXZj6J48Hg0YKhROz57Hk+s2q26eJHg/1wV
         Lxr97WsLsrpsjq4IftTRlxBdkWZFGdlywbdBYglWo7hZUsHJQtv3K0+dONSpIDEiZ8dR
         xXIhJc+PuHWryoprmGQbzxZuys59fqmsUhvHIPjImnGbMw6LSPUNGeci0fY/V8wbVkJu
         LsRdB2CI547U+UWOPQhbVuLQ0enwHFK3UfxmVWA2DNyBmTRVQigHVdBFzOJX1mUHd0kI
         4dx1U0yy8uq1NXaQxMAYJbyRlhXkk7ilZtwuJ021OnjnM5Mc2zVNwofMuS53WMtSzfAb
         ZsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wYheJOg1NZzECr658le7NqXjuqImUz/Kw+GoeDiCAg0=;
        b=m7mnupKcweuCLLqDfiBEefmaL7eykZJ2CR61+6RO8BVFYpjKZPMOhu4jnhuY0TRLx8
         RDu5ImSQbJbmO3nTpYvQKbctNL3ifpfWIgUTJyl5zf6m1EZbCH41oWxjK/iLM6fqCoEj
         i0G5nDJCInWleFvV8gVMaoQ+iiXnRiSy3SZdgAQ43kxqNewvCJs8qrkrETz7FE0TvBI6
         hhRxABVsI8NSKrjOuQOcZ1A7cgCU4ArMn1WB6DYVjW1nmQJhVJaPNNE8dnPf5W3abx+W
         r+2aBJb/gxLxT1nEhDndNNKAbnsBC/jCPAXsDWONiqIQcaDPtZhIH7QabIhmLYhuvPTp
         IUZg==
X-Gm-Message-State: APjAAAWl+qYUWlFzAiqXskxk0UdG2dDHll2kbnnSyLbgyYJEmDIHiEIj
        VwGcRW/7LWbwGcGnypPkwMU=
X-Google-Smtp-Source: APXvYqzuRu/LHBhYR7+sZR5cemFrtpnOuzCWp3HT/9ni5iw/xVQKsmBZEyrmCCUYY4F2wIxyjxefCQ==
X-Received: by 2002:adf:c50a:: with SMTP id q10mr26940232wrf.374.1573999197651;
        Sun, 17 Nov 2019 05:59:57 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 05:59:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/5] clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
Date:   Sun, 17 Nov 2019 14:59:24 +0100
Message-Id: <20191117135927.135428-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from clk_set_parent() to clk_hw_set_parent() now that we have a
way to configure a mux clock based on clk_hw pointers. This simplifies
the meson8b_cpu_clk_notifier_cb logic. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 67e6691e080c..d376f80e806d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3585,7 +3585,7 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 
 struct meson8b_nb_data {
 	struct notifier_block nb;
-	struct clk_hw_onecell_data *onecell_data;
+	struct clk_hw *cpu_clk;
 };
 
 static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
@@ -3593,30 +3593,25 @@ static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
 {
 	struct meson8b_nb_data *nb_data =
 		container_of(nb, struct meson8b_nb_data, nb);
-	struct clk_hw **hws = nb_data->onecell_data->hws;
-	struct clk_hw *cpu_clk_hw, *parent_clk_hw;
-	struct clk *cpu_clk, *parent_clk;
+	struct clk_hw *parent_clk;
 	int ret;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		parent_clk_hw = hws[CLKID_XTAL];
+		/* xtal */
+		parent_clk = clk_hw_get_parent_by_index(nb_data->cpu_clk, 0);
 		break;
 
 	case POST_RATE_CHANGE:
-		parent_clk_hw = hws[CLKID_CPU_SCALE_OUT_SEL];
+		/* cpu_scale_out_sel */
+		parent_clk = clk_hw_get_parent_by_index(nb_data->cpu_clk, 1);
 		break;
 
 	default:
 		return NOTIFY_DONE;
 	}
 
-	cpu_clk_hw = hws[CLKID_CPUCLK];
-	cpu_clk = __clk_lookup(clk_hw_get_name(cpu_clk_hw));
-
-	parent_clk = __clk_lookup(clk_hw_get_name(parent_clk_hw));
-
-	ret = clk_set_parent(cpu_clk, parent_clk);
+	ret = clk_hw_set_parent(nb_data->cpu_clk, parent_clk);
 	if (ret)
 		return notifier_from_errno(ret);
 
@@ -3695,7 +3690,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 			return;
 	}
 
-	meson8b_cpu_nb_data.onecell_data = clk_hw_onecell_data;
+	meson8b_cpu_nb_data.cpu_clk = clk_hw_onecell_data->hws[CLKID_CPUCLK];
 
 	/*
 	 * FIXME we shouldn't program the muxes in notifier handlers. The
-- 
2.24.0

