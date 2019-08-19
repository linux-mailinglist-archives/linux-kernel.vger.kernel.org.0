Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EB950FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbfHSWmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 18:42:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44521 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfHSWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:42:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so1651664plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isGEEkXs5KsfPoU6k4xsqF6OzpzQ466lEnl9lP+jev0=;
        b=FH91SQEXP4CPrRUqTyz7aMJRachrVq+fpfsrCfNSwKOJ5ztW+0RQwsEJ/HFRENwGY9
         r3AxWH1Ndpkn28AuzgaZztu7EljXF2OQ/5UIXzhXYZFQB246YLJG0uTklIYg+hhaOW4d
         9lIW4STuFh4kTL8SxCtWE1O7W4kVHTvjrzhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isGEEkXs5KsfPoU6k4xsqF6OzpzQ466lEnl9lP+jev0=;
        b=baTaHUzNZ1uvNnEP9ZmlFBgfNQYW7e6tUWEh6SJK+UXbAGXo0z4tELU32wF7fMxG0l
         m1oqYGxmcOHsH51fwnNmhG62kruFR1r3ex81aKXOFDnXQHeG/nKAkSte+VPQIwWU0tvC
         aju2DczDpl7JUmI2Lhde+EY08EbLQhlfSKvAODVMwj+lhoE3jrtlOdnBV9+Wma9CFJ0Y
         FwZO7ZrZT8OECLPHh2F3J9Rp3mxjcfZpb6nyfq2RKeANrOcpLRb+czZTSti4ITR23NOM
         MXve426c+9MIXC8g1yH09TkuUsBTdZEnpBpA4eHeHaOy7JyKRSDT5GugZTnLq8FPHf8X
         wK3A==
X-Gm-Message-State: APjAAAWV2/0Lv7n1Gm7FA0wKUcMeHHS9PTFNz2/YQRH7/HhMtnsfZWoY
        x3g1OTDDB5zgEuUu6J32TP+aLgaZibP1lQ==
X-Google-Smtp-Source: APXvYqy6XW7GW2bp3WGm3DN5RHuveRy+dsrHMezjp+NUB8YYg6QmMRV/fewR05ENaqE8KLuPlC06nw==
X-Received: by 2002:a17:902:5a1:: with SMTP id f30mr25405720plf.64.1566254522301;
        Mon, 19 Aug 2019 15:42:02 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e9sm16841593pge.39.2019.08.19.15.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:42:01 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Tri Vo <trong@android.com>
Subject: [PATCH v4 2/2] PM / wakeup: Unexport wakeup_source_sysfs_{add,remove}()
Date:   Mon, 19 Aug 2019 15:41:58 -0700
Message-Id: <20190819224158.62954-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190819224158.62954-1-swboyd@chromium.org>
References: <20190819224158.62954-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are just used by the PM core, and that isn't modular so
these functions don't need to be exported. Drop the exports.

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Cc: Tri Vo <trong@android.com>
Reviewed-by: Tri Vo <trong@android.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/wakeup_stats.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index bc5e3945f7a8..c7734914d914 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -182,7 +182,6 @@ int wakeup_source_sysfs_add(struct device *parent, struct wakeup_source *ws)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(wakeup_source_sysfs_add);
 
 /**
  * pm_wakeup_source_sysfs_add - Add wakeup_source attributes to sysfs
@@ -205,7 +204,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 {
 	device_unregister(ws->dev);
 }
-EXPORT_SYMBOL_GPL(wakeup_source_sysfs_remove);
 
 static int __init wakeup_sources_sysfs_init(void)
 {
-- 
Sent by a computer through tubes

