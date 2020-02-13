Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7915B61A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 01:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgBMAsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 19:48:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42375 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgBMAsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:48:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so1604804plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
        b=f3+zjZPLroh9v/srLMResHUURGulEqa1TIn2eNJbsZT02ZxhHsRPkA9k0qw76MvdTd
         CsvJWPkuISec5SALYDCzKnkeMg0By2NuPdP9hKr5vwQQphWe7SO0/Sq0X91W6zF9B9z6
         ZeG+15K1Hk5r2SlBuRh5E7wT/B8cJA9YraLL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CaOpE+RnykMge29WfCqnRai8zpZuPSzzYfJQc7CCb6s=;
        b=LQPoCQI8ZN5Dt7XT2uIxPtj0DSTPze5/OR3Kn1gCyXLavADh7eaGz1rxNI+hssuhCf
         mlKadwFLyFHAetubnmSiWiVjtieFikMlITqbkpCwEeoRJT9FFfWV976vj8M64BJi/4XO
         Va8GeV9whRwEBKrSaRqYajbYe4oIUEu7DjFKINYHeRVjFw/uRjtNvH20XckqGGajUhCy
         m+PYtaMHk+5WWa4VG16GWm7sejR8JdQN6DSV/LghgSt1fqXkczJqJ4Or0iQt5tfQ+9Kd
         ruzjnT7G77mrrI3F1d30rIeVZWNH2XOwNHG4Hy+KbxhNhNuZfA3kionc6f/GdTrGcBA3
         eGlg==
X-Gm-Message-State: APjAAAU/B6l/7zrS6NjDnjnF2RhWDCplDevkowTlykRvY7n2l5XYUJL9
        ua54+r9eakEDXdeqnNcGjyHwuFgEjOI=
X-Google-Smtp-Source: APXvYqyeOHjQf5Bxk67rYMg6dqoxPmAvSH1SohWbFDUDX4cuyAdfkJPx7JAuve/KqUZz4YX4tZ+rcQ==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr11104973pll.321.1581554887611;
        Wed, 12 Feb 2020 16:48:07 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-f1ea-0ab5-027b-8841.static.ipv6.internode.on.net. [2001:44b8:1113:6700:f1ea:ab5:27b:8841])
        by smtp.gmail.com with ESMTPSA id q7sm297478pgk.62.2020.02.12.16.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 16:48:06 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v7 2/4] kasan: Document support on 32-bit powerpc
Date:   Thu, 13 Feb 2020 11:47:50 +1100
Message-Id: <20200213004752.11019-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213004752.11019-1-dja@axtens.net>
References: <20200213004752.11019-1-dja@axtens.net>
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

