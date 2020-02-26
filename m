Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 669B416F65A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 05:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBZELN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 23:11:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgBZELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:11:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so1706393otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 20:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZANbOVwx0zUhbZ1OgC32H4fJ06zLdpnFgGR+tK5l/4=;
        b=AEnX/vJpfZhdHZM1MmEZR0Vzt5nPaOlT+2owGKNSkO99CR1SYJnwweaEVG3t9OApax
         OceJwjpeB6DA1OIRlrD0C/MQHx7jwqrx13Lhf9/WAn+nvFZBnZcMteJDEU6MYhTDMGJR
         Bz49K5RSa2jJmofcgOwVUN2JRd0nc8gbqGAxAszU3dKdupnHwtyI8xqw3XxrBG8YdBP8
         dFY/rYUG5g7g01GAesqeympSh42KeYLIkAWtn7Aegx3bZP7AeWF/npOmCSM5TuTPU0Tl
         16T/zvpEHP6NRGbPuu/2lDxUipKjGhfwbjEfSmPIUpKSuFRK+zSdseJF2nuZY8jQDcWT
         mQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZANbOVwx0zUhbZ1OgC32H4fJ06zLdpnFgGR+tK5l/4=;
        b=RdooJMfj8/8/8jIA0Beq71NxfG/GIl6QEpiba1JaACh+lSNNn1cazw/GwHJh3bZT/h
         2xBAiWWJd1LXWvkQYAJjpiHXGD4gMLTsgU14e2cuvjlQ6yBS4Pu25nauz8OBcWGxPCkT
         HbYfxrpLq6aLrjxcVEfw6I+dpqfZjRh/T7dnhQyH9ePEqNv3Uq8mMmu9KyC44KCXgAMR
         lxsONZb4UPO3I++VIcXRgD0IGowbveXaV/n9qyZg+0K5PJsBJiA5nR9vq59Bh44xmZJi
         u6u/RNj1/egm0fSyTCxG8I5/8fPqLpKe3vFbGBHFYIOwkpG/8Z4I2RyacDS5EODftP8T
         0Uvw==
X-Gm-Message-State: APjAAAVtI3pUa2GLpDRZpx0bOcfEqgkBwh4LGjf08YgmsZB+xN8FQpBJ
        C+8S46vwNSwzPXK8SGYtt9GBBT5MgxVie1EeBmx7wA==
X-Google-Smtp-Source: APXvYqwMKzxFoEjWQhYHhfWL4hnCRbnsCxoAMyDIN366E5Rqv2TrOn4yjK9HOqB3QEBybYKq2wi4Dj31O7NIfPWtBYg=
X-Received: by 2002:a05:6830:1219:: with SMTP id r25mr1533616otp.180.1582690272244;
 Tue, 25 Feb 2020 20:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20191121115902.2551-1-will@kernel.org> <20191121115902.2551-6-will@kernel.org>
In-Reply-To: <20191121115902.2551-6-will@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Feb 2020 05:10:46 +0100
Message-ID: <CAG48ez0CoY2fuxNkdAn_Jx+hffQ1eyM_V++5q6Q5nra+_tE9hQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 05/10] lib/refcount: Improve performance of
 generic REFCOUNT_FULL code
To:     Will Deacon <will@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 12:58 PM Will Deacon <will@kernel.org> wrote:
> Rewrite the generic REFCOUNT_FULL implementation so that the saturation
> point is moved to INT_MIN / 2. This allows us to defer the sanity checks
> until after the atomic operation, which removes many uses of cmpxchg()
> in favour of atomic_fetch_{add,sub}().

Oh, I never saw this, this is really neat! CCing the kernel-hardening
list on this might've been a good idea.

> + * Saturation semantics
> + * ====================
> + *
> + * refcount_t differs from atomic_t in that the counter saturates at
> + * REFCOUNT_SATURATED and will not move once there. This avoids wrapping the
> + * counter and causing 'spurious' use-after-free issues. In order to avoid the
> + * cost associated with introducing cmpxchg() loops into all of the saturating
> + * operations, we temporarily allow the counter to take on an unchecked value
> + * and then explicitly set it to REFCOUNT_SATURATED on detecting that underflow
> + * or overflow has occurred. Although this is racy when multiple threads
> + * access the refcount concurrently, by placing REFCOUNT_SATURATED roughly
> + * equidistant from 0 and INT_MAX we minimise the scope for error:
> + *
> + *                                INT_MAX     REFCOUNT_SATURATED   UINT_MAX
> + *   0                          (0x7fff_ffff)    (0xc000_0000)    (0xffff_ffff)
> + *   +--------------------------------+----------------+----------------+
> + *                                     <---------- bad value! ---------->
> + *
> + * (in a signed view of the world, the "bad value" range corresponds to
> + * a negative counter value).
[...]
> + * If another thread also performs a refcount_inc() operation between the two
> + * atomic operations, then the count will continue to edge closer to 0. If it
> + * reaches a value of 1 before /any/ of the threads reset it to the saturated
> + * value, then a concurrent refcount_dec_and_test() may erroneously free the
> + * underlying object. Given the precise timing details involved with the
> + * round-robin scheduling of each thread manipulating the refcount and the need
> + * to hit the race multiple times in succession, there doesn't appear to be a
> + * practical avenue of attack even if using refcount_add() operations with
> + * larger increments.

On top of that, the number of threads that can actually be running at
a given time is capped. See include/linux/threads.h, where it is
capped to pow(2, 22):

    /*
     * A maximum of 4 million PIDs should be enough for a while.
     * [NOTE: PID/TIDs are limited to 2^29 ~= 500+ million, see futex.h.]
     */
    #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
            (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))

And in the futex UAPI header, we have this, baking a TID limit into
the userspace API (note that this is pow(2,30), not pow(2,29) as the
comment in threads.h claims - I'm not sure where that difference comes
from):

    /*
     * The rest of the robust-futex field is for the TID:
     */
    #define FUTEX_TID_MASK 0x3fffffff

So AFAICS, with the current PID_MAX_LIMIT, if you assume that all
participating refcount operations are non-batched (delta 1) and the
attacker can't cause the threads to oops in the middle of the refcount
operation (maybe that would be possible if you managed to find
something like a NULL pointer dereference in perf software event code
and had perf paranoia at <=1 , or something like that? - I'm not
sure), then even in a theoretical scenario where an attacker spawns
the maximum number of tasks possible and manages to get all of them to
sequentially preempt while being in the middle of increment operations
in several nested contexts (I'm not sure whether that can even happen
- you're not going to take typical sleeping exceptions like page
faults in the middle of a refcount op), the attacker will stay
comfortably inside the saturated range. Even if the PID_MAX_LIMIT is
at some point raised to the maximum permitted by the futex UAPI, this
still holds as long as you assume no nesting. Hm, should I send a
patch to add something like this to the explanatory comment?


Of course, if someone uses refcount batching with sufficiently large
values, those guarantees go out of the window - if we wanted to be
perfectionist about this, we could make the batched operations do slow
cmpxchg stuff while letting the much more performance-critical
single-reference case continue to use the fast saturation scheme.
OTOH, the networking folks would probably hate that, since they're
using the batched ops for ->sk_wmem_alloc stuff, where they count
bytes as references? So I guess maybe we should leave it as-is.
