Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB092F7670
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKKOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 09:32:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:42212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:32:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA89DACD8;
        Mon, 11 Nov 2019 14:32:46 +0000 (UTC)
Subject: [PATCH 2/2] x86/Xen/32: simplify xen_iret_crit_fixup's ring check
From:   Jan Beulich <jbeulich@suse.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Message-ID: <a5986837-01eb-7bf8-bf42-4d3084d6a1f5@suse.com>
Date:   Mon, 11 Nov 2019 15:32:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <d66b1da4-8096-9b77-1ca6-d6b9954b113c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be had with two instead of six insns, by just checking the high
CS.RPL bit.

Also adjust the comment - there would be no #GP in the mentioned cases,
as there's no segment limit violation or alike. Instead there'd be #PF,
but that one reports the target EIP of said branch, not the address of
the branch insn itself.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
An alternative would be to keep using SEGMENT_RPL_MASK, but follow it
with "jpe".

--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -153,22 +153,15 @@ hyper_iret:
  * it's still on stack), we need to restore its value here.
  */
 ENTRY(xen_iret_crit_fixup)
-	pushl %ecx
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
 	 * One could imagine a case where userspace jumps into the
 	 * critical range address, but just before the CPU delivers a
-	 * GP, it decides to deliver an interrupt instead.  Unlikely?
-	 * Definitely.  Easy to avoid?  Yes.  The Intel documents
-	 * explicitly say that the reported EIP for a bad jump is the
-	 * jump instruction itself, not the destination, but some
-	 * virtual environments get this wrong.
+	 * PF, it decides to deliver an interrupt instead.  Unlikely?
+	 * Definitely.  Easy to avoid?  Yes.
 	 */
-	movl 3*4(%esp), %ecx		/* nested CS */
-	andl $SEGMENT_RPL_MASK, %ecx
-	cmpl $USER_RPL, %ecx
-	popl %ecx
-	je 2f
+	testb $2, 2*4(%esp)		/* nested CS */
+	jnz 2f
 
 	/*
 	 * If eip is before iret_restore_end then stack

