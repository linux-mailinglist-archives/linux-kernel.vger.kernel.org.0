Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBE2192431
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Mar 2020 10:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYJez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Mar 2020 05:34:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgCYJez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:34:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4ACB5AA7C;
        Wed, 25 Mar 2020 09:34:54 +0000 (UTC)
Date:   Wed, 25 Mar 2020 10:34:53 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v3 04/26] x86/kexec: Use RIP relative addressing
In-Reply-To: <20200324160924.143334345@infradead.org>
Message-ID: <alpine.LSU.2.21.2003251033360.12098@pobox.suse.cz>
References: <20200324153113.098167666@infradead.org> <20200324160924.143334345@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Peter Zijlstra wrote:

> Normally identity_mapped is not visible to objtool, due to:
> 
>   arch/x86/kernel/Makefile:OBJECT_FILES_NON_STANDARD_relocate_kernel_$(BITS).o := y
> 
> However, when we want to run objtool on vmlinux.o there is no hiding
> it:
> 
>   vmlinux.o: warning: objtool: .text+0x4c0f1: unsupported intra-function call
> 
> Replace the (i386 inspired) pattern:
> 
> 	call 1f
>   1:	popq %r8
> 	subq $(1b - relocate_kernel), %r8
> 
> With a x86_64 RIP-relative LEA:
> 
> 	leaq relocate_kernel(%rip), %r8
> 
> Suggested-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Miroslav Benes <mbenes@suse.cz>

M
