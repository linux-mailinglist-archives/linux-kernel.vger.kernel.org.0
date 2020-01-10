Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2374E136527
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 03:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgAJCAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 21:00:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37495 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgAJCAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 21:00:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so216616pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 18:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvCF4TaFq4NHuFxKrB7bfyibK4IZqbz7rtt+95xhHqo=;
        b=UhkNF2i6KaXltxMZXRbU88Ilw8OkJEXI6REMlfxksP+PYmlbEzftvOHIMyN7fYK08w
         Tqaihhp66NIs8LcSomRTfLax8Nm7UYv5neFP9D2xNLpcTUtO7X3de+NrsxNZIQDFZDEG
         k9Pr+5/igmkqzgl3qbPWOO52LVuTykmOmSX5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TvCF4TaFq4NHuFxKrB7bfyibK4IZqbz7rtt+95xhHqo=;
        b=UDFIRfGygbxNej/3zoko3ykYdlLdbLr+Sr/WX3axnO1DJAqnxdT0Lyp2NdQMHmAFbD
         INGsSfRWNhnjbD2BEHMSadJTxt/RfkE3luE6t8Y1GRIU/X1XP09MMZdIL0lc/hoPTtTY
         MXQ+RlDARhE2Pj8em43Wgnu7p1Xlnqyk1aXozZ3H4ALPrGSJ0hvLmK5Up6afbyE+2H2k
         mibce9t5Ts5IRtFvfmXn61SEiLhpS1+PlG1/qEnbP7BBiGaijWDi5ng5taRFzwObmREg
         YMUPlgL9RLX6jmgOb/sA3YXRgkZ6X6ws0VJEWa0210hVCZVPoy6IwePK6JL8bVQyhiTD
         13QQ==
X-Gm-Message-State: APjAAAWtMjVVRmaUjbR3O/JaRe6m9dwNDa24g7HSDOpacHeE0L4mpJ+m
        jRGKqS2F5D1nfkfiiM0pP4eiMA==
X-Google-Smtp-Source: APXvYqy8CIzTVvdPT0/w3B7JHwB2lbAlbMW9Fuh1+JhZtXYS4f9PXX9xu9MMgcycQmesK9L3XRRSPA==
X-Received: by 2002:a63:4641:: with SMTP id v1mr1171519pgk.389.1578621605868;
        Thu, 09 Jan 2020 18:00:05 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id t30sm233232pgl.75.2020.01.09.18.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 18:00:05 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org,
        "RafaelJ . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     DanielLezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] BUG-REPORT: cpuidle: teo: intervals[] array index out
Date:   Fri, 10 Jan 2020 09:59:17 +0800
Message-Id: <20200110015917.32825-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a simple bug in rotating array index.
---
 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index de7e706efd46..6deaaf5f05b5 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -198,7 +198,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * pattern detection.
 	 */
 	cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
-	if (cpu_data->interval_idx > INTERVALS)
+	if (cpu_data->interval_idx >= INTERVALS)
 		cpu_data->interval_idx = 0;
 }
 
-- 
2.24.1.735.g03f4e72817-goog

