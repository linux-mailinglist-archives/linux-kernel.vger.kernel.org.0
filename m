Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F256169B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 02:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgBXBG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 20:06:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35381 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBXBGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:06:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so8171666ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JOQFZKJ09bR9GxrGCRAILlsxRe+Mkc5csmWcmUCoQJc=;
        b=eH7EfBrSugBS2PBkWUhZ4dkDBlqTxzT/hIcYkayplTOGh12dCJk04xf7jP//eYR9ZI
         kHKZkQSaevFs5P/Hy0T+Hr7Ji5ufteDTEbskZaR+/74RZsfyA0ebu0ARSD4F1Rl/MqDR
         iCnhEBp/bW1S4feHHsBCHNc8LYAGNEzJNxzPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOQFZKJ09bR9GxrGCRAILlsxRe+Mkc5csmWcmUCoQJc=;
        b=g9gMC8ZwMn3KFl17g5J5KuIPO3ISIhKA4mg4SexFT6wrIb2DjsWY57dRhRpFTknASd
         ut6W0fx3KPRjI6nu4lrMGCvn/sreEoGxioRsXFk6zOShDgfr2HegyWmue+WRY1kpB03j
         Z+Cs0CIFroI9EyXYP3brnk3Ph59iJ9GYx1TREKfG562darXobSYR7H5T4x7SHqJUMM7j
         9JC/0cg0rJ0UK9uL966bXjjLjhW3A7TNAXmG/t85QiPJulUbsrlOOmnEtmBsS9CBqjMn
         iP3jpGbSS+d+aDI1pkEA/T07Hy+riusEGeSugWxvIQYKzGiKRgYc+6tbNc+EvYcvvpKY
         St3Q==
X-Gm-Message-State: APjAAAX5ThiVoh+AtkgQDCkOQndd21faoKKFxl5x1x60nvfCuxUBE81h
        zvZDU/E2XdT2w9BrF+hAREyXcqvia+4=
X-Google-Smtp-Source: APXvYqyOeDpOVuT/YmZXbbDSIl93Jg50NpPifrYufNuNtO/IUrQQ0IbNJmaqMYGuZgNZuBlR4zPdUg==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr29205802ljl.65.1582506412832;
        Sun, 23 Feb 2020 17:06:52 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v15sm1352977lfg.51.2020.02.23.17.06.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 17:06:52 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 7so5564233lfz.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:06:50 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr25977951lfb.31.1582506408850;
 Sun, 23 Feb 2020 17:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20200205123216.GO12867@shao2-debian> <20200205125804.GM14879@hirez.programming.kicks-ass.net>
 <20200221080325.GA67807@shbuild999.sh.intel.com> <20200221132048.GE652992@krava>
 <20200223141147.GA53531@shbuild999.sh.intel.com> <CAHk-=wjKFTzfDWjAAabHTZcityeLpHmEQRrKdTuk0f4GWcoohQ@mail.gmail.com>
 <20200224003301.GA5061@shbuild999.sh.intel.com>
In-Reply-To: <20200224003301.GA5061@shbuild999.sh.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Feb 2020 17:06:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
Message-ID: <CAHk-=whi87NNOnNXJ6CvyyedmhnS8dZA2YkQQSajvBArH5XOeA@mail.gmail.com>
Subject: Re: [LKP] Re: [perf/x86] 81ec3f3c4c: will-it-scale.per_process_ops
 -5.5% regression
To:     Feng Tang <feng.tang@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        andi.kleen@intel.com, "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 4:33 PM Feng Tang <feng.tang@intel.com> wrote:
>
> From the perf c2c data, and the source code checking, the conflicts
> only happens for root_user.__count, and root_user.sigpending, as
> all running tasks are accessing this global data for get/put and
> other operations.

That's odd.

Why? Because those two would be guaranteed to be in the same cacheline
_after_ you've aligned that user_struct.

So if it were a false sharing issue between those two, it would
actually get _worse_ with alignment. Those two fields are basically
next to each other.

But maybe it was straddling a cacheline before, and it caused two
cache accesses each time?

I find this as confusing as you do.

If it's sigpending vs the __refcount, then we almost always change
them together. sigpending gets incremented by __sigqueue_alloc() -
which also does a "get_uid()", and then we decrement it in
__sigqueue_free() - which also does a "free_uid().

That said, exactly *because* they get incremented and decremented
together, maybe we could do something clever: make the "sigpending" be
a separate user counter, kind of how we do mm->user vs mm-.count.

And we'd only increment __refcount as the sigpending goes from zero to
non-zero, and decrement it as sigpending goes back to zero. Avoiding
the double atomics for the case of "lots of signals".

>      ffffffff8225b580 d types__ptrace
>      ffffffff8225b5c0 D root_user
>      ffffffff8225b680 D init_user_ns

I'm assuming this is after the alignment patch (since that's 64-byte
aligned there).

What was it without the alignment?

> No, it's not the biggest, I tried another machine 'Xeon Phi(TM) CPU 7295',
> which has 72C/288T, and the regression is not seen. This is the part
> confusing me :)

Hmm.

Humor me - what  happens if you turn off SMT on that Cascade Lake
system?  Maybe it's about the thread ID bit in the L1? Although again,
I'd have expected things to get _worse_ if it's the two fields that
are now in the same cachline thanks to alignment.

The Xeon Phi is the small-core setup, right? They may be slow enough
to not show the issue as clearly despite having more cores. And it
wouldn't show effects of some out-of-order speculative cache accesses.

                Linus
