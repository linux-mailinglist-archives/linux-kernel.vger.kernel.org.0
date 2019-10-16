Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1251D94AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbfJPPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 11:01:37 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:55690 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392186AbfJPPBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:01:37 -0400
Received: by mail-wr1-f73.google.com with SMTP id o10so11839706wrm.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rhvfW/MCKGI2uxeEW6Nn+IuXscNU7+I/egjWinp71uE=;
        b=f0n+et9vXhAXbCHqu0gWhPEK6MCzXc906FFde3nnutVDBB1zo+n6ZsPhR/E5C53h6s
         i/diHbdVgi/7rcsvxNtAsSMu3OrO6/KBl2CZB9cLTZU75Qw47nb8E9G+O44hiwbQxKSF
         V2QZW4W9P6DCLu+hwxjI3i8PnB7sHnzxMc73vDMXYPSRGF1Ta2OacJbm/atVXMbQVfg4
         u88i56zouDFSWDrgov598pS+yfNf9FyHwv+xAFyrKJ5fP35+/u6GAqqCimiSvUsP/UFQ
         t+/7a8qZMhiVgk+ldhokMwdZRj5HJRXV+7oPbEn4gFQ7P1avlas5OINJLuGYzNdjNWFd
         bVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rhvfW/MCKGI2uxeEW6Nn+IuXscNU7+I/egjWinp71uE=;
        b=srM+8VbwXvmcCUEuneQyeEi+Vpkk2CjnR5+E1go0QHi29uzEXsYpCn6A3rqLLkkRUo
         v3Rg5bK8HwgVpjOgOxAjnPmIBtOwm0bzVxlH3m9fgufTBSc1o97I5O3nkBRPG8WqHezl
         8sZtc6Eht29wtD4wbAok+CwFceji6mWQ3ptdbe9LtJu01+f/whHUldKnBIeu8OBByHbQ
         3NNkAmydrS/aPEvvUzsvLYIhgYii8F8Uqj85yeK6ACLAU4B4KjYMTSY1y0X7Se7IKZBA
         l2VKyqYtZhkQc/+ZV+YXDnjenDgrMYcbxpPqrneKZE0nkil55lLK70I3TBFco60G1AQt
         nejQ==
X-Gm-Message-State: APjAAAUM0JIQj0lqVm5pyImTPlv249hCrIR9ZWxMk+Lk1menAwe72Kje
        QB1VZtwlV9sDVhoh0jmKLQb/BLNPDw==
X-Google-Smtp-Source: APXvYqzWLNszz1Nx7EBZhwr8CSMAeG/Ushr6nHeHKyszLYbN/KtaEJqXIILl35ZKwECUm9JFDurNyMR+fA==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr2996914wru.4.1571238093597;
 Wed, 16 Oct 2019 08:01:33 -0700 (PDT)
Date:   Wed, 16 Oct 2019 17:01:19 +0200
In-Reply-To: <20191016150119.154756-1-jannh@google.com>
Message-Id: <20191016150119.154756-2-jannh@google.com>
Mime-Version: 1.0
References: <20191016150119.154756-1-jannh@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 2/2] binder: Use common definition of SZ_1K
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>, jannh@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SZ_1K has been defined in include/linux/sizes.h since v3.6. Get rid of the
duplicate definition.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/android/binder.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 265d9dd46a5e..a606262da9d6 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -65,6 +65,7 @@
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
+#include <linux/sizes.h>
 
 #include <uapi/linux/android/binder.h>
 #include <uapi/linux/android/binderfs.h>
@@ -92,11 +93,6 @@ static atomic_t binder_last_id;
 static int proc_show(struct seq_file *m, void *unused);
 DEFINE_SHOW_ATTRIBUTE(proc);
 
-/* This is only defined in include/asm-arm/sizes.h */
-#ifndef SZ_1K
-#define SZ_1K                               0x400
-#endif
-
 #define FORBIDDEN_MMAP_FLAGS                (VM_WRITE)
 
 enum {
-- 
2.23.0.700.g56cf767bdb-goog

