Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4C57CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0HBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 03:01:25 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:46372 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:01:25 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x5R70rKi019787;
        Thu, 27 Jun 2019 16:00:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x5R70rKi019787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561618854;
        bh=2WtcVjUdFNU96Xdu1YNSVP+5GinJ2kBLenYIkkCWbwM=;
        h=From:To:Cc:Subject:Date:From;
        b=VfW/ULwkq47zMMRwLj5Ionh/9KmNlX5BctOTOrXiVZ/p9Nv9WwNMa/c7bRkbkUsx8
         QOJmk41YudOG1XpTvHu/2zwPJRmPy4pRAw4wDgKrn51v3vca+3YmKLMA/hTXE6Gmrf
         LT/ZJZ9woifg8S/EUwCk10ou2pM5iB9vPSz8pGjiqQMHK5VRna6xhDes71rYElwp8y
         wr38yhll1XuD6C6ozejsbxY55/V6xpjV8kFA9TeTUW1YAkHl7kfKt7woUfLkVWqCj9
         W6KbxsfmU16+JlZY1YSXVxdf5Hn9XoCB0qSiNM/C5XPpPjAVn3PZdAmPvfa2RJ+ubK
         ufrPZUwCfxsNA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: remove unneeded BITS_PER_LONG define
Date:   Thu, 27 Jun 2019 16:00:52 +0900
Message-Id: <20190627070052.8647-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xtensa does not define CONFIG_64BIT. The generic definition in
include/asm-generic/bitsperlong.h should work.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/xtensa/include/asm/types.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/xtensa/include/asm/types.h b/arch/xtensa/include/asm/types.h
index 2b410b8c7f79..44f411c75837 100644
--- a/arch/xtensa/include/asm/types.h
+++ b/arch/xtensa/include/asm/types.h
@@ -12,12 +12,4 @@
 
 #include <uapi/asm/types.h>
 
-#ifndef __ASSEMBLY__
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-
-#define BITS_PER_LONG 32
-
-#endif
 #endif	/* _XTENSA_TYPES_H */
-- 
2.17.1

