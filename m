Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF5AB333C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2019 17:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfFCPlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jun 2019 11:41:03 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43862 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfFCPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:41:01 -0400
Received: by mail-lf1-f43.google.com with SMTP id j29so54308lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=88zEtlZo9VcPYvQYA1jKvAsBkyo9fzTE6nwo1Hgnw4c=;
        b=g7xyhXorBa6FBLPRxz237Si+Si/iS47DotxTNT9gS16OG4gjNWyRGb5dCcvnI/8QvX
         xq3WRPTwie1oOh6i5GON8NUyBCfTnraWU9T+b3l1nrZg7dNuzHbATVP6/ijneNfXZlNj
         GO03Ng2cp1/WOXDZ9RS2z8kXYjDpjQg1kccFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=88zEtlZo9VcPYvQYA1jKvAsBkyo9fzTE6nwo1Hgnw4c=;
        b=gO5iXLwsHyPCAyRd4P8ku97KfUKitv9/ul+4Ldy+JDVH8FqwMswVdIc3SvbaMqrjcP
         kxNiSHdr4TN7f1KiRoNXbeivZq04slV9aSFYzJ+9SUbzH9TYCb52i46y6b+xvKP44SIC
         ebNfZsjRIDs2QORhamvpSsFt7av62H4IOyXIklJROtCMQk6vlrbq246CwNkuyi1V6AKH
         bQgQuA+3vLaXGxArauZc9n1ioGLsuE25rZ8Pa6BX2eHThVAryMKbJRFL37mmzgo3p+D7
         Why8Ky05o3mqLwOFkbotOpK4la6JXlS9YVi7m4VcpPwrKHcW5N/08TNBZUyXEXnnM7My
         GZJA==
X-Gm-Message-State: APjAAAUL2m++qvrWFOEf/q2LqgO7YaDorNMFbsUFIRVrjgQwrYmciaga
        wa392gihE3ewDTtZ7kpXNAGJqF8XOJw=
X-Google-Smtp-Source: APXvYqyIalw2eb7sW0V1xFl9BtOPEerJcx5tc+1R4p6Rra80xnsJzKg5gLWQGVZoNnP/l00cEuMDwQ==
X-Received: by 2002:a19:e308:: with SMTP id a8mr13573829lfh.69.1559576458739;
        Mon, 03 Jun 2019 08:40:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a18sm1227030ljf.35.2019.06.03.08.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:40:57 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id a21so1466813ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 08:40:57 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr14530773ljj.147.1559576456787;
 Mon, 03 Jun 2019 08:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20150910171649.GE4029@linux.vnet.ibm.com> <20150911021933.GA1521@fixme-laptop.cn.ibm.com>
 <20150921193045.GA13674@lerouge> <20150921204327.GH4029@linux.vnet.ibm.com>
 <20190602055607.bk5vgmwjvvt4wejd@gondor.apana.org.au> <CAHk-=whLGKOmM++OQi5GX08_dfh8Xfz9Wq7khPo+MVtPYh_8hw@mail.gmail.com>
 <20190603024640.2soysu4rpkwjuash@gondor.apana.org.au> <20190603034707.GG28207@linux.ibm.com>
 <20190603040114.st646bujtgyu7adn@gondor.apana.org.au> <20190603072339.GH28207@linux.ibm.com>
 <20190603084214.GA1496@linux.ibm.com> <9c0a9e2faae7404cb712f57910c8db34@AcuMS.aculab.com>
In-Reply-To: <9c0a9e2faae7404cb712f57910c8db34@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 08:40:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4pqF9bwjQHNzAKBmbAFTDWi9KwvLznj0HZLAZ+eGFpw@mail.gmail.com>
Message-ID: <CAHk-=wj4pqF9bwjQHNzAKBmbAFTDWi9KwvLznj0HZLAZ+eGFpw@mail.gmail.com>
Subject: Re: rcu_read_lock lost its compiler barrier
To:     David Laight <David.Laight@aculab.com>
Cc:     "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fengguang Wu <fengguang.wu@intel.com>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 8:26 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Paul E. McKenney
>
> > We do
> > occasionally use READ_ONCE() to prevent load-fusing optimizations that
> > would otherwise cause the compiler to turn while-loops into if-statements
> > guarding infinite loops.
>
> In that case the variable ought to be volatile...

No.

We do not use volatile on variables.

The C people got the semantics wrong, probably because 'volatile' was
historically for IO, not for access atomicity without locking.

It's not the memory location that is volatile, it is really the
_access_ that is volatile.

The same memory location might be completely stable in other access
situations (ie when done under a lock).

In other words, we should *never* use volatile in the kernel. It's
fundamentally mis-designed for modern use.

(Of course, we then can use volatile in a cast in code, which drives
some compiler people crazy, but that's because said compiler people
don't care about reality, they care about some paperwork).

                      Linus
