Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2871759
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfGWLrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:47:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfGWLrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:47:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NBkrb4062387
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 04:46:53 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NBkrb4062387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563882414;
        bh=qT+FDup0Me5aVWQhadL8fdnMwdNwLZvNaBXtadYdgBc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=cflKZwxIhx2gxMze4DfcNoJ7D/sA/Xdw8SS/P2o6qmoY5iNn4kMtVK1x0lATdght1
         L7N2kIrIrFuKVlUJf9TfUSwLpWTFxg44CQtApnRTk9mxACPz4bzEsexADMKIGk8Jtj
         kKt1ZUC6YPUFPW38vuPof7Xn/Li6CKW4LhhciqBQbjw76pgJBgqWB1vKfqogra+i7+
         ej+t+5VuAWO70WgLqyEgUP38spDZwDQffWqioENlbS2t8SqZJRtuO9LapUrZnrq/yo
         ShMg/roduaWvueiyV2fctS31AAYWmnR/oD50+gE/inKEVrOoeSDU2hv+0GuAs2KE07
         X0Oypuy1fA3Wg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NBkrjZ062384;
        Tue, 23 Jul 2019 04:46:53 -0700
Date:   Tue, 23 Jul 2019 04:46:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-701010532164eaacd415ec5683717da03f4b822d@git.kernel.org>
Cc:     yamada.masahiro@socionext.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
Reply-To: yamada.masahiro@socionext.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20190723112646.14046-1-yamada.masahiro@socionext.com>
References: <20190723112646.14046-1-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Remove unneeded uapi asm-generic
 wrappers
Git-Commit-ID: 701010532164eaacd415ec5683717da03f4b822d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  701010532164eaacd415ec5683717da03f4b822d
Gitweb:     https://git.kernel.org/tip/701010532164eaacd415ec5683717da03f4b822d
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 23 Jul 2019 20:26:45 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 23 Jul 2019 13:42:14 +0200

x86/build: Remove unneeded uapi asm-generic wrappers

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190723112646.14046-1-yamada.masahiro@socionext.com

---
 arch/x86/include/uapi/asm/errno.h    | 1 -
 arch/x86/include/uapi/asm/fcntl.h    | 1 -
 arch/x86/include/uapi/asm/ioctl.h    | 1 -
 arch/x86/include/uapi/asm/ioctls.h   | 1 -
 arch/x86/include/uapi/asm/ipcbuf.h   | 1 -
 arch/x86/include/uapi/asm/param.h    | 1 -
 arch/x86/include/uapi/asm/resource.h | 1 -
 arch/x86/include/uapi/asm/termbits.h | 1 -
 arch/x86/include/uapi/asm/termios.h  | 1 -
 arch/x86/include/uapi/asm/types.h    | 7 -------
 10 files changed, 16 deletions(-)

diff --git a/arch/x86/include/uapi/asm/errno.h b/arch/x86/include/uapi/asm/errno.h
deleted file mode 100644
index 4c82b503d92f..000000000000
--- a/arch/x86/include/uapi/asm/errno.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/errno.h>
diff --git a/arch/x86/include/uapi/asm/fcntl.h b/arch/x86/include/uapi/asm/fcntl.h
deleted file mode 100644
index 46ab12db5739..000000000000
--- a/arch/x86/include/uapi/asm/fcntl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/fcntl.h>
diff --git a/arch/x86/include/uapi/asm/ioctl.h b/arch/x86/include/uapi/asm/ioctl.h
deleted file mode 100644
index b279fe06dfe5..000000000000
--- a/arch/x86/include/uapi/asm/ioctl.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctl.h>
diff --git a/arch/x86/include/uapi/asm/ioctls.h b/arch/x86/include/uapi/asm/ioctls.h
deleted file mode 100644
index ec34c760665e..000000000000
--- a/arch/x86/include/uapi/asm/ioctls.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ioctls.h>
diff --git a/arch/x86/include/uapi/asm/ipcbuf.h b/arch/x86/include/uapi/asm/ipcbuf.h
deleted file mode 100644
index 84c7e51cb6d0..000000000000
--- a/arch/x86/include/uapi/asm/ipcbuf.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/ipcbuf.h>
diff --git a/arch/x86/include/uapi/asm/param.h b/arch/x86/include/uapi/asm/param.h
deleted file mode 100644
index 965d45427975..000000000000
--- a/arch/x86/include/uapi/asm/param.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/param.h>
diff --git a/arch/x86/include/uapi/asm/resource.h b/arch/x86/include/uapi/asm/resource.h
deleted file mode 100644
index 04bc4db8921b..000000000000
--- a/arch/x86/include/uapi/asm/resource.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/resource.h>
diff --git a/arch/x86/include/uapi/asm/termbits.h b/arch/x86/include/uapi/asm/termbits.h
deleted file mode 100644
index 3935b106de79..000000000000
--- a/arch/x86/include/uapi/asm/termbits.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termbits.h>
diff --git a/arch/x86/include/uapi/asm/termios.h b/arch/x86/include/uapi/asm/termios.h
deleted file mode 100644
index 280d78a9d966..000000000000
--- a/arch/x86/include/uapi/asm/termios.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/termios.h>
diff --git a/arch/x86/include/uapi/asm/types.h b/arch/x86/include/uapi/asm/types.h
deleted file mode 100644
index df55e1ddb0c9..000000000000
--- a/arch/x86/include/uapi/asm/types.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_TYPES_H
-#define _ASM_X86_TYPES_H
-
-#include <asm-generic/types.h>
-
-#endif /* _ASM_X86_TYPES_H */
