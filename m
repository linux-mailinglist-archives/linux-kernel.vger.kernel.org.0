Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4297B203A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEPKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 06:38:26 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfEPKiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 024C51A25;
        Thu, 16 May 2019 03:38:22 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8043F703;
        Thu, 16 May 2019 03:38:20 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, julien.thierry@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC 12/16] arm64: kvm: Annotate non-standard stack frame functions
Date:   Thu, 16 May 2019 11:36:51 +0100
Message-Id: <20190516103655.5509-13-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516103655.5509-1-raphael.gault@arm.com>
References: <20190516103655.5509-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both __guest_entry and __guest_exit functions do not setup
a correct stack frame. Because they can be considered as callable
functions, even if they are particular cases, we chose to silence
the warnings given by objtool by annotating them as non-standard.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kvm/hyp/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 675fdc186e3b..a7b6d4ef35da 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -85,6 +85,7 @@ ENTRY(__guest_enter)
 	eret
 	sb
 ENDPROC(__guest_enter)
+asm_stack_frame_non_standard __guest_enter
 
 ENTRY(__guest_exit)
 	// x0: return code
@@ -167,3 +168,4 @@ abort_guest_exit_end:
 	orr	x0, x0, x5
 1:	ret
 ENDPROC(__guest_exit)
+asm_stack_frame_non_standard __guest_exit
-- 
2.17.1

