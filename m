Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2EC15B693
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 02:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgBMBUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 20:20:50 -0500
Received: from mail-il1-f169.google.com ([209.85.166.169]:40790 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgBMBUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:20:50 -0500
Received: by mail-il1-f169.google.com with SMTP id i7so3511906ilr.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 17:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHNas6UsXn7Nf8sBWZiCEeYXkSgWOiwfe+b1rjkowDU=;
        b=jDyUKoU12U5rX4bR742TJbOo0bcz8Ph6GJnr7yKk8hsnm8+zh0h8WvzQ+5/ExuJJd9
         K1V4U05uH/IE3a/IloM1LlHZ2XAMM+pHD7V2kTN5M1H8cHTKl04gYepCTbPBfi8MCa4G
         b4K/LiyRKLaEblX1V1Zx7K3Nyf1SMqGCvBE1/i5O+QmifHakisvf5o/4JttKOW7dByQb
         rtal656EZxAH4RilPS1U01l8EV6J4SQTj/FFMZult3+yzr4b2eH82B9ef0TuGCjtLQsS
         RZgRDpQvcEwX000bTGLxMoxtMNlLTvTTn6LkbNaS7Ek1GNGnVG+37SxBY357R4saWJ4O
         6IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHNas6UsXn7Nf8sBWZiCEeYXkSgWOiwfe+b1rjkowDU=;
        b=FANdwHJJzyu0NJYed72r160kwiun8EGZF7IFEbtbg7+9RpEEmC607WY0FxZ5qZM13O
         BrdiQJC+qFKpa+NpZXUwe/ZxEN19mGAQYJ5lEW1Xgj51rZv/IEcOzJs5SAKtocsKzj0m
         TgKB0valoHD1JTbkvMDyMHIOAgT2QFlzKKM5tgKkMQLdPSUekwqw5DudzYPJbAkLl2+c
         SP+sT8WYfKu5N4IA+l/xGuQMhiZvxGD1bNkP5zj/7Js6YlQnH9iSoyp6E8QDLGWI9PrD
         /EOy0lFFjtPO53RE1kb3iFPQYZ+C5Aa5bqhUUAlENPMKTWEftd0zptBjSDFW/tl0mcd/
         DS3A==
X-Gm-Message-State: APjAAAW+FzCBlzZQh3JebiVOQaxa8t24o0Uqnaiey9baHEur3OjNFsY1
        5p6cE4s+dyEfYS5Y46NaAyGXIENCXSbFBKt81aWypw==
X-Google-Smtp-Source: APXvYqyNpvHvjqpaaZba0hZuyG5sXWzOSR2xDWNUcLL2J13F009UDLsF4Rm3JnE6GLQT48KmEBZIr1Uk+FTKLg2QnvE=
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr13577866ilj.56.1581556849306;
 Wed, 12 Feb 2020 17:20:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200212230652.GA145444@mit.edu>
In-Reply-To: <20200212230652.GA145444@mit.edu>
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 12 Feb 2020 17:20:38 -0800
Message-ID: <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 3:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> This is a problem we've been strugging with in other contexts.  For
> example, if you have the hung task timer set to 2 minutes, and the
> system to panic if the hung task timer exceeds that, and an NFS server
> which the client is writing to crashes, and it takes longer for the
> NFS server to come back, that might be a situation where we might want
> to exempt the hung task warning from panic'ing the system.  On the
> other hand, if the process is failing to schedule for other reasons,
> maybe we would still want the hung task timeout to go off.
>
> So I've been meditating over whether the right answer is to just
> globally configure the hung task timer to something like 5 or 10
> minutes (which would require no kernel changes, yay?), or have some
> way of telling the hung task timeout logic that it shouldn't apply, or
> should have a different timeout, when we're waiting for I/O to
> complete.

The problem that I anticipate in our space is that a generous timeout
will make impatient people reboot their chromebooks, losing us
information
about hangs.  But, this can be worked around by having multiple
different timeouts.  For instance, a thread that is expecting to do
something slow, can set a flag
to indicate that it wishes to be held against the more generous
criteria.  This is something I am tempted to do on older kernels where
we might not feel
comfortable backporting io_uring.

>
> It seems to me that perhaps there's a different solution here for your
> specific case, which is what if there is a asynchronous version of
> BLKSECDISCARD, either using io_uring or some other interface?  That
> bypasses the whole issue of how do we modulate the hung task timeout
> when it's a situation where maybe it's OK for a userspace thread to
> block for more than 120 seconds, without having to either completely
> disable the hung task timeout, or changing it globally to some much
> larger value.

This is worth evaluating.

Thanks,

Salman

>
>                                         - Ted
