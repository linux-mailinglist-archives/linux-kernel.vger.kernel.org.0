Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD340181DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 17:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgCKQ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 12:26:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57558 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730055AbgCKQ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:26:49 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 775DC43B53;
        Wed, 11 Mar 2020 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583944009; bh=TE+IAvbPEgErIcY/ikdZRwowkE45jGIxYuY0PKfZBXE=;
        h=From:To:Cc:Subject:Date:From;
        b=JkjDt5/nNFkbxizkqoe8is0bnVuy8LjJ3Xa9wWqXrNqmQMJKmglp5mybjlW1ofttv
         +z0pwktLzv4zMZRnLSShKdAmBx0l7IkhAhiQdpTPw4pN3ppHhSSXdjjhv0Tmd/m3dP
         2NKAIeYY9BWNA/0CvWEWO7rFEXEF5Yr9JR/qr3LdG2OYR1a4BSmsflb2hd1TX7Bv5m
         ssh9IbqPws0Yu0bP78EQkJufnq131i6hA5k4zReE4zssQ9DBlm18rRYCyD/wHaH+9K
         KTGFC13GZbxknFOtqzBbXBypb4+llJKL3IW7NHsg6Ecdp7fMMoSW3fV8+qeYnkuokw
         iGm6AdwyaiD5Q==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6A831A005C;
        Wed, 11 Mar 2020 16:26:47 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARC: define __ALIGN_STR and __ALIGN symbols for ARC
Date:   Wed, 11 Mar 2020 19:26:43 +0300
Message-Id: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today ARC uses generic __ALIGN_STR and __ALIGN symbol
definitions from "include/linux/linkage.h"
They are defined to ".align 4,0x90" which instructed the assembler
to use `0x90` as a fill byte when aligning functions declared with
ENTRY or similar macroses. This leads to generated weird instructions
in code (when alignment is used) like "ldh_s r12,[r0,0x20]" which is
encoded as 0x9090 for ARCv2.

Let's use ".align 4" which insert a "nop_s" instruction instead.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/linkage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/include/asm/linkage.h b/arch/arc/include/asm/linkage.h
index d9ee43c6b7db..fe19f1d412e7 100644
--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -29,6 +29,8 @@
 .endm
 
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
+#define __ALIGN		.align 4
+#define __ALIGN_STR	__stringify(__ALIGN)
 
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm
-- 
2.21.1

