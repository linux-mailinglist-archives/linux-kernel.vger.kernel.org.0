Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DF545296
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 05:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfFNDQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 23:16:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45436 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfFNDQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:16:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id m23so779164lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJD5Oc6zmvXaVn3uGPjjPCtVx39KdSpYi2Iir9oJ4pE=;
        b=c8Dd9yVuZrGwyOECEiNIFNBaiENJ8KvhuUkTobdjyjxFioQm9x+srYpCxXeYqUlYAD
         uTex+sHSyhpFTOwrn9/TaRkbBKGIWujgB4MwCYBbZyXMUhQwCbFSkjXCppR6gW+P4o4I
         KGyDDzVlQn4xshfEF5ZvoJKHSfyRCHHZmFIHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJD5Oc6zmvXaVn3uGPjjPCtVx39KdSpYi2Iir9oJ4pE=;
        b=KzhzvTqgDFLzcoSWbEindzLmVpV10geUO+kanMwuMQz0b3YnnH8pATf+VqI27Dk9pM
         v079CGR7U/mEE1EvubQd2WByg56GyZGpu3BS/EPNJZPBcBAWnPrIsUOqRNEztwbnBDuS
         HXZK4wwEuXn4ny89xVS6227DLuIE05tc0xUYNDr9y8mIb0kYuGzIavGGDAItvKia8T1T
         ktSQFakpHr7EsWrJWJVtL082cjYuvILTZaRynozKICr8itT0tN7ak3yCZGB91gThewxd
         Q8GzBqvJVxf47M0sCSQEaV5QGUc97kNr+bPiGdjMNIX665KmMqUiwWmudMN9rXsL3Bj0
         cQ4g==
X-Gm-Message-State: APjAAAV8+bnwsdL4LmSHQkRTazvUQf3poBtFZ+L+hq+RStVl225sVqUJ
        ZvYFrjZMz7llj6rWz5OlOk1SPkmyTTw=
X-Google-Smtp-Source: APXvYqzGe2iJ5n8eJfFyY19yJ5m+Fhhz3a+uoS+rocYMsJL/MBT944sjJs4kIWJH5xfQ3N1IGFaUBw==
X-Received: by 2002:a2e:934e:: with SMTP id m14mr22086486ljh.116.1560482167785;
        Thu, 13 Jun 2019 20:16:07 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i2sm317170ljc.96.2019.06.13.20.16.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:16:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t28so791877lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 20:16:07 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr3378542ljj.165.1560481713174;
 Thu, 13 Jun 2019 20:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
In-Reply-To: <20190613235524.GK14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Jun 2019 17:08:16 -1000
X-Gmail-Original-Message-ID: <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
Message-ID: <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
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

On Thu, Jun 13, 2019 at 1:56 PM Dave Chinner <david@fromorbit.com> wrote:
>
> - buffered read and buffered write can run concurrently if they
> don't overlap, but right now they are serialised because that's the
> only way to provide POSIX atomic write vs read semantics (only XFS
> provides userspace with that guarantee).

I do not believe that posix itself actually requires that at all,
although extended standards may.

That said, from a quality of implementation standpoint, it's obviously
a good thing to do, so it might be worth looking at if something
reasonable can be done. The XFS atomicity guarantees are better than
what other filesystems give, but they might also not be exactly
required.

But POSIX actually ends up being pretty lax, and says

  "Writes can be serialized with respect to other reads and writes. If
a read() of file data can be proven (by any means) to occur after a
write() of the data, it must reflect that write(), even if the calls
are made by different processes. A similar requirement applies to
multiple write operations to the same file position. This is needed to
guarantee the propagation of data from write() calls to subsequent
read() calls. This requirement is particularly significant for
networked file systems, where some caching schemes violate these
semantics."

Note the "can" in "can be serialized", not "must". Also note that
whole language about how the read file data must match the written
data only if the read can be proven to have occurred after a write of
that data.  Concurrency is very much left in the air, only provably
serial operations matter.

(There is also language that talks about "after the write has
successfully returned" etc - again, it's about reads that occur
_after_ the write, not concurrently with the write).

The only atomicity guarantees are about the usual pipe writes and
PIPE_BUF. Those are very explicit.

Of course, there are lots of standards outside of just the POSIX
read/write thing, so you may be thinking of some other stricter
standard. POSIX itself has always been pretty permissive.

And as mentioned, I do agree from a QoI standpoint that atomicity is
nice, and that the XFS behavior is better. However, it does seem that
nobody really cares, because I'm not sure we've ever done it in
general (although we do have that i_rwsem, but I think it's mainly
used to give the proper lseek behavior). And so the XFS behavior may
not necessarily be *worth* it, although I presume you have some test
for this as part of xfstests.

                Linus
