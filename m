Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C477D6729D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 17:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfGLPlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jul 2019 11:41:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57221 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGLPlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:41:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6CFfEwt3474458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 12 Jul 2019 08:41:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6CFfEwt3474458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562946075;
        bh=LtKRqbUjIrQjgMwqiyUxtQm/VwZOdvV/I6sf4NobELI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ceyCiHzOx/Bc0X3+/Cdje38lZVtOe5Ns/2RgcDndTbJOw+K2oJgZajblClCNtxbXm
         EouPmuD+mfslTSQIws6SYMvvx/HaPnP/xyNONJCkIvvkIBheb6EGcyHqsqaIv+EJEY
         /LcaTOIscBkgYSaGpBSVK26gCAlKZtfqIpvVxVCqayoLKydkT4ogIg87gyb6OiGfo5
         7TmTN/f9zD6sucrHI/S07pAYmcBYETFRCoHnakDqoz/A4FiVN0n/MNV8DrJcHYMkbS
         pWCML1p/TmgbIdOisgSd0GQUMFayVvKBxVQCdX35MNXV/hrNtg9ITjcRRi3K9j4JBy
         1X6VTZT/EhTNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6CFfEfW3474455;
        Fri, 12 Jul 2019 08:41:14 -0700
Date:   Fri, 12 Jul 2019 08:41:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Naohiro Aota <tipbot@zytor.com>
Message-ID: <tip-e9a1379f9219be439f47a0f063431a92dc529eda@git.kernel.org>
Cc:     naohiro.aota@wdc.com, tglx@linutronix.de,
        vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, yamada.masahiro@socionext.com
Reply-To: vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
          yamada.masahiro@socionext.com, hpa@zytor.com, mingo@kernel.org,
          naohiro.aota@wdc.com, tglx@linutronix.de
In-Reply-To: <20190712101556.17833-1-naohiro.aota@wdc.com>
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Fix flip/flop vdso build bug
Git-Commit-ID: e9a1379f9219be439f47a0f063431a92dc529eda
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e9a1379f9219be439f47a0f063431a92dc529eda
Gitweb:     https://git.kernel.org/tip/e9a1379f9219be439f47a0f063431a92dc529eda
Author:     Naohiro Aota <naohiro.aota@wdc.com>
AuthorDate: Fri, 12 Jul 2019 19:15:55 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 12 Jul 2019 17:35:07 +0200

x86/vdso: Fix flip/flop vdso build bug

Two consecutive "make" on an already compiled kernel tree will show
different behavior:

$ make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
  VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
Kernel: arch/x86/boot/bzImage is ready  (#3)
  Building modules, stage 2.
  MODPOST 12 modules

$ make
make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  VDSO    arch/x86/entry/vdso/vdso64.so.dbg
  OBJCOPY arch/x86/entry/vdso/vdso64.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
  CC      arch/x86/entry/vdso/vdso-image-64.o
  VDSO    arch/x86/entry/vdso/vdso32.so.dbg
  OBJCOPY arch/x86/entry/vdso/vdso32.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
  CC      arch/x86/entry/vdso/vdso-image-32.o
  AR      arch/x86/entry/vdso/built-in.a
  AR      arch/x86/entry/built-in.a
  AR      arch/x86/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
<snip>

This is causing "LD vmlinux" once every two times even without any
modifications. This is the same bug fixed in commit 92a4728608a8
("x86/boot: Fix if_changed build flip/flop bug"). Two "if_changed" cannot
be used in one target.

Fix this merging two commands into one function.

Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Link: https://lkml.kernel.org/r/20190712101556.17833-1-naohiro.aota@wdc.com

---
 arch/x86/entry/vdso/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 39106111be86..34773395139a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -56,8 +56,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 hostprogs-y			+= vdso2c
@@ -127,8 +126,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
@@ -167,8 +165,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/note.o \
 		      $(obj)/vdso32/system_call.o \
 		      $(obj)/vdso32/sigreturn.o
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 #
 # The DSO images are built using a special linker script.
@@ -184,6 +181,9 @@ VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
 	-Bsymbolic
 GCOV_PROFILE := n
 
+quiet_cmd_vdso_and_check = VDSO    $@
+      cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
+
 #
 # Install the unstripped copies of vdso*.so.  If our toolchain supports
 # build-id, install .build-id links as well.
