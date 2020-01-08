Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D615913399A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 04:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgAHDYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 22:24:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45787 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHDYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:24:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so829468pgk.12;
        Tue, 07 Jan 2020 19:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=aTQ2WmgfLL0RKpED5qehF/7+sveySkG+bgQJgoV8etc=;
        b=cEz7w8dKWriMWqxMsuQxVa5e46S97vL2jdidPeIzqkB7Xvto9kfcvWQwx+jE8VhJsU
         HhFz558l1P9wgZM2XF42O3c7SvlQkl3h6YWiCC+OA5HSxtrm3lyut6xjDHama/5ahHls
         ybQ2CLhoTKeuxcZ/WDTCJZDcUBihGkNJnUe5af+piJ5vlnu1U4n3i0S2QX/8DbTSzG5i
         OIvhHydKLAMskIeuZgYxKmQVNj26UcUHZ56pi66sn1NmW7DoYfyKRx+xNc8yQ0pQuLwt
         ivXhmv7WsroUIdNNpMvAcPh7EY90iXVnrKBxTg3aqxL6QvzGOaRVCSLQQcNVw73ScGnn
         ugWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=aTQ2WmgfLL0RKpED5qehF/7+sveySkG+bgQJgoV8etc=;
        b=p14vtNWykTloEvEx+/KFap1N/4+qBBOH+197QlVYCJgORY6ZDrWdevY/q8taySflqQ
         PPam0yIEjRFWKu+maLIfu0MA1Dx12tsQB1K6eca7ln2DbzmM/vqGKaEGASJmeToV/Yv5
         audj2iTNXbvqToDmSP2vZZUEdk6KBeEjxQg1fZ95PCZNd9+q1tFIHospY5H0ZtFy+Qu+
         nP8it0THOftZU6gWdhiwNx/vBkWosevwCqPcWboJjjghMx/ZGA0efItfs6P3eQC1OhWl
         F65CJn02TTFkRgwJPkEEUwsd4FW+QpBaAWXu3qW4r7oKiULdtKWhb4+JjhaF18ZegtSD
         cMgw==
X-Gm-Message-State: APjAAAVFWNpKXEBvziW1lSAsPYnQ1/41Xm+fKMG0sYFMjoAeNzyM/T/v
        yANqXVBNIwujyYQ5xgx4dxQ=
X-Google-Smtp-Source: APXvYqwubCOQlf14pJ6s9xsa+Oo7lRpvIz1zNTzkr9RdY04nKFQeQkQ8sLpDUhNDQqJZFqBsw240/w==
X-Received: by 2002:a65:4587:: with SMTP id o7mr2951256pgq.303.1578453850648;
        Tue, 07 Jan 2020 19:24:10 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g7sm1077875pfq.33.2020.01.07.19.24.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2020 19:24:10 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/3] hwspinlock: sirf: Remove redundant PM runtime functions
Date:   Wed,  8 Jan 2020 11:23:45 +0800
Message-Id: <c921e391aa2a652d8d6ae0e4041202cec9d917e7.1578453662.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1578453662.git.baolin.wang7@gmail.com>
References: <cover.1578453662.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1578453662.git.baolin.wang7@gmail.com>
References: <cover.1578453662.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the hwspinlock core has changed the PM runtime to be optional, and
the SIRF hardware spinlock has no pm runtime requirement, thus remove
these redundant PM runtime functions.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c |   22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 8cb5fd4..d62462e 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/hwspinlock.h>
@@ -56,7 +55,7 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sirf_hwspinlock *hwspin;
 	struct hwspinlock *hwlock;
-	int idx, ret;
+	int idx;
 
 	if (!pdev->dev.of_node)
 		return -ENODEV;
@@ -80,20 +79,9 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hwspin);
 
-	pm_runtime_enable(&pdev->dev);
-
-	ret = hwspin_lock_register(&hwspin->bank, &pdev->dev,
-				   &sirf_hwspinlock_ops, 0,
-				   HW_SPINLOCK_NUMBER);
-	if (ret)
-		goto reg_failed;
-
-	return 0;
-
-reg_failed:
-	pm_runtime_disable(&pdev->dev);
-
-	return ret;
+	return hwspin_lock_register(&hwspin->bank, &pdev->dev,
+				    &sirf_hwspinlock_ops, 0,
+				    HW_SPINLOCK_NUMBER);
 }
 
 static int sirf_hwspinlock_remove(struct platform_device *pdev)
@@ -107,8 +95,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_disable(&pdev->dev);
-
 	return 0;
 }
 
-- 
1.7.9.5

