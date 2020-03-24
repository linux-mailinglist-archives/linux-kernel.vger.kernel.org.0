Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2F191CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgCXWfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 18:35:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgCXWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1/eBpTZIO0KNns23jwEV+7XSPYVYlHUsVSdS97C3eio=; b=R2nEuWTdhFQzF8AWJwHG9AnAWi
        nzeNRtFShsZTEl9S5ozMAj90XXir8ElrOLeY3IopGQ0L6JzDdtZCF50M+KNOEcDMViIIP1fFKxfld
        UKkxLCc+GncqzMs4PAIZ1fMigb8EXW1xh4F4FlrSczaDgaQKHZlHT6z0ke42AFMYzptqdmV3McAAz
        FRxJTCEzC3pFqEex4Nxgh3KWjBYzSYJ6jk5/Mz/CnDBwe5xEMHhFo1VBPXAQVX2kl7+pfD+ZXPzkx
        kSQsI6yOXk69CZYrae4PW6wmHNiTDi6S6mLD0H4fzjZc0NeAcIbCSfyLK26DF5M6IShrTv35OhKN1
        gW11u+sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGs8P-0008MX-Tr; Tue, 24 Mar 2020 22:34:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9A01983502; Tue, 24 Mar 2020 23:34:55 +0100 (CET)
Date:   Tue, 24 Mar 2020 23:34:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
Message-ID: <20200324223455.GV2452@worktop.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324221616.2tdljgyay37aiw2t@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:16:16PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 24, 2020 at 04:31:39PM +0100, Peter Zijlstra wrote:

> > +	if (state.noinstr) {
> > +		/*
> > +		 * In vmlinux mode we will not run validate_unwind_hints() by
> > +		 * default which means we'll not otherwise visit STT_NOTYPE
> > +		 * symbols.
> > +		 *
> > +		 * In case of --duplicate mode, insn->visited will avoid actual
> > +		 * duplicate work being done.
> > +		 */
> > +		list_for_each_entry(func, &sec->symbol_list, list) {
> > +			if (func->type != STT_NOTYPE)
> > +				continue;
> > +
> > +			warnings += validate_symbol(file, sec, func, &state);
> > +		}
> > +	}
> > +
> 
> I guess this is ok, but is there a valid reason why we don't just call
> validate_unwind_hints()?
> 
> It's also slightly concerning that validate_reachable_instructions()
> isn't called, I'm not 100% convinced all the code will get checked.

This will only end up running on .noinstr.text, while
validate_unwind_hints() will run on *everything*. That is, we're
purposely not checking everything.

It very much relies on the !vmlinux mode to do the unreachable things.
