Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E498841D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 03:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfHGBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 21:49:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44601 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfHGBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:49:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so42487228pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 18:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MAl7M6iLIwuqvmlRQ5TjCek6P83vov70KViiTdReukA=;
        b=BMHF/v7IlgGTspvUN/aqgVdDDoEGJraaVKiKUzwAqabsmRCy0lHqtzOhipw+c366iq
         CZwo9sq7IcsecBEJjbomTjcByJsVR4+MIAWQakQ3poYYWEE9vT83TklkeEh2e+OkeYy6
         ZSX7EJsHlFlz4YajBbkxFhJY+PXLcS0oPF5tRgGs3f3GpxQ0xJg+GVDrBsl0l3JmqzC1
         DF2jl8wgR+kJDhXYpgq3/YYlde2VnRGaJVBrfSlDJb3cEMZeazqvEQdVV/CYv/+tlDzi
         0a0KxXEkpoLJgQEPNxzR+clGdb2+HTB2elfpVkI4ZiH4Yt2t18ffDi5eBwpGPNY87wab
         xN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MAl7M6iLIwuqvmlRQ5TjCek6P83vov70KViiTdReukA=;
        b=Fni09XwEBM2v9Yoay7mn3/v8lavUG0kPQ5Dcc04m4y4yAk39QQBY0Yls8NDFECiryq
         Uf23QyunBxwhp/xpIMfsFPPFlm+a351XdvcPOZHlOg/AuU9EOnh//barCwnXvPcOz2sW
         2iJum12SzBPOilG0KmPPz4JwIVK1ns4Ux/eNfbBu+Cjhi8A7RbMlaSQyxWji3pycE2MD
         0DV6oXKDUpW+aZbn6EyromoTfn+Exdg6TYrltO3vcKj9Oa65GGQNd161Mwqx5R09Z1t7
         pL3qoNN6qxupkK7h7bpibitRdLR7+4YKCjGrYExRI8lyV51cks8vW2XM4f7bUYKu6Mj7
         ND0A==
X-Gm-Message-State: APjAAAUGhkxRHxmjLLrWuhcM3Z9uvSGUZfZ8yRNQvV1WPDpDvJ6cThjz
        s2idzCqtyt24ybEN5VK+kCR61w==
X-Google-Smtp-Source: APXvYqy4MR1u104+7S9x1Uryj/6m0TKCVge5DU9aq7BRffcslrFAv7Ha/uwIASMTlOWCjUqndUwlKw==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr5875999pjt.108.1565142550686;
        Tue, 06 Aug 2019 18:49:10 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id q1sm104159076pfg.84.2019.08.06.18.49.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:49:10 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v8 1/3] PM / wakeup: Drop wakeup_source_init(), wakeup_source_prepare()
Date:   Tue,  6 Aug 2019 18:48:44 -0700
Message-Id: <20190807014846.143949-2-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807014846.143949-1-trong@android.com>
References: <20190807014846.143949-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_source_init() has no users. Remove it.

As a result, wakeup_source_prepare() is only called from
wakeup_source_create(). Merge wakeup_source_prepare() into
wakeup_source_create() and remove it.

Change wakeup_source_create() behavior so that assigning NULL to wakeup
source's name throws an error.

Signed-off-by: Tri Vo <trong@android.com>
---
 drivers/base/power/wakeup.c | 33 +++++++++++++--------------------
 include/linux/pm_wakeup.h   | 11 -----------
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index ee31d4f8d856..3938892c8903 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -72,23 +72,6 @@ static struct wakeup_source deleted_ws = {
 	.lock =  __SPIN_LOCK_UNLOCKED(deleted_ws.lock),
 };
 
-/**
- * wakeup_source_prepare - Prepare a new wakeup source for initialization.
- * @ws: Wakeup source to prepare.
- * @name: Pointer to the name of the new wakeup source.
- *
- * Callers must ensure that the @name string won't be freed when @ws is still in
- * use.
- */
-void wakeup_source_prepare(struct wakeup_source *ws, const char *name)
-{
-	if (ws) {
-		memset(ws, 0, sizeof(*ws));
-		ws->name = name;
-	}
-}
-EXPORT_SYMBOL_GPL(wakeup_source_prepare);
-
 /**
  * wakeup_source_create - Create a struct wakeup_source object.
  * @name: Name of the new wakeup source.
@@ -96,13 +79,23 @@ EXPORT_SYMBOL_GPL(wakeup_source_prepare);
 struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
+	const char *ws_name;
 
-	ws = kmalloc(sizeof(*ws), GFP_KERNEL);
+	ws = kzalloc(sizeof(*ws), GFP_KERNEL);
 	if (!ws)
-		return NULL;
+		goto err_ws;
+
+	ws_name = kstrdup_const(name, GFP_KERNEL);
+	if (!ws_name)
+		goto err_name;
+	ws->name = ws_name;
 
-	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
 	return ws;
+
+err_name:
+	kfree(ws);
+err_ws:
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
 
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 91027602d137..c0cad2d8f800 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -81,7 +81,6 @@ static inline void device_set_wakeup_path(struct device *dev)
 }
 
 /* drivers/base/power/wakeup.c */
-extern void wakeup_source_prepare(struct wakeup_source *ws, const char *name);
 extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
@@ -112,9 +111,6 @@ static inline bool device_can_wakeup(struct device *dev)
 	return dev->power.can_wakeup;
 }
 
-static inline void wakeup_source_prepare(struct wakeup_source *ws,
-					 const char *name) {}
-
 static inline struct wakeup_source *wakeup_source_create(const char *name)
 {
 	return NULL;
@@ -181,13 +177,6 @@ static inline void pm_wakeup_dev_event(struct device *dev, unsigned int msec,
 
 #endif /* !CONFIG_PM_SLEEP */
 
-static inline void wakeup_source_init(struct wakeup_source *ws,
-				      const char *name)
-{
-	wakeup_source_prepare(ws, name);
-	wakeup_source_add(ws);
-}
-
 static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
 {
 	return pm_wakeup_ws_event(ws, msec, false);
-- 
2.22.0.770.g0f2c4a37fd-goog

