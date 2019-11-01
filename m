Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C479EBDB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 07:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfKAGPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 02:15:47 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:45244 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKAGPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 02:15:47 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id xA16ELBd016348;
        Fri, 1 Nov 2019 15:14:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xA16ELBd016348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572588863;
        bh=i3mAUJKjHAwllmd7KANZFUaKrxZfgZZBSwsGJnV7Xbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPc3vgN83gq/1DFpYm2jc42MVPmVXAyW/Lg2mxWgvu1ZAu0bN1KYxqRvmNONYWFk3
         gaUQbkdfqWaDEZ2BcXD9Si4l6mpnff26BF+UBdrTZLRrMCTujMwF3QcBsWjbcgkcOF
         2XbnAVCrdwv3ty0YJtZg3c+4DVaAZKk3gkjpX0FwnK4VsdT89nJli9OWVsMEH9B2G4
         hss+ENiiJCQFP5NOVFqIIOBCByvo34NugeyFLi+nkDC66Xc3GjYRkp6KQ2rDBUrSMD
         JlBahWfNsllQ39/AajGZsAZRYAix+l2RjQ37GhjRbqpYTT/40NjdAoGwDVMHt+Y2WS
         XMwjT6UgHMK7w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] libfdt: add SPDX-License-Identifier to libfdt wrappers
Date:   Fri,  1 Nov 2019 15:14:09 +0900
Message-Id: <20191101061411.16988-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101061411.16988-1-yamada.masahiro@socionext.com>
References: <20191101061411.16988-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are kernel source code even though they are just two-line wrappers.

Files without explicit license information fall back to GPL-2.0-only,
which is the project default.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/fdt.c            | 1 +
 lib/fdt_empty_tree.c | 1 +
 lib/fdt_ro.c         | 1 +
 lib/fdt_rw.c         | 1 +
 lib/fdt_strerror.c   | 1 +
 lib/fdt_sw.c         | 1 +
 lib/fdt_wip.c        | 1 +
 7 files changed, 7 insertions(+)

diff --git a/lib/fdt.c b/lib/fdt.c
index 97f20069fc37..041f8922a23c 100644
--- a/lib/fdt.c
+++ b/lib/fdt.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt.c"
diff --git a/lib/fdt_empty_tree.c b/lib/fdt_empty_tree.c
index 5d30c58150ad..452221227bf3 100644
--- a/lib/fdt_empty_tree.c
+++ b/lib/fdt_empty_tree.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_empty_tree.c"
diff --git a/lib/fdt_ro.c b/lib/fdt_ro.c
index f73c04ea7be4..9f696d19f060 100644
--- a/lib/fdt_ro.c
+++ b/lib/fdt_ro.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_ro.c"
diff --git a/lib/fdt_rw.c b/lib/fdt_rw.c
index 0c1f0f4a4b13..2a61e9c6dd44 100644
--- a/lib/fdt_rw.c
+++ b/lib/fdt_rw.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_rw.c"
diff --git a/lib/fdt_strerror.c b/lib/fdt_strerror.c
index 8713e3ff4707..4554e5fdac12 100644
--- a/lib/fdt_strerror.c
+++ b/lib/fdt_strerror.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_strerror.c"
diff --git a/lib/fdt_sw.c b/lib/fdt_sw.c
index 9ac7e50c76ce..d3345ca399cf 100644
--- a/lib/fdt_sw.c
+++ b/lib/fdt_sw.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_sw.c"
diff --git a/lib/fdt_wip.c b/lib/fdt_wip.c
index 45b3fc3d3ba1..9674d4c3b115 100644
--- a/lib/fdt_wip.c
+++ b/lib/fdt_wip.c
@@ -1,2 +1,3 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #include <linux/libfdt_env.h>
 #include "../scripts/dtc/libfdt/fdt_wip.c"
-- 
2.17.1

