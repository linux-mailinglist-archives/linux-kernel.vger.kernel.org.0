Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4D113C36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2019 08:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLEHUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Dec 2019 02:20:16 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42724 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfLEHUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:20:15 -0500
Received: by mail-pl1-f202.google.com with SMTP id 30so1131784plb.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=ev64gIbhiiWOfq6m4iAbLRYcJhqCx/lcEwnb1r5g6PE=;
        b=R+ykN4UYQcA+9UAFBvvgSklElgRJSGCbdjk3VUbcEctURsnU5CwuNXWO88/2LmVMdq
         r6nn8FUN5jLomBx4p9FG8TEWWtx8HsIrIwaBsiY5fJpb1Nq3Ihrigwf0e+ZNmmAA37An
         TqtPQrVKW6+ijvL8aWf5sioqroZHaAk1+1kuYyG3n1Md4YCKdf4AXFAnjATz5cha+KMo
         B/PNQWIKHR7+uvG0qGiYzEsiCZT9Pb38p95lG888xLi8+VbGTuVOVNJ6/YLvBDzz+kUr
         wLoBayDpo9fpvSJCH9vpLUbLlCUlC0dLETJAYhdav90zY411kNHv5cX88Agdn5JdNPMt
         Hsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=ev64gIbhiiWOfq6m4iAbLRYcJhqCx/lcEwnb1r5g6PE=;
        b=iICAUlzulLhXvID+AMhaXatSaC0LpiEuqOtHdeUBkiFNSHy4MiWcNg9fj1Q6UQCXMg
         T5VoQCPhBe2Vesb8kX/+BdOXriE7ic6pUzAzmk99iG6/fxh9E7yb1cHhLqE/oEpZnV01
         svRlswgpdHu410ye+6pj0sx2MjsIF/h+i/C2jHBWuJ7F9gsSfnPOwolz4TXorjAhitt3
         I9MZ1eMPgkLUEtlCSUUF723mrXWr0aeeP3BV1z3pnC6Ba4ZrCBxsXr7x9jMIb35xWZKw
         DNUlyiAGLtOlf6pAhjxkdpxFZTtmQOhxSp7lxqXNHDCZMsD/Z9bq1BjtCgWTKp4j7Lb+
         UIqw==
X-Gm-Message-State: APjAAAVItnfjAfBOk5VxqujVN9ot1AACwfGLj60Cl7k1zFh5a9XL9LUE
        s2yBJdAQhg5UBGZh8GSiTZeUkqc=
X-Google-Smtp-Source: APXvYqxn9/b8ONASVYeCyp5ipw6UTwiwMuDo9x8iVyDuiezT/48AUdP4cbFPNuPE1WNrZ4V7IFOD8c8=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr7837344pgs.21.1575530414350;
 Wed, 04 Dec 2019 23:20:14 -0800 (PST)
Date:   Wed,  4 Dec 2019 23:19:51 -0800
In-Reply-To: <20191205071953.121511-1-wvw@google.com>
Message-Id: <20191205071953.121511-2-wvw@google.com>
Mime-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v3 1/3] thermal: prevent cooling device with no type to be registered
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 54fa38cc2eda ("thermal: core: prevent zones with no types to be
registered") added logic to prevent thermal zone with empty type to be
registered. Similarly, there are APIs that rely on cdev->type.
This patch prevents cooling device without valid type to be registered.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..974e2d91c30b 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -954,12 +954,22 @@ __thermal_cooling_device_register(struct device_node *np,
 	struct thermal_zone_device *pos = NULL;
 	int result;
 
-	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
+	if (!type || !type[0]) {
+		pr_err("Error: No cooling device type defined\n");
 		return ERR_PTR(-EINVAL);
+	}
+
+	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+		pr_err("Error: Cooling device name over %d chars: %s\n",
+			THERMAL_NAME_LENGTH, type);
+		return ERR_PTR(-EINVAL);
+	}
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
-	    !ops->set_cur_state)
+	    !ops->set_cur_state) {
+		pr_err("Error: Cooling device missing callbacks: %s\n", type);
 		return ERR_PTR(-EINVAL);
+	}
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
@@ -972,7 +982,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	}
 
 	cdev->id = result;
-	strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
+	strlcpy(cdev->type, type, sizeof(cdev->type));
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->np = np;
-- 
2.24.0.393.g34dc348eaf-goog

