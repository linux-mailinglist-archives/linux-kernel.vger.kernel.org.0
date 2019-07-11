Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D363165063
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 05:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfGKDIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 23:08:54 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:51641 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfGKDIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 23:08:53 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x6B37xiF002252;
        Thu, 11 Jul 2019 12:07:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x6B37xiF002252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562814480;
        bh=wDYz/yHhx6nItjKqfKQXfYFVLdaXf3nRB8CNeDF+UBU=;
        h=From:To:Cc:Subject:Date:From;
        b=V9PkWY5tLYehK0nfbUXdhff3w2l+B7zk5PrPFh+Bh61Od5q54W9mfsVEyvL+pOs5J
         Qw71DbB7253tKzAcTJNAXzc+nVFyVJBaKopJ8kEnL5cjtLsbcAgc+SWblGsia9paLm
         MztR4nDGrdQMERC39gVxPJOxC2h5GVdE0qWLLbeS1lCAraFH/Siydi+fKyM1Qfk+Zr
         OWnXUaVSFWKbQxtSl/MTu9NnIixkYqLEkxq61cqjQsPKChxSCjpiOKBTDaoNcvPtL0
         hBCN78ryQOPYwdw4q+qefZQOznnVVmc7SPSVj/0MgeMszvzV3mO3hSFZUbATP0mdp0
         CEyADH22YtY2g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: fix O= building with CONFIG_FPE_FASTFPE
Date:   Thu, 11 Jul 2019 12:07:56 +0900
Message-Id: <20190711030756.4612-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use Fastfpe, a user is supposed to enable CONFIG_FPE_FASTFPE
and put downstream source files into arch/arm/fastfpe/.

It is not working for O= build because $(wildcard arch/arm/fastfpe)
checks if it exists in $(objtree), not in $(srctree).

Add the $(srctree)/ prefix to fix it.

While I was here, I slightly refactored the code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

KernelVersion: 5.2

 arch/arm/Makefile | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f863c6935d0e..792f7fa16a24 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -271,14 +271,9 @@ endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-# Do we have FASTFPE?
-FASTFPE		:=arch/arm/fastfpe
-ifeq ($(FASTFPE),$(wildcard $(FASTFPE)))
-FASTFPE_OBJ	:=$(FASTFPE)/
-endif
-
 core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
-core-$(CONFIG_FPE_FASTFPE)	+= $(FASTFPE_OBJ)
+# Put arch/arm/fastfpe/ to use this.
+core-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(srctree)/%,%,$(wildcard $(srctree)/arch/arm/fastfpe/))
 core-$(CONFIG_VFP)		+= arch/arm/vfp/
 core-$(CONFIG_XEN)		+= arch/arm/xen/
 core-$(CONFIG_KVM_ARM_HOST) 	+= arch/arm/kvm/
-- 
2.17.1

