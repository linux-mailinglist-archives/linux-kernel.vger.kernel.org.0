Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B023421E5A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfEQTcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:32:35 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:34304 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727380AbfEQTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:33 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 72D71C0089;
        Fri, 17 May 2019 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121559; bh=fJs/HSiAhXUEn2Cz8WRmlEPH8/xvYZ14fMXCFI524Ts=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dNekFo8czcbjoji+F6/Bfn+oN+EN0UEZjOikgritLfYv6cwgPuO2mXlAbotqNEY82
         VZuEvwLY5TWiA5kIWPZRbB+Ct4AFHdfuRSHw8JeDkKh9fzDjx8FFWJ/+PrV6jC0yJU
         CP43GpvNQPjGjCuapjuZvKx0jHeYGhPzFYwXxdJwcnkg4G6objvIptckZascFO574O
         ZM7Pb1qQ7klzIC3CusnpjC4XET595c6JJTRv5W8HE7PWRFu5pL78YS4uk89E/CWjPn
         B4CG6PZkKeLsg18u+wd4SjryT68OBsDE4+d5S9EoRoYT8T0Q9oqfdEd2EmS+AM5/5H
         pUNKZMMBA2CrQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 68973A0070;
        Fri, 17 May 2019 19:32:31 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:31 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:39 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:27 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 3/5] ARCv2: entry: avoid a branch
Date:   Fri, 17 May 2019 12:32:06 -0700
Message-ID: <1558121528-30184-4-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
References: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 3209a6762960..beaf655666cb 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -100,12 +100,11 @@
 	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
 	;    but on return, restored only if U mode
 
+	lr	r9, [AUX_USER_SP]			; U mode SP
+
 	mov.nz	r9, sp
 	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
-	bnz	1f
 
-	lr	r9, [AUX_USER_SP]			; U mode SP
-1:
 	PUSH	r9					; SP (pt_regs->sp)
 
 	PUSH	fp
-- 
2.7.4

