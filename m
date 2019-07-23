Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6C371723
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfGWLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 07:31:53 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:16437 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfGWLbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:31:53 -0400
X-Greylist: delayed 13295 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jul 2019 07:31:52 EDT
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6NBUlfL009979;
        Tue, 23 Jul 2019 20:30:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6NBUlfL009979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563881448;
        bh=ek5fX7jirXhSrc0zijLJq9soxIn74LwbNyps/vviFNE=;
        h=From:To:Cc:Subject:Date:From;
        b=bNcnoEEt/rqgRZ2oyKDGrXH7Dm5JZERdwXRP8IKPxB3rFTaio12i1LKtVKPMlcnN6
         8DWweeWlEVuHeKiHflIT9Zr+J57+jzktfr8bcpt90/ZGk5uF2EvU8cIZcPSNy++E5N
         pmAlViyfNd7kMo/2RB20ziIuDoOPlOXdGVfz4nD6ckOhQOmgKpXNlKB7d1+Z/wx5I2
         mCSoZpsniF6ubZqDq35r3GXKn1Za1m25NvPadKWxommFWQdmsu+T3vBwz1TzyloUKz
         RP20AAAV5s3j5BigWJP9MDr3oPlUcyWxQqyb0P0H7z6iACrR5lkJmybbcJjLu3WexW
         9TBHBwgX+JhpQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sh: remove unneeded uapi asm-generic wrappers
Date:   Tue, 23 Jul 2019 20:30:36 +0900
Message-Id: <20190723113036.14576-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are listed in include/uapi/asm-generic/Kbuild, so Kbuild will
automatically generate them.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/include/uapi/asm/setup.h | 2 --
 arch/sh/include/uapi/asm/types.h | 2 --
 2 files changed, 4 deletions(-)
 delete mode 100644 arch/sh/include/uapi/asm/setup.h
 delete mode 100644 arch/sh/include/uapi/asm/types.h

diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
deleted file mode 100644
index 4bd19f80f9b0..000000000000
--- a/arch/sh/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/setup.h>
diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
deleted file mode 100644
index 68100e108ea6..000000000000
--- a/arch/sh/include/uapi/asm/types.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/types.h>
-- 
2.17.1

