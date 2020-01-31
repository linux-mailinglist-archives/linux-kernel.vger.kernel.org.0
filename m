Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED0714F31C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 21:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgAaUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 15:23:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56626 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:23:14 -0500
Received: from 51.26-246-81.adsl-static.isp.belgacom.be ([81.246.26.51] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ixcol-0004uw-36; Fri, 31 Jan 2020 21:23:07 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id BBC1A105BDC; Fri, 31 Jan 2020 21:23:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/rtmutex: remove unused cmpxchg_relaxed
In-Reply-To: <20200131173922.hjvugxuybrn2wbsn@linux-p48b>
References: <1579595686-251535-1-git-send-email-alex.shi@linux.alibaba.com> <20200131173922.hjvugxuybrn2wbsn@linux-p48b>
Date:   Fri, 31 Jan 2020 21:23:01 +0100
Message-ID: <87r1zfxtne.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:
> On Tue, 21 Jan 2020, Alex Shi wrote:

  Subject: locking/rtmutex: remove unused cmpxchg_relaxed

should be

  Subject: locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()

You're not removing cmpxchg_relaxed, right?

>> No one use this macro after it was introduced. Better to remove it?

Please make that factual.

 The macro was never used at all. Remove it.

> You also need to remove it for the CONFIG_DEBUG_RT_MUTEXES=y case.

Yes.

> Hmm unrelated, but do we want CCAS for rtmutex fastpath? Ie:
>
>      (l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
>
> That would optimize for the contended case and avoid the cmpxchg - it would
> also help if we ever do the top-waiter spin thing.

Not sure if it buys much, but it kinda makes sense.

Thanks,

        tglx
