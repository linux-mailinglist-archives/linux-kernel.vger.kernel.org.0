Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF6214DC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfEQHyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 03:54:47 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:17249 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfEQHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 03:54:45 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x4H7sUrc022599;
        Fri, 17 May 2019 16:54:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x4H7sUrc022599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558079672;
        bh=aoxvYokzkg5KCfE8DPWYAz2pO+zQLd9H+Ove6qzWDPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXs4rmj4cEq/6+idkTgiSEfRHLTaZWsisFfsfHK0YoK5/tWrwTGqtbma/M2q8khcX
         Va0/2P4HRBtMpQ7/IF29kj90wkm5OobfCLd0AkMmD/6Ndu4V3nF/F8byky6uYtX3PG
         /3c7jBFLcCsdnqxygwgfeHJFXw/wxxEOrVNqyL1FfmvDJnAVfz81hNu8z6KYh/MhGh
         UnSFHO8W6u/8K91jDngSRgACG3YEqbUUGNrqGJHaIfKhAXEkZaVPLH25NUBx23Pesl
         jRJUJPNaOzMWMWprpHqBDZm8HJAUXZYI9tjijmSINPDzVgMp00QNbLRj3XBDDB9WP+
         ppAYJqQ3pFU1g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] s390: drop unneeded -Wall addition from tools Makefile
Date:   Fri, 17 May 2019 16:54:25 +0900
Message-Id: <20190517075428.13496-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517075428.13496-1-yamada.masahiro@socionext.com>
References: <20190517075428.13496-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile adds -Wall globally for all host tools:

  KBUILD_HOSTCFLAGS   := -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 \

I see two "-Wall" added for compiling these tools.

Of course, it is allowed to pass the same option multiple times, but
we do not need to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 4ff6a2124522..8fb66c99840a 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -14,8 +14,7 @@ kapi:	$(kapi-hdrs-y)
 hostprogs-y		    += gen_facilities
 hostprogs-y		    += gen_opcode_table
 
-HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
-HOSTCFLAGS_gen_opcode_table.o += -Wall
+HOSTCFLAGS_gen_facilities.o += $(LINUXINCLUDE)
 
 # Ensure output directory exists
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
-- 
2.17.1

