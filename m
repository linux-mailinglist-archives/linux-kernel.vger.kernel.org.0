Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2BD7191C09
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 22:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCXVkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 17:40:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42306 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgCXVkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585086014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pSoPspFz2iUsU6Ki8bxsdwR1/3Sv4Zt/+H+KAGmA1DY=;
        b=IrphprEuQsDDCsdgLYdGxnyq9ajcSh1+7o6CW+1y85yJrkwvuqSpchEyf8OvSD5mu8vgik
        xj2+sW6nLwuldjKXaS22i5ckegxekqKy//fz4vuhG1EnZxlFxzwumCfjHQFhoSG585LLuC
        l628Ug5MErhxjIxxKURl44jjBvwORS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-RsxVZrB6PD6ubporaquT8Q-1; Tue, 24 Mar 2020 17:40:10 -0400
X-MC-Unique: RsxVZrB6PD6ubporaquT8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 659728017CC;
        Tue, 24 Mar 2020 21:40:09 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B999BBBE5;
        Tue, 24 Mar 2020 21:40:08 +0000 (UTC)
Date:   Tue, 24 Mar 2020 16:40:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 18/26] objtool: Fix !CFI insn_state propagation
Message-ID: <20200324214006.tlanaff5q6gkgk2a@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160924.987489248@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:31PM +0100, Peter Zijlstra wrote:
> Objtool keeps per instruction CFI state in struct insn_state and will
> save/restore this where required. However, insn_state has grown some
> !CFI state, and this must not be saved/restored (and thus lost).
> 
> Fix this by explicitly preserving the !CFI state and clarify by
> restucturing the code and adding a comment.
> 
> XXX, the insn==first condition is not handled right.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c |   95 +++++++++++++++++++++++++++++---------------------
>  tools/objtool/check.h |    8 ++++
>  2 files changed, 64 insertions(+), 39 deletions(-)
> 
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2033,6 +2033,59 @@ static int validate_return(struct symbol
>  	return 0;
>  }
>  
> +static int apply_insn_hint(struct objtool_file *file, struct section *sec,
> +			   struct symbol *func, struct instruction *first,
> +			   struct instruction *insn, struct insn_state *state)
> +{
> +	struct insn_state old = *state;
> +
> +	if (insn->restore) {
> +		struct instruction *save_insn, *i;
> +
> +		i = insn;
> +		save_insn = NULL;
> +		sym_for_each_insn_continue_reverse(file, func, i) {
> +			if (i->save) {
> +				save_insn = i;
> +				break;
> +			}
> +		}
> +
> +		if (!save_insn) {
> +			WARN_FUNC("no corresponding CFI save for CFI restore",
> +					sec, insn->offset);
> +			return 1;
> +		}
> +
> +		if (!save_insn->visited) {
> +			/*
> +			 * Oops, no state to copy yet.
> +			 * Hopefully we can reach this
> +			 * instruction from another branch
> +			 * after the save insn has been
> +			 * visited.
> +			 */
> +			if (insn == first)
> +				return 0; // XXX

Yeah, moving this code out to apply_insn_hint() seems like a nice idea,
but it wouldn't be worth it if it breaks this case.  TBH I don't
remember if this check was for a real-world case.  Might be worth
looking at...  If this case doesn't exist in reality then we could just
remove this check altogether.

> +
> +			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> +					sec, insn->offset);
> +			return 1;
> +		}
> +
> +		insn->state = save_insn->state;
> +	}
> +
> +	*state = insn->state;

This would have been easier to review if apply_insn_hint() were added in
a separate patch.

> +
> +	/* restore !CFI state */
> +	state->df = old.df;
> +	state->uaccess = old.uaccess;
> +	state->uaccess_stack = old.uaccess_stack;

Maybe we should just move the CFI stuff into a state->cfi substruct.
That would remove the need for these bits and probably also the comment
above the insn_state declaration.

-- 
Josh

