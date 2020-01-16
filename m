Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2287713F0B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395558AbgAPSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 13:23:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35786 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392452AbgAPSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:23:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so4874527wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fo5dGHfcTYvpzozVFBOXz3UkWraK5woc+oSC5HJiXcE=;
        b=L3u4XrNNAszKKjQv0ZkuLk392iUHP396dPTe1o7i4I4Rn70UToXpoIinLrf97bIgV/
         4ycDtsxqHT5eRK9I5QPcPP0MkHiJqiYFpSdIPOv8bdWw3QB99MSuyb7Vogr3wInAxyIm
         QZw9fi2qlK4UbS/pwPZxkyo2L/x58od5e5xRvuVSlGCjyWevwpnQ3oP/Bdk+pqvME6hF
         MoEhSpfIFzmhvLCoEAgrQbuSXbQVp462NQL01puaH4wPxBs1JRA7A8fOjHORJQko0h/X
         O4b4aTrtQ+lp7G6vibDjGNBvRez28ZRQTzcgLNhZFet9mzBfgd3+Pkys/KqvHa2GyeQS
         GRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fo5dGHfcTYvpzozVFBOXz3UkWraK5woc+oSC5HJiXcE=;
        b=h4oPVGp40D3/QUlyQ9wO1qH96b05wqo8NPBlIWDBg/q/k0scai3t+cZsUNsYuW+QGo
         4oof2QRHBUhdWbM7Sl/pyixEZ1QdIlNW0iFDc60yjxa54cxPbZkuUOXHokTimfTZJlaT
         5lqdYxDAx0gzAfwLgcteDhumx88QTJO93YRDZ85y9A1m0K0GLI/CnCKubZUWtuGxWm8z
         zhGNy4a77Ud2Kd98KEmuIV14jR+ZsrQkFz8wRgcAVfY3l89R/+kdhElVdtjgZHbeK60+
         ZnSXnsSLfVRk6RJvTG+I4Zo3wMLa49rBM42SVbEsD9HzMV9aDQvrHxJpihETXX4v6WFe
         /Qzw==
X-Gm-Message-State: APjAAAUE0E+kBCPZBB7srVOXAb3YnwnoacMBDtu5K6ZQEK+d9C6Y4qJ4
        6mdOmpX3FS1F5Q/GkkAey2pc2A==
X-Google-Smtp-Source: APXvYqyCzzb7myDBqaZc69hlCcYxwa+1kytjgGC2ZMeSwse/HZHd393PjH6eBsaFCSTiFqIQThSLpQ==
X-Received: by 2002:a1c:7c18:: with SMTP id x24mr339057wmc.21.1579199004749;
        Thu, 16 Jan 2020 10:23:24 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:6c63:1b50:1156:7f0f])
        by smtp.gmail.com with ESMTPSA id b137sm1087920wme.26.2020.01.16.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 10:23:24 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 05/17] clocksource/drivers/hyper-v: Reserve PAGE_SIZE space for tsc page
Date:   Thu, 16 Jan 2020 19:22:52 +0100
Message-Id: <20200116182304.4926-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116182304.4926-1-daniel.lezcano@linaro.org>
References: <74bf7170-401f-2962-ea5a-1e21431a9349@linaro.org>
 <20200116182304.4926-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Currently, the reserved size for a tsc page is 4K, which is enough for
communicating with hypervisor. However, in the case where we want to
export the tsc page to userspace (e.g. for vDSO to read the
clocksource), the tsc page should be at least PAGE_SIZE, otherwise, when
PAGE_SIZE is larger than 4K, extra kernel data will be mapped into
userspace, which means leaking kernel information.

Therefore reserve PAGE_SIZE space for tsc_pg as a preparation for the
vDSO support of ARM64 in the future. Also, while at it, replace all
reference to tsc_pg with hv_get_tsc_page() since it should be the only
interface to access tsc page.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Cc: linux-hyperv@vger.kernel.org
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20191126021723.4710-1-boqun.feng@gmail.com
---
 drivers/clocksource/hyperv_timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 1aec08e82b7a..12d75b50a317 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -307,17 +307,20 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
+static union {
+	struct ms_hyperv_tsc_page page;
+	u8 reserved[PAGE_SIZE];
+} tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return &tsc_pg;
+	return &tsc_pg.page;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
 static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 current_tick = hv_read_tsc_page(&tsc_pg);
+	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -397,7 +400,7 @@ static bool __init hv_init_tsc_clocksource(void)
 		return false;
 
 	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = virt_to_phys(&tsc_pg);
+	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
-- 
2.17.1

