Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8147117EFC5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 06:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgCJFAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 01:00:11 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:33188 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCJFAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 01:00:11 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 02A4xSXQ010738;
        Tue, 10 Mar 2020 13:59:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 02A4xSXQ010738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583816369;
        bh=V6MhCPzjyKlx9lFI4EBhh1DtSQKPQCjwx9TAcmzmA5E=;
        h=From:To:Cc:Subject:Date:From;
        b=Jo4bm24Zn25X3SKmyeDj3RYsUO9ClF0P0Bvr0nXCsRXVeMD8Fcfk6iFSeivYWfMfu
         la1nsDkUo3N7AVNZFJbdNMfjoUkBZOIRinOCQhRYqzHbpHeLFTBYgw/m2Ib7ZoOx7a
         5ODvwlIhVCnWYwylgpv8vAdaiKHN8GJVZbHFf62/nyLQMw2FZ/8AtpGn0n7v6iIGMD
         ozr96AMkn45SKLE4E1gwxAMpz9B4alJrpaFrcp/FBMuxax/e3RyVE3UofmuCy9XJWY
         KM3/ND98Wb+gpntv1LVkB4XR93QbE7QwutRrd+UkLHKTD72F3+NgHyCs4c3jULB6iK
         xUMiQTh0hIyaA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: remove meaningless export ccflags-y
Date:   Tue, 10 Mar 2020 13:59:25 +0900
Message-Id: <20200310045925.25396-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/xtensa/boot/Makefile does not define ccflags-y at all.

Please do not export ccflags-y because it is meant to be effective
only in the current Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index efb91bfda2b4..1a14d38d9b33 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -14,7 +14,6 @@ HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 
 BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
-export ccflags-y
 export BIG_ENDIAN
 
 subdir-y	:= lib
-- 
2.17.1

