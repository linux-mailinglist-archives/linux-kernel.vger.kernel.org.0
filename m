Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7573EE0825
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2019 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388995AbfJVQBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Oct 2019 12:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbfJVQBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:01:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0810720640;
        Tue, 22 Oct 2019 16:01:07 +0000 (UTC)
Date:   Tue, 22 Oct 2019 12:01:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     jthierry@redhat.com, will@kernel.org, ard.biesheuvel@linaro.org,
        peterz@infradead.org, catalin.marinas@arm.com, deller@gmx.de,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        takahiro.akashi@linaro.org, mingo@redhat.com, james.morse@arm.com,
        jeyu@kernel.org, amit.kachhap@arm.com, svens@stackframe.org,
        duwe@suse.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191022120106.234790cb@gandalf.local.home>
In-Reply-To: <20191022153335.GC52920@lakrids.cambridge.arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
        <20191021163426.9408-2-mark.rutland@arm.com>
        <20191021140756.613a1bac@gandalf.local.home>
        <20191022112811.GA11583@lakrids.cambridge.arm.com>
        <20191022085428.75cfaad6@gandalf.local.home>
        <20191022153035.GB52920@lakrids.cambridge.arm.com>
        <20191022153335.GC52920@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 16:33:35 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, Oct 22, 2019 at 04:30:35PM +0100, Mark Rutland wrote:
> > On Tue, Oct 22, 2019 at 08:54:28AM -0400, Steven Rostedt wrote:  
> > > On Tue, 22 Oct 2019 12:28:11 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:  
> > > > | /**
> > > > |  * ftrace_init_nop - initialize a nop call site
> > > > |  * @mod: module structure if called by module load initialization
> > > > |  * @rec: the mcount call site record  
> > > 
> > > Perhaps say "mcount/fentry"  
> > 
> > This is the exact wording that ftrace_make_nop and ftrace_modify_call
> > have. For consistency, I think those should all match.  
> 
> Now that I read this again, I see what you meant.
> 
> If it's ok, I'll change those to:
> 
> | @rec: the call site record (e.g. mcount/fentry)
> 

Ack

-- Steve
