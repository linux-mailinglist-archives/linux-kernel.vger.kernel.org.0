Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B13165443
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2020 02:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBTBbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Feb 2020 20:31:13 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38616 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBTBbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:31:12 -0500
Received: by mail-pj1-f66.google.com with SMTP id j17so171654pjz.3;
        Wed, 19 Feb 2020 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VTYOKcE/BhJbY7nh/1sEEvvJdWdmjb089CmjgEwaVVQ=;
        b=H3zAGujKWvvvxdII6XS0AyI1/y7vJciF4QXwIvC/3Scp/7R54IOBVwxJ47vx32OET0
         JrxpgglF9lP4kFMoFAsuwhd3tdRCyvK3Z8VfGUVy89pdH1kGEyrGttdWjG0BgluZx+HZ
         wBf1kiNJBESw9UGIUSWxKwKweu9xM9l+0cXhz4+BL93C6oR19FGZxl0zBAE3c7L07lF7
         J6sKgAoGCqo4N8deJu2pUbERxDBkV8GR9ZVb5xOUt+jI9UwNYgIcfQLst4dPmFANuTRK
         O9dOEjNoZGEamt1sKfeNH4xag6IMLPPjgNzQmfq0+F9VHiNKVE9oCAj4AO5Gj02M6vIu
         c+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTYOKcE/BhJbY7nh/1sEEvvJdWdmjb089CmjgEwaVVQ=;
        b=mR/AGi1A23bKut4ZD0/gZxuquOOtG/GlUIGve9neVGI34ADK7VCt1t9cuTY1W/b96K
         +JltoK/qrGrg0Y3WRqmjFUwaFR3lJrHXcZVZMHXh4Z3FveG5Tjh8sh41TK/qwcniddOU
         HU80HvdH0g2yjdvLpJ7btZivTHXvLAcJR/chbOvhlL66TgewgPWkGLZYquSO9wVMXSfy
         dxtex/9bsza710MBL04Nn7ehfdRMN0ct+8B44LxWF6SV0rgvoVG/VrVghOQeNKSU6bmt
         cUvIToEg03p+NLxHkBmo8STL06KZ/GjYEGNeF2FQQcavVknUNlykJrG5IqeAdZiaJR/B
         b2ew==
X-Gm-Message-State: APjAAAUFwfJPLFWqjnak+vMrTUyVFLVrtOYIaLuEXIuyxPCXhM66bGCU
        6QNNGyTzxM7pTfPPJPvWVyJfDgBTbcw=
X-Google-Smtp-Source: APXvYqzUKd/8lgk9DC8R1lfU3As3UyIjFO8WLn5OvfEmCv4lHwU7uK0itLIPeAUDBlOEbyIOonWQhw==
X-Received: by 2002:a17:90a:8a08:: with SMTP id w8mr634692pjn.125.1582162272177;
        Wed, 19 Feb 2020 17:31:12 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w189sm843105pfw.157.2020.02.19.17.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2020 17:31:11 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     arnd@arndb.de, sfr@canb.auug.org.au, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: host: hsq: Add missing MODULE_LICENSE() and MODULE_DESCRIPTION()
Date:   Thu, 20 Feb 2020 09:30:01 +0800
Message-Id: <98ce471185f037fce57520763621590588766381.1582161803.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_LICENSE() and MODULE_DESCRIPTION() in hsq driver to
fix below warning when compiling the hsq as a module.

"WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/mmc_hsq.o".

Fixes: eb1814dd49d5 ("mmc: Add MMC host software queue support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/mmc_hsq.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
index 2011988..59d2776 100644
--- a/drivers/mmc/host/mmc_hsq.c
+++ b/drivers/mmc/host/mmc_hsq.c
@@ -8,6 +8,7 @@
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/module.h>
 
 #include "mmc_hsq.h"
 
@@ -341,3 +342,6 @@ int mmc_hsq_resume(struct mmc_host *mmc)
 	return mmc_hsq_enable(mmc, NULL);
 }
 EXPORT_SYMBOL_GPL(mmc_hsq_resume);
+
+MODULE_DESCRIPTION("MMC Host Software Queue support");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

