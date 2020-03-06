Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18BA17BEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 14:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCFNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 08:34:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38677 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgCFNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:34:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so1098416pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
        b=CWFn0tyDo9JZs2lNrD41BAJ4FYYXtubQgLEyqGbdrXaPiq8nKRlFnlenYaD7PE9poi
         oeqOBMNOUQy5NPXu1mBQtixa+kyhMtE/4TRssTG1+t8ubrXmfy3kflbZaOxODSfFuLPM
         JbpK+lnSfei/S7mGFRL6KFYYIfa/m7zaeq9Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
        b=F5hStl9uWwiMnHWBbBkGHnoTx1RCZuv1Sx7gWWKxqaWYh4rqVz/J6l1q3M89SuSwSd
         W/pgr4ws6SODsB0qWbpXl1ouLPm5qMMQD/m+BLJYrP6VIbAdOiizgk7MsrKM1mk7G30M
         9txKIwp1+2PJ1sWnTTX67paINySkTv7/qtWrkLM0Pf/JPdcF3t5lJIDhOaklGYqKd7ba
         T1aLrOgVk/uKD78/LaH3epJkBfWrBVwoQ2OgSFh9/dk8fh9rJYa16L7RDie3ys3/Lefx
         H0oR3FBmaM/rXZ608K2Foe4RILytC9dHCBLf20HbLqe0xDAzzbT+hrKmYZ+ormwD03kX
         EGgQ==
X-Gm-Message-State: ANhLgQ043e/DDyFYDiqidGhPcBB7sjoAxFEWACwy/uvv77A/NCK5OVZB
        vHK2pYxwyDHgz7swfO8babWP6QVqDRU=
X-Google-Smtp-Source: ADFU+vtM+hD79zVrOAKJj6crqdq9PhclAqcipwr5yuRGc/QEF+mE8eHmtWybhyLO5lTezva6d9lQ+w==
X-Received: by 2002:a63:3d48:: with SMTP id k69mr3197323pga.395.1583501643532;
        Fri, 06 Mar 2020 05:34:03 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b120-f113-a8cb-35fd.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b120:f113:a8cb:35fd])
        by smtp.gmail.com with ESMTPSA id h4sm10196858pfr.107.2020.03.06.05.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:34:02 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 2/4] kasan: Document support on 32-bit powerpc
Date:   Sat,  7 Mar 2020 00:33:38 +1100
Message-Id: <20200306133340.9181-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306133340.9181-1-dja@axtens.net>
References: <20200306133340.9181-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Document s390 support while we're at it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Changes since v5:
 - rebase - riscv has now got support.
 - document s390 support while we're at it
 - clarify when kasan_vmalloc support is required
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..012ef3d91d1f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures. It is also supported on 32-bit powerpc kernels. Tag-based 
+KASAN is supported only on arm64.
 
 Usage
 -----
@@ -255,7 +256,9 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently this supported on x86, s390
+and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
+with module support, where it is required.
 
 This works by hooking into vmalloc and vmap, and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.20.1

