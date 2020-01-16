Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9640613F746
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437536AbgAPTKg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jan 2020 14:10:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53049 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437450AbgAPTK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:10:28 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isAX2-0007HG-TQ; Thu, 16 Jan 2020 20:10:17 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5F3FB101226; Thu, 16 Jan 2020 20:10:16 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Waiman Long <longman@redhat.com>,
        Robert Richter <rrichter@marvell.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] watchdog: Fix possible soft lockup warning at bootup
In-Reply-To: <9ae2ee4d-7b67-50ff-e736-1d51753c5ccd@redhat.com>
Date:   Thu, 16 Jan 2020 20:10:16 +0100
Message-ID: <87ftgffc9z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 1/16/20 11:57 AM, Thomas Gleixner wrote:
>>> So your theory the MONOTONIC clock runs differently/wrongly could
>>> explain that (assuming this drives the sched clock). Though, I am
>> No. sched_clock() is separate. It uses a raw timestamp (in your case
>> from the ARM arch timer) and converts it to something which is close to
>> proper time. So my assumption was based on the printout Waiman had:
>>
>>  [ 1... ] CPU.... watchdog_fn now  170000000
>>  [ 25.. ] CPU.... watchdog_fn now 4170000000
>>
>> I assumed that now comes from ktime_get() or something like
>> that. Waiman?
>
> I printed out the now parameter of the  __hrtimer_run_queues() call.

Yes. That's clock MONOTONIC.

> So from the timer perspective, it is losing time. For watchdog, the soft
> expiry time is 4s. The watchdog function won't be called until the
> timer's time advances 4s or more. That corresponds to about 24s in
> timestamp time for that particular class of systems.

Right. And assumed that the firmware call is the culprit this has an
explanation.

Could you please take sched_clock() timestamps before and after the
firmware call which kicks the secondary CPUs into life to verify that?

They should sum up to the amount of time which gets lost accross
smp_init().

Thanks,

        tglx
