Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B170629E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfEXSdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 14:33:03 -0400
Received: from foss.arm.com ([217.140.101.70]:48642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfEXSdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0005A78;
        Fri, 24 May 2019 11:33:02 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B6ED3F703;
        Fri, 24 May 2019 11:33:00 -0700 (PDT)
Date:   Fri, 24 May 2019 19:32:58 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v2] locking/lock_events: Use this_cpu_add() when necessary
Message-ID: <20190524183258.GD9697@fuggles.cambridge.arm.com>
References: <20190524165346.26373-1-longman@redhat.com>
 <20190524171939.GA9120@fuggles.cambridge.arm.com>
 <CAHk-=wiQ3kbk1G40ofSMu7qGhrX4PgngN64jGnttOcNCvKy6EA@mail.gmail.com>
 <8ceebb1c-e8f1-8bc5-e032-48f1a653a979@redhat.com>
 <20190524173915.GB9120@fuggles.cambridge.arm.com>
 <ed19cb78-3c00-4788-5369-73bcd8199e15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed19cb78-3c00-4788-5369-73bcd8199e15@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 02:11:23PM -0400, Waiman Long wrote:
> On 5/24/19 1:39 PM, Will Deacon wrote:
> 
>             And the whole "not precise" thing should be documented, of course.
> 
>         Yes, I will update the patch to document that fact that the count may
>         not be precise. Anyway even if we have a 1-2% error, it is not a big
>         deal in term of presenting a global picture of what operations are being
>         done.
> 
>     I suppose one alternative would be to have a per-cpu local_t variable,
>     and do the increments on that. However, that's probably worse than the
>     current approach for x86.
> 
> I don't quite understand what you mean by per-cpu local_t variable. A per-cpu
> variable is either statically allocated or dynamically allocated. Even with
> dynamical allocation, the same problem exists, I think unless you differentiate
> between irq context and process context. That will make it a lot more messier,
> I think.

So I haven't actually tried this to see if it works, but all I meant was
that you could replace the current:

DECLARE_PER_CPU(unsigned long, lockevents[lockevent_num]);

with:

DECLARE_PER_CPU(local_t, lockevents[lockevent_num]);

and then rework the inc/add macros to use a combination of raw_cpu_ptr
and local_inc().

I think that would allow you to get rid of the #ifdeffery, but it may
introduce a small overhead for x86.

Will
