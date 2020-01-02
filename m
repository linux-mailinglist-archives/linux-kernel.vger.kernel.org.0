Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC38112E7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jan 2020 16:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgABPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 10:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgABPOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:14:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60384206E6;
        Thu,  2 Jan 2020 15:14:31 +0000 (UTC)
Date:   Thu, 2 Jan 2020 10:14:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 0/2] RISC-V: fixes issues of ftrace graph tracer
Message-ID: <20200102101429.383088c7@gandalf.local.home>
In-Reply-To: <CANXhq0qTG-ezdrJpOEd9fhc-_iRL2syASO9KnQxbDfxoVXwfqQ@mail.gmail.com>
References: <20191223084614.67126-1-zong.li@sifive.com>
        <CANXhq0qTG-ezdrJpOEd9fhc-_iRL2syASO9KnQxbDfxoVXwfqQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 11:50:22 +0800
Zong Li <zong.li@sifive.com> wrote:

> On Mon, Dec 23, 2019 at 4:46 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > Ftrace graph tracer is broken now, these patches fix the problem of ftrace graph
> > tracer and tested on QEMU and HiFive Unleashed board.
> >
> > Zong Li (2):
> >   riscv: ftrace: correct the condition logic in function graph tracer
> >   clocksource/drivers/riscv: add notrace to riscv_sched_clock
> >
> >  arch/riscv/kernel/ftrace.c        | 2 +-
> >  drivers/clocksource/timer-riscv.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > --
> > 2.24.1
> >  
> 
> ping

Both patches look legit.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
