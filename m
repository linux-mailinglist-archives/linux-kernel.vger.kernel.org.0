Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4E67ED3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2019 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfGNLcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jul 2019 07:32:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54621 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNLcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 07:32:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so12497521wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wLzcslB7WDh9RARnsnsgvEY4STxOiOIxJagEVenX2hQ=;
        b=gPNuME1JMAXYQo140Tz1iapUkYeajD79ZrOl8VjeRz1Q/iD8xgVlBk2U8+ksMJckCs
         +3KZFHdRqduuNHqiQovuHZXQMqeU2sQOAitgL7f21kg2KIy0neA8p/e246nq9VbzTdpS
         FosKeC711Gn7yj9w7QqLAXiwj/VAMJJd5Mc6ro0bnvWB80rkr+vo2SqkrnHwaHpxpkto
         LC842DcvrkDRzM9yz0y22tclHDRhKZ2e8REHPizoebil2Ls4fY7BI/TfwirRePurCSeX
         a342J6/w3tJ9H8FG/hYd09IUrVP68ForBIoqBrdbk4xzYciENyTjnzlEon+EFGHbx0GX
         WRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=wLzcslB7WDh9RARnsnsgvEY4STxOiOIxJagEVenX2hQ=;
        b=pzT5uf1lJ2Ajt/H00Axgvdq6qTtN8h2YqanScZy7r5hidK5ghw++lbB7ocDg2XAKXg
         1x9F4tyqhJxfEMMvGweviffGmzlQZkQp4E5gILS7v/n34xiuWGJ8nuRCgxVlpgENUNYS
         iCLwNzG7vUFyFJ5Q1dDP2FjtwLnLQoGHWhUGzYLAyazFXITTVah1erlM1CgDBJ1xkHHP
         4GqDEtqGyco7y59fgCZISp8argyIpTRPh0XshKnm3gm0n/xPUD442Ena7M7s45gWMWNO
         CmUFh1fVswE1y6JdnSM1bURxTbn+qQuamjbAT2Zjy+hSDEg0Vc5+cmUOvfsBdLx6EnWz
         fyTw==
X-Gm-Message-State: APjAAAVegwJuJF5se+shBVOqv51ooluVT0dXOiuzpiQKAh+aLEN0TqV9
        lqnEKV5Ds9QV07zzv/P06GLNzOfn
X-Google-Smtp-Source: APXvYqyeDJpikSpKjeCARz2+I8ovX4bVcNork/tkOPM4zRk9TJ07lylUFxsZyWdcPmoXtgPwQWzvbw==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr19309008wmg.27.1563103935070;
        Sun, 14 Jul 2019 04:32:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r123sm13363458wme.7.2019.07.14.04.32.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 04:32:14 -0700 (PDT)
Date:   Sun, 14 Jul 2019 13:32:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fix
Message-ID: <20190714113211.GA11146@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: e9a1379f9219be439f47a0f063431a92dc529eda x86/vdso: Fix flip/flop vdso build bug

A single build system bugfix.

 Thanks,

	Ingo

------------------>
Naohiro Aota (1):
      x86/vdso: Fix flip/flop vdso build bug


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
