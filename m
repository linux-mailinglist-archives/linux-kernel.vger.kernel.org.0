Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E6B2AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2019 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfINKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Sep 2019 06:32:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40398 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfINKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 06:32:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so19634155pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMiRV74Zi6buasstnWsWMf+sxpVUSgy2RNkWLC1ySAE=;
        b=tjH2DXWIPJzMfUSGBjiZfSkXXIQTgolVoS+0vo/XQEAfCNjqjf6Ju8suZBkH+2eZcm
         7PWa+s9Ziw7iONfCgiBlZaGaBnERRJnMteqG5mBl8NwxxufyGe9xiXzmUaI+JG5Rskua
         6bzzgC0J2PTRKoZW+XhwVav3w6zqFQ/ye/ZNPBV524Nh/LvhvFtT/yValIv0RFO27HOG
         6xzrqysvdx1qTftOdUsEPyfoHkkvX4uqrr2IwPLlvWm7JR6JSl8XFVgvI1ejH/mJhv84
         k1ckzRHy0D2ftLqI72m4xT6x/zmPZkrXZ4AfByNmX13FnboFM7AAcpzDH0FssB8IjNhz
         msUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kMiRV74Zi6buasstnWsWMf+sxpVUSgy2RNkWLC1ySAE=;
        b=Ex1IQGU5rvHyU/5bGaIDns1a/kksoHyOu7keT2TM5U3YGqgbQcwtBmrarjPZ/vB3VZ
         O1Qq8KSD4yrECWiUiAcDKLpV7TZFkBn/o4tvHphqHK7syx4oApIsm4By9g8fBBh31zfw
         KBuSsiRV/df7K5Iaf/xL6qNgvnmG/C4AOct7xz+yrFR/NnNqZBbeXSr6xYB9efNpiDkC
         SuDBBnnJIIUlxu7dZIX529kUBQWDNMZUvP1DUzVZGY1mzraRiMckX9SaPvUvc7wijcVq
         5GO1Op7If/BSmPZWMMSGuqsJDc53l7zlVGTa+Gb26DZMQwTtvQ4ZsQ1wPhbNpzJp2RNT
         Q72w==
X-Gm-Message-State: APjAAAWGlLx/74KsYjqf/288lmYMaLtQakBHVjstgyJjyKyQxyEKGR1p
        HG54Sr7BZiDodhLXUaYO+DpdCUnKKDc2Zw==
X-Google-Smtp-Source: APXvYqwA3Q6JIegT9xwctFSiqW7xDEHwxnKE9YSfS9H7X9l/pgoGIaberQJDu83cH8oI5fk7OozS4w==
X-Received: by 2002:a63:487:: with SMTP id 129mr20664438pge.14.1568457145610;
        Sat, 14 Sep 2019 03:32:25 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id z2sm2345536pfq.58.2019.09.14.03.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 03:32:24 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm, tracing: print symbol name for call_site
Date:   Sat, 14 Sep 2019 18:32:15 +0800
Message-Id: <20190914103215.23301-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve the readability of raw slab trace points, print the call_site ip
using '%pS'. Then we can grep events with function names.

[002] ....   808.188897: kmem_cache_free: call_site=putname+0x47/0x50 ptr=00000000cef40c80
[002] ....   808.188898: kfree: call_site=security_cred_free+0x42/0x50 ptr=0000000062400820
[002] ....   808.188904: kmem_cache_free: call_site=put_cred_rcu+0x88/0xa0 ptr=0000000058d74ef8
[002] ....   808.188913: kmem_cache_alloc: call_site=prepare_creds+0x26/0x100 ptr=0000000058d74ef8 bytes_req=168 bytes_alloc=576 gfp_flags=GFP_KERNEL
[002] ....   808.188917: kmalloc: call_site=security_prepare_creds+0x77/0xa0 ptr=0000000062400820 bytes_req=8 bytes_alloc=336 gfp_flags=GFP_KERNEL|__GFP_ZERO
[002] ....   808.188920: kmem_cache_alloc: call_site=getname_flags+0x4f/0x1e0 ptr=00000000cef40c80 bytes_req=4096 bytes_alloc=4480 gfp_flags=GFP_KERNEL
[002] ....   808.188925: kmem_cache_free: call_site=putname+0x47/0x50 ptr=00000000cef40c80
[002] ....   808.188926: kfree: call_site=security_cred_free+0x42/0x50 ptr=0000000062400820
[002] ....   808.188931: kmem_cache_free: call_site=put_cred_rcu+0x88/0xa0 ptr=0000000058d74ef8

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 include/trace/events/kmem.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..69e8bb8963db 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -35,8 +35,8 @@ DECLARE_EVENT_CLASS(kmem_alloc,
 		__entry->gfp_flags	= gfp_flags;
 	),
 
-	TP_printk("call_site=%lx ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
-		__entry->call_site,
+	TP_printk("call_site=%pS ptr=%p bytes_req=%zu bytes_alloc=%zu gfp_flags=%s",
+		(void *)__entry->call_site,
 		__entry->ptr,
 		__entry->bytes_req,
 		__entry->bytes_alloc,
@@ -131,7 +131,8 @@ DECLARE_EVENT_CLASS(kmem_free,
 		__entry->ptr		= ptr;
 	),
 
-	TP_printk("call_site=%lx ptr=%p", __entry->call_site, __entry->ptr)
+	TP_printk("call_site=%pS ptr=%p",
+		  (void *)__entry->call_site, __entry->ptr)
 );
 
 DEFINE_EVENT(kmem_free, kfree,
-- 
2.20.1

