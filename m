Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1D36331
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2019 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFESNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jun 2019 14:13:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfFESNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0807330C1205;
        Wed,  5 Jun 2019 18:13:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACEF2B3CC;
        Wed,  5 Jun 2019 18:13:28 +0000 (UTC)
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net>
 <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net>
 <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net>
 <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
Organization: Red Hat
Message-ID: <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com>
Date:   Wed, 5 Jun 2019 14:13:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 05 Jun 2019 18:13:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/19 2:21 PM, Waiman Long wrote:
> On 6/4/19 2:14 PM, Peter Zijlstra wrote:
>>> I worked on this owner merging patch mainly to alleviate the need to use
>>> cmpxchg for reader lock. cmpxchg_double() is certainly one possible
>>> solution though it won't work on older CPUs. We can have a config option
>>> to use cmpxchg_double as it may increase the size of other structures
>>> that embedded rwsem and impose additional alignment constraint.
>> cmpxchg8b was introduced with the Pentium (for PAE IIRC, it enabled
>> atomic 64bit PTEs, but Linux never used it for that) and every Intel/AMD
>> thereafter has had it. AFAIK there's no x86_64 chip without cmpxchg16b.
> Thank for the clarification. I actually didn't check when cmpxch8b was
> introduced. I know it is a bit slower than regular cmpxchg. So we may
> still need to do some performance analysis to see how it compares with
> my current approach.

Using cmpxchg_double is actually more risky than I thought. I have been
trying to try to use cmpxchg_double for down_write, but I kept getting
kernel panics because the rwsem wasn't 16b-aligned. As rwsem is embedded
in quite a large number of structures, they all have to align properly
to make that work or the kernel will panic. That does seem too risky to
me. So I am dropping the idea of trying to use it.

Cheers,
Longman

