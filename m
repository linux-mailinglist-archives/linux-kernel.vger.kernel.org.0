Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A6013CC44
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jan 2020 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgAOSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 13:42:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgAOSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id f15so13496052lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4QYp6yta8D4hncQL3H9VMXxnJ25IQhNSEz9TzMnb1c=;
        b=DvJRU+pBPQUbOPFz4leoIvHQBaRtEmz/RhjJUX9CdjMa19dqzbHIPNn2TiAl1/tOG6
         lSG6MWUZoaFr13wlrVRwH5r9K39zZIyh+hWb9AJ/65FRexEXLZ5kFna6GHaIsqW8TpWE
         ZkXXl4tnvx1ITQfG6RWFDgOjGADkVg+QLvKkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4QYp6yta8D4hncQL3H9VMXxnJ25IQhNSEz9TzMnb1c=;
        b=deCpCMPv0A4ikvJ6GKsoZTkFXW3MhVsabI0K5Ow2buN0t9ewobv3yg+2veMIu/QxOu
         RpMF6fuAQODs+QqR4EXBTGAHBepFE50KSEh6j4e6ORfM5Owpd0uP8l7NrN/ZidYn/t3v
         okIVODYCQwd7M5MnnNgVYTsDWMw95y5ut/j/AXpccoCEbMLqSYBNVtX8r5hBL7kglu36
         9O5pjxuONmUH7ceg5YmS7GIR4P3y5MmRpUNi0K+FOKdGAkTSarMzmDBMkiH4n5dxsb0T
         ZgZ7NsUTSQSvrKIbs1AldCpZifRNkowQg9bpzd3ZLKBC84LNSORmlvVL/Ys244ftXQ5V
         ZAIw==
X-Gm-Message-State: APjAAAVhNR16kYo+22+GWCB0pS0hfrKfex4fmSscN4cVaaNBEUh72/xP
        S2PPuJq8MaWra6z9KLvVQqDXZg==
X-Google-Smtp-Source: APXvYqz30vArEaA4IT/Wv3bgiEK6ZVFYHi4hJYTpoVmLVDzXu83+eGlqlVaoGKDJM8z0w+YzkHdVQg==
X-Received: by 2002:ac2:5195:: with SMTP id u21mr146171lfi.141.1579113722025;
        Wed, 15 Jan 2020 10:42:02 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:42:01 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] devtmpfs: initify a bit
Date:   Wed, 15 Jan 2020 19:41:52 +0100
Message-Id: <20200115184154.3492-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
References: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devtmpfs_mount() is only called from prepare_namespace() in
init/do_mounts.c, which is an __init function, so devtmpfs_mount() can
also be moved to .init.text.

Then the mount_dev static variable is only referenced from __init
functions (devtmpfs_mount and its initializer function mount_param).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 693390d9c545..56632fb22fc0 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -30,7 +30,7 @@
 
 static struct task_struct *thread;
 
-static int mount_dev = IS_ENABLED(CONFIG_DEVTMPFS_MOUNT);
+static int __initdata mount_dev = IS_ENABLED(CONFIG_DEVTMPFS_MOUNT);
 
 static DEFINE_SPINLOCK(req_lock);
 
@@ -355,7 +355,7 @@ static int handle_remove(const char *nodename, struct device *dev)
  * If configured, or requested by the commandline, devtmpfs will be
  * auto-mounted after the kernel mounted the root filesystem.
  */
-int devtmpfs_mount(void)
+int __init devtmpfs_mount(void)
 {
 	int err;
 
-- 
2.23.0

