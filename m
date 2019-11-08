Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACCF5169
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKHQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 11:44:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46571 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfKHQof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:44:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so6865315ljp.13;
        Fri, 08 Nov 2019 08:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cK+IGE/NngSL6LBLRuXqj1unYMeLxTCgHc31IK6M3A8=;
        b=com7jnRF5SZ9/ccNJQmHeb811+9z4q6zQpNqargqN4kMxwN+PtSkDWcgGhb66Uhr7s
         pCcM4eXTHQren2dDDoxjDXnlFGcfagRddvzKf3yB/A3Lmezgp4N2RYrfEFH8TpgXHc73
         +Is0fXX2zvLQAKUuT6+VLdGgh7rhB2ennX5FHcI6XPFIJVQYXX6jehAZjwB0itJuy4jU
         baXmWFAt85GVpj+/wuOplH8pIYVd7Tsf4olpr4ABfPrOKd6CpHkJLzDRYi7awb/7oxcd
         cW3fwLLHXvhekF7F5RGUUsT2cd9PtOR1Yued636PH6yHmffOwZMNhyCa2qALr999aqV+
         Amng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cK+IGE/NngSL6LBLRuXqj1unYMeLxTCgHc31IK6M3A8=;
        b=ocJquGb7sQhav0TouIOmaCZJ7yhmoIKHhgqbWLP9mIyn4OE0RT7O68m34dE+S+/lHU
         grI304MFh+2FDkfuQqqQIPqi/ZkQ+3Br7vCNIvbEINO4sYbV2QvYStFzT2kvRlRMmOzq
         S1ofUDjHKwgdsFjO3RZxaVnW/1fyA6hgpsJC1PEkdyrdl5kCMEks5FwJiiNTunUTLHZT
         4/e2WLTWyur7miER/GnfqvfjLuFxcV/AK7fen07K5ZaeHbqAn2NT9v92GLIbQEAtnCe+
         eRjd9lZGwtmPjdmO81b5Yaj6sKKBVeZGSUzeUyNyTqijqYRbj4kJgG6kTy6lsWhMyaxX
         qGMQ==
X-Gm-Message-State: APjAAAU5jZ9NaVyn3AbtE9tigc7PoAMLwPYAEY8FR5fx7ytVxahsolIO
        YLjiLze2jYw0+TiJPcpw449XbayjJio=
X-Google-Smtp-Source: APXvYqwnqP1/jFgP5c/CIcNf5IFpRJbWD/bxegdrv46BVSwI40CW/JtrxhItMkGjkKVpEuZwWMQAmg==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr7712122ljg.75.1573231472347;
        Fri, 08 Nov 2019 08:44:32 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id z19sm2696415ljk.66.2019.11.08.08.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:44:31 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v4 1/3] asus_wmi: Fix return value of fan_boost_mode_store
Date:   Fri,  8 Nov 2019 18:44:16 +0200
Message-Id: <20191108164416.2969-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108164317.2874-1-leonmaxx@gmail.com>
References: <20191108164317.2874-1-leonmaxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function fan_boost_mode_store should return number of bytes written
but instead it returns return value of kstrtou8 which is 0 if
conversion is succefull. This leads to infinite loop after any
write to it's SysFS entry.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e01635..723aa4d969dc 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
 	asus->fan_boost_mode = new_mode;
 	fan_boost_mode_write(asus);
 
-	return result;
+	return count;
 }
 
 // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
2.23.0

