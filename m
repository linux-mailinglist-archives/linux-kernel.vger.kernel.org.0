Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8EE4A354
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfFROEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 10:04:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40675 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfFROEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:38 -0400
Received: by mail-lf1-f65.google.com with SMTP id a9so9381971lff.7;
        Tue, 18 Jun 2019 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGzib6MseACehIYRzaxs9YRxFXUiKKW6eF2jOufVeio=;
        b=MgTfYh3stqNxgZlQmWUAd5MtiRvA8vV9zxm5ODNoW81j6wPb+fsJCp5dUYyKv9bP8E
         yuX/o0r/TKpul8P9pj1rWOUZHLZfWHh+jgnWqUbWj29oaf1ieCatmN/NcDFzRWyQq2Hq
         ueRvYqsWfCtVRTrodxA0ha4A13zhAmb1c3m834EGq03J7v595rcjclCfwwO7xTohMRec
         yyZVtTCzzWrIxFBe2lBx/Li73KC0TV72MWFdVOltErm+B1yDy3g6ndbEyHPPUSe2APpl
         LRilz50ilPnuUwJUy8ve6CUHjJ2jkzaExnJ9PuwV6oTieMxTyxi8P5vSVP8R7uti/ohc
         u45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGzib6MseACehIYRzaxs9YRxFXUiKKW6eF2jOufVeio=;
        b=gQF9b4gjNIZeTAIpdiWob2ph9Rom9iaFpHg1z49x9eU5zpNT9OnEiR3AmCbmKxvCK1
         5A5PcKNjuxmz+v6PfQb4DS9b8Lgm2PCs7hTcVirlwYkbpM28GyyZTgUSuCnrajsFMHcx
         X/NayYDGkEM0VVsgRoxNc4990m7M0Z7tkk8+Fb2U5lyEH9KQSw5uBNKEmfJ4i7jOqRmT
         OYDQNyGYETpApVzR8OdM3GVgRXuA5GtAs7+noK6AhewS35+geycGhUFrtJ6C9c26umP2
         FVSrQr62iNbm58lfCmN/tAE0Y+V1lAy6xCHj2mzAbRLyMBP1NSpXvOgzi7omlD0WC6vg
         RYdw==
X-Gm-Message-State: APjAAAUjdjy1SbjBOiCd5g1zC6PN1sUi9DgIMr/PVjox0+d+2WZl25dm
        R4L1aFytNQlJ0uHqISUqJXUxTvai
X-Google-Smtp-Source: APXvYqyzCxDjGqJ4TwXFRFbmGVmL+naY4sTKxFD7FCosi9P7Ush/adZz52ViR+l73kD+nBZed1Px5Q==
X-Received: by 2002:a19:c14f:: with SMTP id r76mr11251171lff.70.1560866676585;
        Tue, 18 Jun 2019 07:04:36 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:36 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] clocksource/drivers/tegra: Restore timer rate on Tegra210
Date:   Tue, 18 Jun 2019 17:03:51 +0300
Message-Id: <20190618140358.13148-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocksource rate is initialized only for the first per-CPU clocksource
and then that rate shall be replicated for the rest of clocksource's
because they are initialized manually in the code.

Fixes: 3be2a85a0b61 ("clocksource/drivers/tegra: Support per-CPU timers on all Tegra's")
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index 1cc5847a1030..501071f09fa8 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -277,6 +277,8 @@ static int __init tegra_init_timer(struct device_node *np, bool tegra20,
 		 */
 		if (tegra20)
 			cpu_to->of_clk.rate = 1000000;
+		else
+			cpu_to->of_clk.rate = timer_of_rate(to);
 
 		cpu_to = per_cpu_ptr(&tegra_to, cpu);
 		cpu_to->of_base.base = timer_reg_base + base;
-- 
2.22.0

