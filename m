Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F4E86805
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 19:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404343AbfHHR34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 13:29:56 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:42087 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404308AbfHHR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:29:55 -0400
Received: from grover.flets-west.jp (softbank126125143222.bbtec.net [126.125.143.222]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x78HSihL013374;
        Fri, 9 Aug 2019 02:28:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x78HSihL013374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1565285325;
        bh=ZXKGOGQbV1dII2jtvp/G7SZGpjYQxATkV4zvzvc+42Y=;
        h=From:To:Cc:Subject:Date:From;
        b=PX+490OrPVmLr92V97na/zJGYY1zwrnzhbkh4/10NTxSeQWMGWhxeAckWMIDlpl+5
         MsDx2yuQmGUkwqbl1S4SfKcn1d7sQ5os/wL2PEHtxvoKEri50kYMbe12qN9y0BSGI6
         raozvMs++pCGP6PIraeN0/y96eeIaxv4GgqLKXGpmAYvmAVP88cJucAwnfuYmxbBMs
         f/o8s76wNNeu51PJguAgtjotY3y0RMF1u+pYRwR7vGvsCDChU9khY4ARKyjDarSwMc
         Gjra9+McXY0gsXBNq07y9g/JWj4qEExsjzzB67/ai2/YHG9hFhx7gPG54NUCF0YnTC
         lzKDTj6bfgsmA==
X-Nifty-SrcIP: [126.125.143.222]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] um: remove meaningless clearing of clean-files
Date:   Fri,  9 Aug 2019 02:28:43 +0900
Message-Id: <20190808172843.1568-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/kernel/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2f36d515762e..89afc54f8699 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -13,7 +13,6 @@ CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)		\
                         -DELF_FORMAT=$(LDS_ELF_FORMAT)	\
 			$(LDS_EXTRA)
 extra-y := vmlinux.lds
-clean-files :=
 
 obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
-- 
2.17.1

