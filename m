Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96BC4A356
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfFROFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 10:05:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37089 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfFROEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:04:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id d11so9392801lfb.4;
        Tue, 18 Jun 2019 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STWc3nI1OlTc3dFrniXVfFPRqTFFuZX+HKw8/Q09fIA=;
        b=vDSke2QRbhtMXs05UDb/nxnqYCxd4VOMz647GTOO4ubNTi3kV35+/sLM59QfnrH/XH
         7+8Nv1P9THVsFB0QUv2e63iMJunOOL2afVXe70UOSDf2JFnvW0TjXjsK5bDlFdUaKGOk
         6hL7sxLnv8h+8HJAsQi/2RsxUvRHvDIzvCPShdwFbb4m0VST8buJWp4VadF1Opstn3jl
         xkN3uRIb/ocCtt/BuDo2YXQOjkNkkE6JnyFnvamFz47sojgvU/qlVZsynaNR0XtyBvEE
         cxhv9MdXa4vlV6/H39TRRvRNJiiPmrqAoOkH+faAZhA5LxjKWcMKFDEvylYpHgF46lcQ
         LZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STWc3nI1OlTc3dFrniXVfFPRqTFFuZX+HKw8/Q09fIA=;
        b=CCxEaDNyV+HvEaYzylPCEyi+90X5SnVolloOxk1LESa/BkNKUDav+j65txvHyG6F+4
         AWIbPd2hyYrjpBSfjEaceWO3uDveZC7lGz5nJzw4ee1cn6rvtNg0R1pdTfPpp3t/JADS
         oaF1dN5rlCrt3catCSBMgySkfbi3P7acJKT1Nm/EO7bolL/l7h+Cz5a9AjVFRzjXzHq5
         1iwUJZpP3ZCNptYw0cmPACX7a7xXOFCeC0/8bAMl2K83g1FdEOLnmwO80WFBoziy3b6o
         4HlNEdrYOZhcQ7UNDTZTgEE4scVyiqgl2W2ZAJg0hcsLKCJw42XaufAQEczFfsXERtr4
         vpDg==
X-Gm-Message-State: APjAAAVPJGEPkr7QSdG/Zjs9lf+BV+PV8qk7eCbqXyPHpMGdvKqp90eC
        l4rEWh4E5lxvfdOwm+XFOvE=
X-Google-Smtp-Source: APXvYqxLXfG1WtyAoAek2wUWi2UZqqHqRtliSqne7M0zvkSifWGoyXJXTWcZRS2XztwKkOG/JOkwUg==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr17929686lfl.0.1560866679556;
        Tue, 18 Jun 2019 07:04:39 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q6sm2650538lji.70.2019.06.18.07.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 07:04:39 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] clocksource/drivers/tegra: Drop unneeded typecasting in one place
Date:   Tue, 18 Jun 2019 17:03:54 +0300
Message-Id: <20190618140358.13148-5-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190618140358.13148-1-digetx@gmail.com>
References: <20190618140358.13148-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to cast void because kernel allows to do that without
a warning message from a compiler.

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/timer-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra.c b/drivers/clocksource/timer-tegra.c
index e6221e070499..3afa66c6730b 100644
--- a/drivers/clocksource/timer-tegra.c
+++ b/drivers/clocksource/timer-tegra.c
@@ -81,7 +81,7 @@ static int tegra_timer_set_periodic(struct clock_event_device *evt)
 
 static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
 {
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	struct clock_event_device *evt = dev_id;
 	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
 	writel_relaxed(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
-- 
2.22.0

