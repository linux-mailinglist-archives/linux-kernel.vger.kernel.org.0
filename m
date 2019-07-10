Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A971564D08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 21:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfGJTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 15:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727723AbfGJTxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:53:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91C7B20645;
        Wed, 10 Jul 2019 19:53:47 +0000 (UTC)
Date:   Wed, 10 Jul 2019 15:53:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        luto@kernel.org, torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
Subject: Re: [PATCH v2 1/7] x86/paravirt: Make read_cr2() CALLEE_SAVE
Message-ID: <20190710155345.3d47032f@gandalf.local.home>
In-Reply-To: <20190704200050.306303504@infradead.org>
References: <20190704195555.580363209@infradead.org>
        <20190704200050.306303504@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jul 2019 21:55:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/xen/xen-asm.S
> +++ b/arch/x86/xen/xen-asm.S
> @@ -10,6 +10,7 @@
>  #include <asm/percpu.h>
>  #include <asm/processor-flags.h>
>  #include <asm/frame.h>
> +#include <asm/asm.h>
>  
>  #include <linux/linkage.h>
>  
> @@ -135,3 +136,19 @@ ENTRY(check_events)
>  	FRAME_END
>  	ret
>  ENDPROC(check_events)
> +
> +ENTRY(xen_read_cr2)
> +	FRAME_BEGIN
> +	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
> +	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
> +	FRAME_END
> +	ret
> +	ENDPROC(xen_read_cr2);
> +
> +ENTRY(xen_read_cr2_direct)
> +	FRAME_BEGIN
> +	_ASM_MOV PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_arch_cr2, %_ASM_AX
> +	FRAME_END
> +	ret
> +	ENDPROC(xen_read_cr2_direct);
> +

When I applied this locally, git complained about this extra line at the
end of the file.

-- Steve
