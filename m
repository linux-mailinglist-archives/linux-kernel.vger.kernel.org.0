Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 327A9FAAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfKMHOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 02:14:53 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:17549 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfKMHOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:14:53 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id xAD7COMU032236;
        Wed, 13 Nov 2019 16:12:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com xAD7COMU032236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573629145;
        bh=hUWxEOEKcTupHyB6KArKI0LSBUkIGOpAbtR0Bqznip4=;
        h=From:To:Cc:Subject:Date:From;
        b=n2KG6wYPBHKlFa4U7nisZquYRQPFHb3BSAreElf0QkXQTiJENHMqnSbALDYfiHZqY
         pIsnwIQcs8jEL2DpRIQLTn07+Ve9hVm+cgSEtJdZwR8/4enC6h6CNWoIZgz5YvWxQ6
         MeluFmVWF4kSewTnyOC8VbaFPXSp9RuJ5UVKVAGweuDdsyZmDWNRfYku+O7mK2MCe9
         rtu4hX2yS6Koz7Yt0FdcQ/6dB/tND35pbuOTNgs559ZDeTG5PRnQb7xz//FdzWuwBz
         ZO65yUUdAB4G9TzB1DMhcCwqZufdrLG3efVvowwPSVZn3nyJlaX7QbLNeKxKq8U1Wr
         VJcHK69Dntk4A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] libfdt: define INT32_MAX and UINT32_MAX in libfdt_env.h
Date:   Wed, 13 Nov 2019 16:12:02 +0900
Message-Id: <20191113071202.11287-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTC v1.5.1 added references to (U)INT32_MAX.

This is no problem for user-space programs since <stdint.h> defines
(U)INT32_MAX along with (u)int32_t.

For the kernel space, libfdt_env.h needs to be adjusted before we
pull in the changes.

In the kernel, we usually use s/u32 instead of (u)int32_t for the
fixed-width types.

Accordingly, we already have S/U32_MAX for their max values.
So, we should not add (U)INT32_MAX to <linux/limits.h> any more.

Instead, add them to the in-kernel libfdt_env.h to compile the
latest libfdt.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

My initial plan was to change this in a series of 3 patches
since it is clean, and reduces the code.

[1/3] https://lore.kernel.org/patchwork/patch/1147095/
[2/3] https://lore.kernel.org/patchwork/patch/1147096/
[3/3] https://lore.kernel.org/patchwork/patch/1147097/

1/3 is stuck in the license bikeshed.

For 2/3, I have not been able to get Ack from Russell.

So, I chose a straight-forward fixup.


Changes in v3:
 - Resend as a single patch

 arch/arm/boot/compressed/libfdt_env.h | 4 +++-
 arch/powerpc/boot/libfdt_env.h        | 2 ++
 include/linux/libfdt_env.h            | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index b36c0289a308..6a0f1f524466 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -2,11 +2,13 @@
 #ifndef _ARM_LIBFDT_ENV_H
 #define _ARM_LIBFDT_ENV_H
 
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
-#define INT_MAX			((int)(~0U>>1))
+#define INT32_MAX	S32_MAX
+#define UINT32_MAX	U32_MAX
 
 typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index 2abc8e83b95e..9757d4f6331e 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -6,6 +6,8 @@
 #include <string.h>
 
 #define INT_MAX			((int)(~0U>>1))
+#define UINT32_MAX		((u32)~0U)
+#define INT32_MAX		((s32)(UINT32_MAX >> 1))
 
 #include "of.h"
 
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index edb0f0c30904..1adf54aad2df 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -7,6 +7,9 @@
 
 #include <asm/byteorder.h>
 
+#define INT32_MAX	S32_MAX
+#define UINT32_MAX	U32_MAX
+
 typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
-- 
2.17.1

