Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804F669B66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2019 21:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfGOTaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jul 2019 15:30:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbfGOTaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:30:15 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hn6fs-00057m-Q9; Mon, 15 Jul 2019 21:30:12 +0200
Date:   Mon, 15 Jul 2019 21:30:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Uros Bizjak <ubizjak@gmail.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop
 targets
In-Reply-To: <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907152129350.1767@nanos.tec.linutronix.de>
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com> <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de> <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2019, Uros Bizjak wrote:
> On Mon, Jul 15, 2019 at 8:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Mon, 15 Jul 2019, Andi Kleen wrote:
> > > Uros Bizjak <ubizjak@gmail.com> writes:
> > >
> > > > Recent patch [1] disabled a self-snoop feature on a list of processor
> > > > models with a known errata, so we are confident that the feature
> > > > should work on remaining models also for other purposes than to speed
> > > > up MTRR programming.
> > >
> > > MTRR is very different than TLBs.
> > >
> > > >From my understanding not flushing with PAT is only safe everywhere when
> > > the memory is only used for coherent devices (like the Internal GPU on
> > > Intel CPUs). We don't have any infrastructure to track or enforce
> > > this unfortunately.
> >
> > Right, we don't know where the PAT invocation comes from and whether they
> > are safe to omit flushing the cache. The module load code would be one
> > obvious candidate.
> >
> > But unless there is some really worthwhile speedup, e.g. for boot, then
> > adding some flag to let CPA know about the safe 'no flush' operation might
> > be not worth it.
> 
> For the reference, FreeBSD implements this approach, later changed to
> use pmap_invalidate_cache_range ifunc (that calls
> pmap_invalidate_cache_range_selfsnoop for targets with self-snoop
> capability) and pmap_force_invalidate_cache_range [1]. The full
> cross-referenced source is at [2].

That does not answer the question whether it's worthwhile to do that.

Thanks,

	tglx
