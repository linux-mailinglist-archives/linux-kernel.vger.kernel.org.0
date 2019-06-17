Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7B49602
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfFQXjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 19:39:06 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:38745 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfFQXjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 19:39:05 -0400
Received: by mail-lf1-f54.google.com with SMTP id b11so7837011lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NrsuK+fQa59Rf3zJAPEk/DpTvNWtzgqr6c6Hq01cwY=;
        b=Im9oEjWyr/vEdz9cgtOyleEhoCBdeVCcp3kWvdMeHXiN7x58vAV8sjEQKDudUFBh8E
         RxS+frlO5CQUO7JQDQ8qkogDUdkU7fmgqa4eHgTl13Zom7kAUMVec5A8Ne1jWBPaYFpa
         rHkCrluVPIkibD3eDmgnHGA9jDsnp0HYN0hFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NrsuK+fQa59Rf3zJAPEk/DpTvNWtzgqr6c6Hq01cwY=;
        b=q23zs5wwRixlLN4u6UDhDICr7A9Bb7y5FoUdb6+/mQPl/egnEQXDht5vlL/HtGFxBh
         g+YP/clx2RCEHMoRW5JZF2jShGC82Rjv2lLmIE/ykBqITCm3asdvZ2cHct+9E/bz2A01
         nXOtMq6FIE2btyOwO4lPgw7op+ARFz0nnTPY+lCAJqd21k2crfxah8bQ5U3MLYm5kz5A
         xULTN9LTJmD1CIBUdxNsq43gGPTgPIJhCh8y9OnTDI4V6N9QarqXD7xd41y+ILwyVAZW
         HlG0Hgdm5Ypbxhzy2CU9Kk8NQ8a3yDbignJ52Tgd9jV/ZkH3yehSSe4Alx1iIi/Jat8T
         7VgA==
X-Gm-Message-State: APjAAAUxYggczixXWZO7Km/Ru/oDfPyi5V2ljdwXS/6FDjCxGhEC1tY8
        7qqu5uJZ6thjbZASyKX2shpezaDo5iI=
X-Google-Smtp-Source: APXvYqwyOPHmXirlWlogsX9deNMzbFv41rg7cCFYSeA5zlxEhCp/H0xW7Rd4bMe8ZXdGWyRyXLDMOA==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr55978880lfu.74.1560814742182;
        Mon, 17 Jun 2019 16:39:02 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d15sm1911681lfq.76.2019.06.17.16.39.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 16:39:01 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id y17so7860929lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 16:39:00 -0700 (PDT)
X-Received: by 2002:a19:f808:: with SMTP id a8mr3385678lff.29.1560814740667;
 Mon, 17 Jun 2019 16:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com> <20190617224714.GR14363@dread.disaster.area>
In-Reply-To: <20190617224714.GR14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 16:38:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
Message-ID: <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:48 PM Dave Chinner <david@fromorbit.com> wrote:
>
> The wording of posix changes every time they release a new version
> of the standard, and it's _never_ obvious what behaviour the
> standard is actually meant to define. They are always written with
> sufficient ambiguity and wiggle room that they could mean
> _anything_. The POSIX 2017.1 standard you quoted is quite different
> to older versions, but it's no less ambiguous...

POSIX has always been pretty lax, partly because all the Unixes did
things differently, but partly because it then also ended up about
trying to work for the VMS and Windows posix subsystems..

So yes, the language tends to be intentionally not all that strict.

> > The pthreads atomicity thing seems to be about not splitting up IO and
> > doing it in chunks when you have m:n threading models, but can be
> > (mis-)construed to have threads given higher atomicity guarantees than
> > processes.
>
> Right, but regardless of the spec we have to consider that the
> behaviour of XFS comes from it's Irix heritage (actually from EFS,
> the predecessor of XFS from the late 1980s)

Sure. And as I mentioned, I think it's technically the nicer guarantee.

That said, it's a pretty *expensive* guarantee. It's one that you
yourself are not willing to give for O_DIRECT IO.

And it's not a guarantee that Linux has ever had. In fact, it's not
even something I've ever seen anybody ever depend on.

I agree that it's possible that some app out there might depend on
that kind of guarantee, but I also suspect it's much much more likely
that it's the other way around: XFS is being unnecessarily strict,
because everybody is testing against filesystems that don't actually
give the total atomicity guarantees.

Nobody develops for other unixes any more (and nobody really ever did
it by reading standards papers - even if they had been very explicit).

And honestly, the only people who really do threaded accesses to the same file

 (a) don't want that guarantee in the first place

 (b) are likely to use direct-io that apparently doesn't give that
atomicity guarantee even on xfs

so I do think it's moot.

End result: if we had a really cheap range lock, I think it would be a
good idea to use it (for the whole QoI implementation), but for
practical reasons it's likely better to just stick to the current lack
of serialization because it performs better and nobody really seems to
want anything else anyway.

                  Linus
