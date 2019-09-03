Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF74A7353
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 21:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfICTNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 15:13:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35924 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfICTNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:13:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so8306010plr.3;
        Tue, 03 Sep 2019 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGI2PbPIJQALrxl14ziGNHj3QYOWoIQatp475h7SnX0=;
        b=qAtXA0e8WdSGRQ3ajL4OLTJPMnyLQNbP9S2ShIFHuHR5hOM+62ZietAU+9mh+34NK9
         4vKheyVkai6NGUr95Qf7Ad90n3EvTzuNtNXxEXY5DPC5iR4s/OaGQ3DV/aAlu0RYAX4Z
         NwhrhbRub0kxEu11fJfusyw1+YAXVxl9DBQMbqOP14Ce0t61JMndP1O29C9FTr1mWKeM
         5f6WYNc6+d8mt0+Y9f32/ytCEqWJa7Q66AZ3RBRacy2jPOxICQIPIetV4oJvAgR8GlRy
         SmCvUYQ6snAtZ/1vbNDabhCuAXG+pFDG9qcwD8GJngzC8nOZsDehMe2v6LQzvkWYw2ty
         CcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aGI2PbPIJQALrxl14ziGNHj3QYOWoIQatp475h7SnX0=;
        b=iW8Fs4FzRdcW5sJD0VuAl2KPmxl2js6xUzpLJqAY52W4nXPw7BLjmwp41ALeruEGZl
         NADh6BacIXJqbN4LRe0/VgzJFBZDgmuH3xG935uvDRu0Vjj6ivmCXpDQTyQDNeSw2EUQ
         ENv6V0cceKEy+BQmlD9fQO/VhHX5kvhHvU7WqECMZTJtBjQRvV9Hn945hRjJQWfhuJr0
         3xR4K3Xu7H3eG8EGmnpgtSEvczzVtoCW6MS7PdJicatKwXsdmPLjaXu6TvaNrQJX/7nk
         1LyjldsOVo3dpzHCFynYOgvshgb9wch+0WfJKJJDblsMGZO0szDKFAPqHynoqCXQrRxx
         hvWw==
X-Gm-Message-State: APjAAAV7i38J3clVminqhZW1s+U4Hf7Q/PXbO3+cDnHgxO2b0ymI1/yk
        lFb6RSE+MX2EvqOpzPc4hm/cl77Q
X-Google-Smtp-Source: APXvYqxaCu86zrm4zGGsidJnCOntcGmvnJbxy1KNbIMqvjqOorUhebhZ/DRO9GCJxf2D098XLI4/Dg==
X-Received: by 2002:a17:902:20c2:: with SMTP id v2mr33879476plg.209.1567538026954;
        Tue, 03 Sep 2019 12:13:46 -0700 (PDT)
Received: from sultan-box.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id 67sm318952pjo.29.2019.09.03.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 12:13:45 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     sultan@kerneltoast.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, sebastian@breakpoint.cc,
        tglx@linutronix.de, rostedt@goodmis.org
Subject: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h directly
Date:   Tue,  3 Sep 2019 12:13:21 -0700
Message-Id: <20190903191321.6762-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Architecture-specific uaccess.h headers can have dependencies on
linux/uaccess.h (i.e., VERIFY_WRITE), so it cannot be included directly.
Since linux/uaccess.h includes asm/uaccess.h, just do that instead.

This fixes compile errors with certain kernels and architectures.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 src/backfire/backfire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/backfire/backfire.c b/src/backfire/backfire.c
index aaf9c4a..a8ac9f5 100644
--- a/src/backfire/backfire.c
+++ b/src/backfire/backfire.c
@@ -30,8 +30,8 @@
 #include <linux/miscdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 
-#include <asm/uaccess.h>
 #include <asm/system.h>
 
 #define BACKFIRE_MINOR MISC_DYNAMIC_MINOR
-- 
2.23.0

