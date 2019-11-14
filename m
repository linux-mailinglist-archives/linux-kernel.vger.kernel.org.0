Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3530FCA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfKNPur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:50:47 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:29473 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:50:46 -0500
Received: from grover.flets-west.jp (softbank126021098169.bbtec.net [126.21.98.169]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id xAEFnYqU003229;
        Fri, 15 Nov 2019 00:49:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com xAEFnYqU003229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573746574;
        bh=rUDBvIjnjwqQKJ9tUeh71Dhf0uG496BMaiSGvdte9AI=;
        h=From:To:Cc:Subject:Date:From;
        b=g6NCsYTEW2iX4zeMWFtf+YV/uYhkmv13lsxUfllhgK+QehD0RI5PTPFd95b9qdPWT
         GC+/pzPbi9ubWjClp3sjHjV/pP2U2gNm8nxmvVSYna2SMLZ3nDS83uIwqiOOlAubx5
         HJUcRe7lapNM+YcQRq5HLpLnjhNZeJbGEMVHmcSNoT3VEo2vsKumoUfHy5/Fc3qqZS
         gm+9V1ixNPhhydgP4BQ3fMeFxfydkNY90QZ2e4HcczpXmAIYfSQkXkPuxSQFuIUpem
         n8a9QoG9zxem4tdsUEue7FVctgfLZOw2O230lgAwDnZXT+TwBiDS3d87Uzlt/d8J6S
         micKmA7q3u4AA==
X-Nifty-SrcIP: [126.21.98.169]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build/vdso: remove meaningless CFLAGS_REMOVE_*.o
Date:   Fri, 15 Nov 2019 00:49:22 +0900
Message-Id: <20191114154922.30365-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CFLAGS_REMOVE_*.o syntax is used to drop particular flags when
building objects from C files. It has no effect for assembly files.

vdso-note.o is compiled from the assembly file, vdso-note.S, hence
CFLAGS_REMOVE_vdso-note.o is meaningless.

Neither vvar.c nor vvar.S is found in the vdso directory. Since there
is no source file to create vvar.o, CFLAGS_REMOVE_vvar.o is also
meaningless.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/entry/vdso/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 0f2154106d01..2b75e80f6b41 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -87,11 +87,9 @@ $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-CFLAGS_REMOVE_vdso-note.o = -pg
 CFLAGS_REMOVE_vclock_gettime.o = -pg
 CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
-CFLAGS_REMOVE_vvar.o = -pg
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
-- 
2.17.1

