Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6505137527
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgAJRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 12:47:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35044 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbgAJRrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:47:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id s7so1297461pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVuxFQb0xSkWKWzgAMVaI1HfuwV6A1P87bv1zEIGF/Q=;
        b=eSzc5rKd/R/CFC5jGnEsgwZGD1958eBKgUmhc50GRkOh0gMyB4i3/j0Ne2HtJbUzIv
         efHQ5VBWx6LXW4+KUNx2hV51yxE0p53uzlwSrAgOZzrluO60vfGOy8WZc6D98GiD6Qq/
         8eEPbpUPaL8w0n/D6qPm33SF+aqrZFhACswIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tVuxFQb0xSkWKWzgAMVaI1HfuwV6A1P87bv1zEIGF/Q=;
        b=NKJWa+SpmN1kM1NEqWUdLGcbZtMyIZVJl4pnutzWqWYPC9xSOxr1/iBZlXA08CSoUX
         QwqFjddCWKLbI4Hi9dUcAlAVPyVHc6CDjuvzdhB8+/A0lo8aab8gse+DAPf9MLRMhZvP
         hpEKcyVLpT66DjqC0oN37LgQ22Z7RaUnRNqivQlIgCRSczk301m6fIXm8VovfuzILSNx
         PKTPzjFZ394drG+DRl3MuRnPj8370ae9b4srZm9qQtEDhI8lXAbv/aByN3a5Usw6jlxU
         +i6bN5FJdb9O/UY+eFr60zFaDfokMJLZJA4qD0fHMduJQKQgfl+TVwMRcMjb+rkl++l9
         G+Sw==
X-Gm-Message-State: APjAAAUYhavw1t3kd+r4Y3LhMV++qT5V8J+/DaIk6kDJb8gWpLpALlmk
        a2bnWMqrDkhjulV+56aHfBZUzDleC3M=
X-Google-Smtp-Source: APXvYqwhRRv0VVaqKKke6UGoQ01ugyU6beEmWKw2Pfqds9zz7Mz3kV3ztTbZxaUaxDY+ysdFI6vZhQ==
X-Received: by 2002:a17:902:7484:: with SMTP id h4mr5476267pll.206.1578678438814;
        Fri, 10 Jan 2020 09:47:18 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id v5sm3595016pfn.122.2020.01.10.09.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:47:18 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-pm@vger.kernel.org,
        "RafaelJ . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     DanielLezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] cpuidle: teo: bugfix in intervals[] array indexing
Date:   Sat, 11 Jan 2020 01:47:12 +0800
Message-Id: <20200110174712.7019-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a simple bug in rotating array index.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
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
2.25.0.rc1.283.g88dfdc4193-goog

