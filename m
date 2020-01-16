Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE713D8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 12:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAPLOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 06:14:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39567 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPLOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:14:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so18718745wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9Q5677Ur8luUcGkjg5jrHlKUFNub/5xyB+iK5Dfa/s=;
        b=jYfYaY1Y6tNtnRFTCmbfc0F8+6Msw8UQArIB4KgtZVxXojOX7OKT+38UZSMgu4+9Yn
         xClOjGo46iBLZWRmKkPkzVe+1InGWGuhMhp4teIj0Cyn7T/ZTY9sbhLxTZMYxXLrGQ9N
         wb/RxUTh5u0pyfy0fzVGfAyQjlnEiqEkneEzPohuJlhhsKrUZ+9jw98Mgmp71i3Wozut
         /RH/skJplLqwzHY8UvJt6m/Ifhh73fMww3qDnx1wiVsZMkC0WBEobaK4InoVVQB4T3zp
         hm0pxGoOA/P37+fWny+NOEuiMJMjDNXK3b7zcuLaOLHAPG5xBuEaP3FWLIhrD3bkatLw
         ql4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9Q5677Ur8luUcGkjg5jrHlKUFNub/5xyB+iK5Dfa/s=;
        b=ffbdSRb3i88QyBm39VfQcN3CnnckS1T0cwd3k/Tq8UuIoN10rA/DwN/AgsQiPl2qIS
         +oQ6br+zzkxF5c1nActqkJsXV02fesTKxQKL1XHOMDTszheC7cDh4BfysOGctZgVjKou
         6YKekzIzQEqa4augqXBcwwd6z+o+txJkvalPiC5KVbn1pcq/E8IHU2PKAs28VLZdn4oD
         B/5FwdQdeqG/P8CnjuTsVhcPiJzOywEJOproR/WxIKBbfHqp5Dtbm9aqryX908PDxIpI
         aPHnfT09eWvOaKQGejmIUzTzMGg+6iNqmA0+sW9Z6JIvGVYYgEDTv/0erEP0mGwQkX5r
         i8dQ==
X-Gm-Message-State: APjAAAUGY91v4lBYst/61X0NmzYl7quWyB9fH+j5+sYKA8Q2RgpqXC9l
        i6QFIF3o7hzY2y13HY3CEyADOn//I6k=
X-Google-Smtp-Source: APXvYqx0CXV5gVBMYwHmkz1J0LkphHRM8RPwbH6gJgYhylUNLOT9aC2Itcv3FJmB1fCRQ/q1PH9G2A==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr2748995wre.390.1579173293323;
        Thu, 16 Jan 2020 03:14:53 -0800 (PST)
Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:15:13:aecf:473e:300f:893f])
        by smtp.gmail.com with ESMTPSA id w19sm3573792wmc.22.2020.01.16.03.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 03:14:52 -0800 (PST)
From:   Dmitry Vyukov <dvyukov@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kcov: ignore fault-inject and stacktrace
Date:   Thu, 16 Jan 2020 12:14:49 +0100
Message-Id: <20200116111449.217744-1-dvyukov@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

Don't instrument 3 more files that contain debugging facilities and
produce large amounts of uninteresting coverage for every syscall.
The following snippets are sprinkled all over the place in kcov
traces in a debugging kernel. We already try to disable instrumentation
of stack unwinding code and of most debug facilities. I guess we
did not use fault-inject.c at the time, and stacktrace.c was somehow
missed (or something has changed in kernel/configs).
This change both speeds up kcov (kernel doesn't need to store these
PCs, user-space doesn't need to process them) and frees trace buffer
capacity for more useful coverage.

should_fail
lib/fault-inject.c:149
fail_dump
lib/fault-inject.c:45

stack_trace_save
kernel/stacktrace.c:124
stack_trace_consume_entry
kernel/stacktrace.c:86
stack_trace_consume_entry
kernel/stacktrace.c:89
... a hundred frames skipped ...
stack_trace_consume_entry
kernel/stacktrace.c:93
stack_trace_consume_entry
kernel/stacktrace.c:86

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
---
 kernel/Makefile | 1 +
 lib/Makefile    | 1 +
 mm/Makefile     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index e5ffd8c002541..5d935b63f812a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -30,6 +30,7 @@ KCSAN_SANITIZE_softirq.o = n
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
 KCOV_INSTRUMENT_extable.o := n
+KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
diff --git a/lib/Makefile b/lib/Makefile
index 004a4642938af..6cd19bb3085c5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -16,6 +16,7 @@ KCOV_INSTRUMENT_rbtree.o := n
 KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
+KCOV_INSTRUMENT_fault-inject.o := n
 
 # Early boot use of cmdline, don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/mm/Makefile b/mm/Makefile
index 3c53198835479..c9696f3ec8408 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -28,6 +28,7 @@ KCOV_INSTRUMENT_kmemleak.o := n
 KCOV_INSTRUMENT_memcontrol.o := n
 KCOV_INSTRUMENT_mmzone.o := n
 KCOV_INSTRUMENT_vmstat.o := n
+KCOV_INSTRUMENT_failslab.o := n
 
 CFLAGS_init-mm.o += $(call cc-disable-warning, override-init)
 CFLAGS_init-mm.o += $(call cc-disable-warning, initializer-overrides)
-- 
2.25.0.rc1.283.g88dfdc4193-goog

