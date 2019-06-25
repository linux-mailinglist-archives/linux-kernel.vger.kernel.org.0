Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B1F524E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 09:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfFYHfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 03:35:02 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:39913 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfFYHfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:35:00 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x5P7XS2R024184;
        Tue, 25 Jun 2019 16:33:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x5P7XS2R024184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561448009;
        bh=EPK03DrxjbqPP97/bXa0H1ibYzUkYpVZOokiVzCPizU=;
        h=From:To:Cc:Subject:Date:From;
        b=z4Uad3oj59BJ4aa5dSfAUvC8q075TAY6vKl6REgIIV7ofKKWAatGkCPBFU0pP8qS0
         vh58qc2jtISFHj2Wbttm6CzsAr0j1e7Gupv30rIqyCGy5IUI9rHVJ+U85zyndqY5VC
         JsnaQx93Z+l/sSCTA0W5CfwIdEKJSY5bXHkgw+/5Us98N/fui/1VLfTjSIsfCHx6hE
         v7pWV39gF9KAcjnu+/S8w4RNL4XrU1mySftaOg15iig36keOvl2BiEucYzAcfJHzX0
         14dtzlmDgUCbNu+J0p3nkVPGXIupVFvD7N3Zvnj8g/UFg/b5kSZAOHhEi4TS3AHWSw
         nBrSVg7ZmfCpg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: remove redundant 'clean-files += capflags.c'
Date:   Tue, 25 Jun 2019 16:33:11 +0900
Message-Id: <20190625073311.18303-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the files added to 'targets' are cleaned. Adding the same file
to both 'targets' and 'clean-files' is redundant.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/cpu/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5102bf7c8192..50abae9a72e5 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,8 +54,7 @@ quiet_cmd_mkcapflags = MKCAP   $@
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
 
-targets += capflags.c
 $(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
-clean-files += capflags.c
+targets += capflags.c
-- 
2.17.1

