Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6A8CFAF2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 15:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfJHNJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 09:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730301AbfJHNJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEE02B052;
        Tue,  8 Oct 2019 13:09:24 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:08:57 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Jessica Yu <jeyu@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH v2 3/4] module: Properly propagate MODULE_STATE_COMING
 failure
In-Reply-To: <20191007082700.14428791.6@infradead.org>
Message-ID: <alpine.LSU.2.21.1910081457420.12133@pobox.suse.cz>
References: <20191007082541.64146933.7@infradead.org> <20191007082700.14428791.6@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Peter Zijlstra wrote:

> Now that notifiers got unbroken; use the proper interface to handle
> notifier errors and propagate them.
> 
> There were already MODULE_STATE_COMING notifiers that failed; notably:
> 
>  - jump_label_module_notifier()
>  - tracepoint_module_notify()
>  - bpf_event_notify()
> 
> By propagating this error, we fix those users.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>  kernel/module.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3751,9 +3751,13 @@ static int prepare_coming_module(struct
>  	if (err)
>  		return err;
>  
> -	blocking_notifier_call_chain(&module_notify_list,
> -				     MODULE_STATE_COMING, mod);
> -	return 0;
> +	err = blocking_notifier_call_chain_robust(&module_notify_list,
> +			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
> +	err = notifier_to_errno(err);
> +	if (err)
> +		klp_module_going(mod);
> +
> +	return err;
>  }

It looks almost ok. At least klp_ error handling is correct now. I see
only one possible problem. If there is an error in a MODULE_STATE_COMING 
notifier, all MODULE_STATE_GOING notifiers will be called with mod->state 
set to MODULE_STATE_COMING. Not nice. I don't think it is actually a 
problem, because all notifiers, that I checked, only use the correct value 
(MODULE_STATE_COMING or MODULE_STATE_GOING, coming from the function 
parameter) and not mod->state. Better to doublecheck though.

However, mod->state is not set to MODULE_STATE_GOING anywhere under 
bug_cleanup label in load_module(). That is a bug and it is there 
regardless of this patch.

Jessica?

Regards
Miroslav
