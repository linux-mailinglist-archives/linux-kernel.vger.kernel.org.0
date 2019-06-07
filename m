Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECAA383DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2019 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFGFu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jun 2019 01:50:29 -0400
Received: from ozlabs.org ([203.11.71.1]:60559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfFGFu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 01:50:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Ks7k5hFgz9sNR;
        Fri,  7 Jun 2019 15:50:26 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mikey@neuling.org, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, christophe.leroy@c-s.fr,
        mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] Powerpc/Watchpoint: Restore nvgprs while returning from exception
In-Reply-To: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
References: <20190606072951.32116-1-ravi.bangoria@linux.ibm.com>
Date:   Fri, 07 Jun 2019 15:50:21 +1000
Message-ID: <87ftom0wrm.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:

> Powerpc hw triggers watchpoint before executing the instruction.
> To make trigger-after-execute behavior, kernel emulates the
> instruction. If the instruction is 'load something into non-
> volatile register', exception handler should restore emulated
> register state while returning back, otherwise there will be
> register state corruption. Ex, Adding a watchpoint on a list
> can corrput the list:
>
>   # cat /proc/kallsyms | grep kthread_create_list
>   c00000000121c8b8 d kthread_create_list
>
> Add watchpoint on kthread_create_list->next:
>
>   # perf record -e mem:0xc00000000121c8c0
>
> Run some workload such that new kthread gets invoked. Ex, I
> just logged out from console:
>
>   list_add corruption. next->prev should be prev (c000000001214e00), \
> 	but was c00000000121c8b8. (next=c00000000121c8b8).
>   WARNING: CPU: 59 PID: 309 at lib/list_debug.c:25 __list_add_valid+0xb4/0xc0
>   CPU: 59 PID: 309 Comm: kworker/59:0 Kdump: loaded Not tainted 5.1.0-rc7+ #69
>   ...
>   NIP __list_add_valid+0xb4/0xc0
>   LR __list_add_valid+0xb0/0xc0
>   Call Trace:
>   __list_add_valid+0xb0/0xc0 (unreliable)
>   __kthread_create_on_node+0xe0/0x260
>   kthread_create_on_node+0x34/0x50
>   create_worker+0xe8/0x260
>   worker_thread+0x444/0x560
>   kthread+0x160/0x1a0
>   ret_from_kernel_thread+0x5c/0x70

This all depends on what code the compiler generates for the list
access. Can you include a disassembly of the relevant code in your
kernel so we have an example of the bad case.

> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 9481a11..96de0d1 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1753,7 +1753,7 @@ handle_dabr_fault:
>  	ld      r5,_DSISR(r1)
>  	addi    r3,r1,STACK_FRAME_OVERHEAD
>  	bl      do_break
> -12:	b       ret_from_except_lite
> +12:	b       ret_from_except

This probably warrants a comment explaining why we can't use the (badly
named) "lite" version.

cheers
