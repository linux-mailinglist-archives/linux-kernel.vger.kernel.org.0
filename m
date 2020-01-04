Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 081971303A2
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jan 2020 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgADQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jan 2020 11:40:44 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53353 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:40:43 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 004GeKth005724;
        Sun, 5 Jan 2020 01:40:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 004GeKth005724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578156020;
        bh=oC1c+VAvJaUXWGl7gGGVl2DrNEN/0FuZrJGvBX6edRo=;
        h=From:To:Cc:Subject:Date:From;
        b=B5BsW6EiBfMv9/ynm1Oku4aHJOT85PZXFFJYvUC298wRs4ecm/FMMDr3rI9sm8JfP
         wzBW91Q0+iVhbRX7cdiKllfCfBucyC3OeQzeIK3GsD++1LcvLoXF9+QzwiSs9DnMwT
         s0gMfBlOYmPL3Mqmgah2wRvMBi+XnplUGkawbMu8Zgkhk9iwZz93VcbxboJYAY57S8
         T+HbZaT7cmvNsiCe31NTsDxMGaLk4Lpcvz1vw4+j3v8SYWcclaq5b2800SmJMQZpcY
         CeI8YhITc/KbGn1+ijt51PHQjdPu/6/zEslSZr0SVPjDwBCoK5xDSeJQm8Xd+Iz0bk
         6NVcy4EgD4v9Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ide: remove unneeded header include path to drivers/ide
Date:   Sun,  5 Jan 2020 01:40:11 +0900
Message-Id: <20200104164011.22189-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can build drivers/ide/ without this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/ide/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index cac02db4098d..d4f4409cfb8b 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -3,8 +3,6 @@
 # link order is important here
 #
 
-ccflags-y				:= -Idrivers/ide
-
 ide-core-y += ide.o ide-ioctls.o ide-io.o ide-iops.o ide-lib.o ide-probe.o \
 	      ide-taskfile.o ide-pm.o ide-park.o ide-sysfs.o ide-devsets.o \
 	      ide-io-std.o ide-eh.o
-- 
2.17.1

