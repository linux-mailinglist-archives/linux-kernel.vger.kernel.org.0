Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102DDC2DB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfJAG6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 02:58:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 02:58:54 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so7233169pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=Gx7gIW3x3squ3y11zfOfQ1ZBli6TkEOQ33zi9GFCPQK2YcyghC59kpCYg5f0EVyGRW
         q5wJ6EIFrf6eLWSrtM9s1W5+WKi46UaZlDGrSUbjgbVkcZhUI1EHLxyKyToDTMkth4My
         as7GtsfxQ+dR47o5chjl/YgN1PGNPlrHFNF4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HNDV9DT7O32N2h9l7CrACdWJSzNVfR3Dv9pnUT55kOg=;
        b=ex74vzW8mrNfOYxfjr2/dFos5iWUA5n3IK8Q2O3B1/6TJFsB2HBSwxqpOXvDli7po3
         XKQEgVfaWJqA19zTmRYR7Qm8g4uMPJyRTrLCE+Q4VY47HUz368eAGqcWcEuOIc/hn+ty
         qwiwwVkvdClfeG7DvjVfXsit1TITzcTP/A1mntW3G6Y9vsFRoqCQ4DTB1IjUBvb9CvLU
         KG/H01Q1trKr+W8EXIfZS9MpZivItdGwAd7g5kL8mXzdYcaqi1hdvnvag+qqa5lhKINV
         vJMsSWK/0mE1d+QGLpxuPICnnOBW6qxYwgx2DILSc8oiD/CzHbD/NSuB5tab7p1V9p/r
         +RHg==
X-Gm-Message-State: APjAAAVYekfDEjyRmod/BXvVbkQreAR2tmpP6epg5rOICl8oHfLGLhkL
        /coluAXAyV+e0iWpnbN6wSmkTQ==
X-Google-Smtp-Source: APXvYqxX5bXBSKjbx/YPzaTdemix1S6Kf3a5bE+LnOqnqicfCmdl+DradsXFotWCoxRjeei74QUFhg==
X-Received: by 2002:aa7:9a5b:: with SMTP id x27mr25409842pfj.232.1569913132672;
        Mon, 30 Sep 2019 23:58:52 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id u31sm29081976pgn.93.2019.09.30.23.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 23:58:51 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 2/5] kasan: add test for vmalloc
Date:   Tue,  1 Oct 2019 16:58:31 +1000
Message-Id: <20191001065834.8880-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001065834.8880-1-dja@axtens.net>
References: <20191001065834.8880-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test kasan vmalloc support by adding a new test to the module.

Signed-off-by: Daniel Axtens <dja@axtens.net>

--

v5: split out per Christophe Leroy
---
 lib/test_kasan.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 49cc4d570a40..328d33beae36 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/vmalloc.h>
 
 #include <asm/page.h>
 
@@ -748,6 +749,30 @@ static noinline void __init kmalloc_double_kzfree(void)
 	kzfree(ptr);
 }
 
+#ifdef CONFIG_KASAN_VMALLOC
+static noinline void __init vmalloc_oob(void)
+{
+	void *area;
+
+	pr_info("vmalloc out-of-bounds\n");
+
+	/*
+	 * We have to be careful not to hit the guard page.
+	 * The MMU will catch that and crash us.
+	 */
+	area = vmalloc(3000);
+	if (!area) {
+		pr_err("Allocation failed\n");
+		return;
+	}
+
+	((volatile char *)area)[3100];
+	vfree(area);
+}
+#else
+static void __init vmalloc_oob(void) {}
+#endif
+
 static int __init kmalloc_tests_init(void)
 {
 	/*
@@ -793,6 +818,7 @@ static int __init kmalloc_tests_init(void)
 	kasan_strings();
 	kasan_bitops();
 	kmalloc_double_kzfree();
+	vmalloc_oob();
 
 	kasan_restore_multi_shot(multishot);
 
-- 
2.20.1

