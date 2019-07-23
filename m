Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CDE71726
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfGWLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:32:09 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:61216 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWLcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:32:09 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x6NBVokV016476;
        Tue, 23 Jul 2019 20:31:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x6NBVokV016476
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881511;
        bh=FMKX/ubGxre/ukuvU9QlLVNveSZcQipzq/t0YiXkFYA=;
        h=From:To:Cc:Subject:Date:From;
        b=jKYxqbAc7eFe7fIhbo3o231TTntCPeW5u8gqwgxY2EHCbdUfvuUlPcugvedPu3KKR
         8SaPXZWQlEsOQqksLF+0qWqYiGz84NeGLFcraHq2UlRAA5X1L1fzBaaowUbxqooaXR
         o7eHojSRDMjcmPSPzQI2wj4Ykz62/YpWuqdJQdNm5jQ279fzXq60qQGZeHDtqL0z9E
         Fj+9yMx+8MuzFJ15JZAnID1IFbmFsoXu6MHbYxv0d/H61uE5DZatrK5gVtNJbDmo7F
         HyC8tbAGREuVRHhoyvPEPRJ7s4XsWP5Gvg+VlYQm58UqODvB9IVMFAe4WYHWI27M8h
         /P0HvZKg4Xu6A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: remove unneeded uapi/asm/statfs.h
Date:   Tue, 23 Jul 2019 20:31:49 +0900
Message-Id: <20190723113149.14776-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

statfs.h is listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sparc/include/uapi/asm/statfs.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/statfs.h

diff --git a/arch/sparc/include/uapi/asm/statfs.h b/arch/sparc/include/uapi/asm/statfs.h
deleted file mode 100644
index 20c8f5bd340e..000000000000
--- a/arch/sparc/include/uapi/asm/statfs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef ___ASM_SPARC_STATFS_H
-#define ___ASM_SPARC_STATFS_H
-
-#include <asm-generic/statfs.h>
-
-#endif
-- 
2.17.1

