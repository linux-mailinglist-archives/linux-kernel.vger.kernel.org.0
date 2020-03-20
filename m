Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2218D434
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 17:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCTQUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 12:20:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:40720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgCTQUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:20:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C2132B13C;
        Fri, 20 Mar 2020 16:20:47 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:20:47 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        brgerst@gmail.com
Subject: Re: [PATCH v2 17/19] objtool: Optimize !vmlinux.o again
In-Reply-To: <20200318132025.GH20730@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2003201719200.21240@pobox.suse.cz>
References: <20200317170234.897520633@infradead.org> <20200317170910.819744197@infradead.org> <20200318132025.GH20730@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020, Peter Zijlstra wrote:

> On Tue, Mar 17, 2020 at 06:02:51PM +0100, Peter Zijlstra wrote:
> > When doing kbuild tests to see if the objtool changes affected those I
> > found that there was a measurable regression:
> > 
> >           pre		  post
> > 
> >   real    1m13.594        1m16.488s
> >   user    34m58.246s      35m23.947s
> >   sys     4m0.393s        4m27.312s
> > 
> > Perf showed that for small files the increased hash-table sizes were a
> > measurable difference. Since we already have -l "vmlinux" to
> > distinguish between the modes, make it also use a smaller portion of
> > the hash-tables.
> > 
> > This flips it into a small win:
> > 
> >   real    1m14.143s
> >   user    34m49.292s
> >   sys     3m44.746s
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> There was one 'elf_' prefixing gone missing. Updated patch below.

I think there is one more missing in create_orc_entry().

Miroslav
