Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88C185E41
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 16:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgCOPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 11:45:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29786 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgCOPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 11:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584287115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bie5CPQtCgzry/0WDpDIJAhXG0M76l/FmCw1sQZPC+0=;
        b=HYjleVWDDl3QMgJ1I0tnZ3rQG9QTwgzFNGbouBtdWFs1zPajtjou3mW/ftahESagPPgfT5
        Qgg28tFFI7tXeyu8c6alASAWEbAw3eN4PToixszso9f8ZTB2XwYyvHvjQrlG/fIqJAbU0s
        AGFbSMXlqWGE00wxkQL+cEfptCJJm6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-PMK0aUfPNQ-KG0iHGBCKKw-1; Sun, 15 Mar 2020 11:45:12 -0400
X-MC-Unique: PMK0aUfPNQ-KG0iHGBCKKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21A6A800D4E;
        Sun, 15 Mar 2020 15:45:11 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C3889F1C;
        Sun, 15 Mar 2020 15:45:10 +0000 (UTC)
Date:   Sun, 15 Mar 2020 10:45:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 04/16] objtool: Annotate identity_mapped()
Message-ID: <20200315154508.m4b6ttdp3hb7pfla@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.641079164@infradead.org>
 <20200313143429.GB12521@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313143429.GB12521@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:34:29PM +0100, Peter Zijlstra wrote:
> This conflicts with:
> 
>   7acfe5315312 ("objtool: Improve call destination function detection")
> 
> which wasn't in the tree we were working against :/
> 
> I've resolved it something like so.
> 
> ---
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -406,7 +406,7 @@ static void add_ignores(struct objtool_f
>  {
>  	struct instruction *insn;
>  	struct section *sec;
> -	struct symbol *func;
> +	struct symbol *sym;
>  	struct rela *rela;
>  
>  	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
> @@ -416,12 +416,12 @@ static void add_ignores(struct objtool_f
>  	list_for_each_entry(rela, &sec->rela_list, list) {
>  		switch (rela->sym->type) {
>  		case STT_FUNC:
> -			func = rela->sym;
> +			sym = rela->sym;
>  			break;
>  
>  		case STT_SECTION:
> -			func = find_func_by_offset(rela->sym->sec, rela->addend);
> -			if (!func)
> +			sym = find_symbol_by_offset(rela->sym->sec, rela->addend);
> +			if (!sym || (sym->type != STT_FUNC || sym->type != STT_NOTYPE))
                                                           ^^
							   &&

-- 
Josh

