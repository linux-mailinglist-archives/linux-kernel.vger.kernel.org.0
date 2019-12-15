Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E47011F572
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2019 04:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLODsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Dec 2019 22:48:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36490 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfLODsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 22:48:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so2976192pll.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2019 19:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=jp6uIEXB0OuopAT9yMfhpNOpZeeIwahArYrkDImA9oQxbxh5oWnomwKh+L2R/13wlT
         Sv1AnpFbdnG1x4X1TEJyw8ZRm5r9XR9V7eN0afyY1U+WHMePb16P6i38223CiBZuqXs2
         xwf37zY4wmrotHUsajXVN0vVHeSSkyaCXp0/eZWSuRAsM/F8BkdPIzhZgjUm5SZYZmno
         A/7ZiVcyVekBYElm2OLZiC7C9sS6SDEge3OQZrNTgC+2X5EJJ53UiyH4vhHZUZ1Ka1G+
         hggrhnpItb8Ccm3KMpsBQdPqeTODkXTQBxPvvOL7dYpoq5+Q0gYuQ93pBO017ri0Mdgi
         +nWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=famkZXGEeQgX6kTt3zfP2CBx94A2ZSijyfq87h1/O/k=;
        b=R0vSCaEEBESHOrZXp/vVs3A4h6Y7wcl9GBwOlh3aQTnBm4ofat5hQbkgpbvsGx/pbW
         MQMaypjFHb6XXIGdSj5+OofZZF5IW93h0qQOelN14a6bGoaogHQ/VAay+Vc9hbR5U8CU
         2iRB5kKOwdVGxsirh4719DiTxCnuvTL5Fw/7qcafoSdRtmHhq7SE3Flh8X7vVr0YWHpV
         8JTxlFf5sn6cGUyYayT/C3l8PtO351n8/FNhygXNwoOU0XANR5UDEpQhMuUG7W1yI95H
         9N7o61oTnZf6aEPutwQqdipQqwCv4Txcqxg8VhYyz7z6GKi8KbKwByMOSiaH5brxEZPb
         ZgJw==
X-Gm-Message-State: APjAAAWcIW0Cq/pXWvi3t8x7kTicSrt9C8SSqZe1xONUHxNA0fAO/gs3
        loFvdWrzz1s6cBDGtZAJ4nCYZw==
X-Google-Smtp-Source: APXvYqx65HDbWC1AM9rcT+svhoUxIfHBaqpqXemwGlw3ZQFEPumFyJL961GdUH4UUlsCTUfWSM17Pw==
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr9996519pjb.118.1576381731198;
        Sat, 14 Dec 2019 19:48:51 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id e10sm17437727pfm.3.2019.12.14.19.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Dec 2019 19:48:50 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, peng.hao2@zte.com.cn
Cc:     hutao@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2 1/2] misc: pvpanic: move bit definition to uapi header file
Date:   Sun, 15 Dec 2019 11:48:39 +0800
Message-Id: <20191215034840.2273096-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191215034840.2273096-1-pizhenwei@bytedance.com>
References: <20191215034840.2273096-1-pizhenwei@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes outside of the kernel(Ex, QEMU) should know what the
value really is for, so move the bit definition to a uapi file.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/misc/pvpanic.c      | 3 +--
 include/uapi/misc/pvpanic.h | 8 ++++++++
 2 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/misc/pvpanic.h

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 95ff7c5a1dfb..3f0de3be0a19 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -15,11 +15,10 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
 
-#define PVPANIC_PANICKED        (1 << 0)
-
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
new file mode 100644
index 000000000000..cae69a822b25
--- /dev/null
+++ b/include/uapi/misc/pvpanic.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef __PVPANIC_H__
+#define __PVPANIC_H__
+
+#define PVPANIC_PANICKED	(1 << 0)
+
+#endif /* __PVPANIC_H__ */
-- 
2.11.0

