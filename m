Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84B120E38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfEPRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 13:50:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfEPRur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28AB6308425C;
        Thu, 16 May 2019 17:50:47 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-91.rdu2.redhat.com [10.10.120.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54CB5341E8;
        Thu, 16 May 2019 17:50:46 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] objtool: Allow AR to be overridden with HOSTAR
Date:   Thu, 16 May 2019 12:49:42 -0500
Message-Id: <80822a9353926c38fd7a152991c6292491a9d0e8.1558028966.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 16 May 2019 17:50:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Currently, this Makefile hardcodes GNU ar, meaning that if it is not
available, there is no way to supply a different one and the build will
fail.

  $ make AR=llvm-ar CC=clang LD=ld.lld HOSTAR=llvm-ar HOSTCC=clang \
         HOSTLD=ld.lld HOSTLDFLAGS=-fuse-ld=lld defconfig modules_prepare
  ...
    AR       /out/tools/objtool/libsubcmd.a
  /bin/sh: 1: ar: not found
  ...

Follow the logic of HOST{CC,LD} and allow the user to specify a
different ar tool via HOSTAR (which is used elsewhere in other
tools/ Makefiles).

Link: https://github.com/ClangBuiltLinux/linux/issues/481
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 53f8be0f4a1f..88158239622b 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -7,11 +7,12 @@ ARCH := x86
 endif
 
 # always use the host compiler
+HOSTAR	?= ar
 HOSTCC	?= gcc
 HOSTLD	?= ld
+AR	 = $(HOSTAR)
 CC	 = $(HOSTCC)
 LD	 = $(HOSTLD)
-AR	 = ar
 
 ifeq ($(srctree),)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
-- 
2.20.1

