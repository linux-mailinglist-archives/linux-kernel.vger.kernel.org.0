Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4947D94C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbfHSRzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 13:55:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43008 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfHSRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:55:01 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1628418pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdtAV1xATKqzVzk/DbE+IGNr2mWwyW+FAULaw9PivyY=;
        b=k7y0Y8zjrpJBSAsXL0IKx0rACGq4A7Q7tkpgbaokOh9YtrZU7lwXxhZnJIoajPIXCE
         J5+CPvFXtrgrIOMZ7qhPnQYabXztxNSYPc9tuN8Or+v8VEiwXjPPtVWoVrVWFFCMqgQU
         DDZP6dUUBOwGCIDMKsL1RQdvGHfECORM1Sbog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdtAV1xATKqzVzk/DbE+IGNr2mWwyW+FAULaw9PivyY=;
        b=G7nR4lEa6HqUjr8qQQ/4LryMiOLR7WL3rm4zRc79gv2eg0DrlggxqLJ+padWsXmRBS
         UeTT2E1XUAVPt5ntP1y9XjmcS0J4TJlptA4zDwTurXth96l6ZlpprS03IkrHDhHoel1c
         aEP2nZ87SqR4LqsKyFyaJnmO5R3HXQWtildTzlQpw4kSkUyMF3LLpNQ+GRPfVYYO5XLo
         xzASxpMDtN5bcpIVVq8dsxThJ47aV82WtOhtclBpJsYLBVFXNKR9KcSnzKkQou6W5dO2
         vsuOKAymC2ee5rhgpFGiphGPHWOrmGdyCxUik+8abLnBbdvugnGe1E6U7w3zgneC5IEm
         RowQ==
X-Gm-Message-State: APjAAAXAfdNyTRUjNWML9dp6wpMVHajLavPvKb6naqJk6vN0zlXq8HT9
        +jcpHy0fJ8BXD91g3j3e/wJHkw==
X-Google-Smtp-Source: APXvYqzNjjUiIRP7t3A7+8awsygXwikF5otXIBfdzuPefg5wLRfX9kixkt9gNTcLWfFzgEqm87h08w==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr24759894pfm.231.1566237300798;
        Mon, 19 Aug 2019 10:55:00 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm18084237pfe.67.2019.08.19.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:55:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 2/2] PM / wakeup: Unexport pm_wakeup_sysfs_{add,remove}()
Date:   Mon, 19 Aug 2019 10:54:57 -0700
Message-Id: <20190819175457.231058-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190819175457.231058-1-swboyd@chromium.org>
References: <20190819175457.231058-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are just used by the PM core, and that isn't modular so
these functions don't need to be exported. Drop the exports.

Fixes: 986845e747af ("PM / wakeup: Show wakeup sources stats in sysfs")
Cc: Tri Vo <trong@android.com
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

