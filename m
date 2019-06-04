Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCF34ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfFDRaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 13:30:09 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:42280 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfFDRaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:30:08 -0400
Received: by mail-lf1-f41.google.com with SMTP id y13so17053583lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxau3u5QK4TvlKE/fTKEZope6FWr7Z8C5aaECU4mUHM=;
        b=NTeprb30chfrVf7/Ou53/FdAiV+JXX/NTlL7fhuusJ0hOtlpY/hzAIsG+bdU0fIR5J
         1WhsMxHwVhcM4jNa0vk7Tpa2CKyGTcKUtwg3I/YhA9e+jp1pprGc40A4sjea1En0Ef/2
         Ma76LXYNh8GIRO/VLPkLQNIohpp+r0s9lXXek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxau3u5QK4TvlKE/fTKEZope6FWr7Z8C5aaECU4mUHM=;
        b=Q9CJfAe7fcAnTy3db8p1q4NG8PYMmk5t1ahZzwdjBc3dFxzMhUFKQEKa5jSUxxWVws
         ZDjQWh9/zGOit/vTQZHwqaMHGQsNYVYKEIZL70YFrSaexlWdIUD5WsAtPuZl2zji2b3l
         XWfI0srSwJwivLnQ10txtzrr+6HCNGbLawNlBpmjSnAhvbRrWiygIRVLCVoPMPjsgJc7
         M6PWtjHMSioY7XSupd5WAbmHkC8qdMHfyNvEJzm0v3wRG/ZoY1ogH5r/0O89or0HLZCi
         oO+fGCg6vYYKO1aBYOiWBPVKWHppwg0HVj29TSSB+XTEeC9g8QvXKgjNwXtCI92DQEGd
         3yNg==
X-Gm-Message-State: APjAAAX4eHqYihOdz8OiodHuV4a0s7xZQTW/2vAKPVvsrPXSEQeRpOOt
        mxGkS4g6xvhtdMes7W17YtLqUUjNHPw=
X-Google-Smtp-Source: APXvYqw72lxPzf+k36Kcv+Hf/fP0xu61zUE2dQbWvmvYZ4419wmtY0K21Ej5WwZv557yuBvP6x1fQQ==
X-Received: by 2002:a19:a50b:: with SMTP id o11mr10856494lfe.183.1559669405803;
        Tue, 04 Jun 2019 10:30:05 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 80sm3869462lfz.56.2019.06.04.10.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:30:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m23so2219747lje.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:30:02 -0700 (PDT)
X-Received: by 2002:a2e:635d:: with SMTP id x90mr7932259ljb.140.1559669401822;
 Tue, 04 Jun 2019 10:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgGnCw==uY8radrB+Tg_CEmzOtwzyjfMkuh7JmqFh+jzQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1906041251210.1731-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1906041251210.1731-100000@iolanthe.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jun 2019 10:29:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJdffKFrZUZny=N=Yt91_9En6d+nbHF2NXKeopM3TC+A@mail.gmail.com>
Message-ID: <CAHk-=wjJdffKFrZUZny=N=Yt91_9En6d+nbHF2NXKeopM3TC+A@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Jade Alglave <j.alglave@ucl.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:00 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Which suggests asking whether these higher expectations should be
> reflected in the Linux Kernel Memory Model.  So far we have largely
> avoided doing that sort of thing, although there are a few exceptions.

I think they might be hard to describe - which in turn may be why the
standard leaves it open and only describes the simple cases.

Exactly that "we expect an assignment to be done as a single write" is
probably a good example. Yes, we do have that expectation for the
simple cases. But it's not an absolute rule, obviously, because it's
clearly violated by bitfield writes, and similarly it's obviously
violated for data that is bigger than the word size (ie a "u64"
assignment is obviously not a single write when you're on a 32-bit
target).

And while those cases are static and could be described separately,
the "oh, and we have _other_ accesses to the same variable nearby, and
we expect that the compiler might take those into account unless we
explicitly use WRITE_ONCE()" things make for much more hard to
describe issues.

Doing writes with speculative values is clearly bogus and garbage
(although compiler writers _have_ tried to do that too: "we then
overwrite it with the right value later, so it's ok"), and thankfully
even user space people complain about that due to threading and
signals. But eliding writes entirely by combining them with a later
one is clearly ok - and eliding them when there was an explcit earlier
read and value comparison (like in my example) sounds reasonable to me
too. Yet silently adding the elision that wasn't visible in the source
due to other accesses would be bad.

How do you say "sane and reasonable compiler" in a spec? You usually
don't - or  you make the rules so odd and complex than nobody really
understands them any more, and make it all moot ;)

                 Linus
