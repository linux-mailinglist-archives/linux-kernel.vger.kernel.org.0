Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C10C58A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2019 09:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfK1I73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Nov 2019 03:59:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43657 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfK1I73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:59:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so3135816qkn.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZDOmo+mPfnPdaN//xLxORxFeLKUGqLr+J7G6xlCcv0=;
        b=SqLbd+9oTES7vGoU6eGRMkOpdFNV40HLc8s+9TAEtizxbar9kUpZ2tYAOwvaCY1zJ+
         h2RoTvo57zIm/phFl00V8pNUu++Ie3H2YdWs5duONa6ZKlqZcd3g5I+xw9BtKTc+uUCg
         mkSzYl/52v0L6ZFbszaSXtmAE+0/SOnzVv8g/2TvaZz1fGjnWDca/ilGBsMv/qxl8KSL
         xQAZnM9roykuNy0O/hXzxcFl4RG9lANGbs8Syy6W6Bf5a02XsRcE9w5/+oZcjCQaB01w
         hwiQPa9y/o5RMKSE8pPl9j5Evo2S4Nyk5RdMnwDFqxg8avw58AnnFNmJXvs343DJaTt9
         oMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZDOmo+mPfnPdaN//xLxORxFeLKUGqLr+J7G6xlCcv0=;
        b=dvdrjWwTgfctOjc8Z+/EvJzfy9z39D7NHi2nj801X9xGovhEZ14UDLFsBXbLSM/FeC
         cg2G/BVY+EdnyNQ4B00gmZ+oLEewe3lNuGF0eAQhNBj9E/qVeT2MW3k8xSo7BPF+1vL4
         EzB73Qiej2VlWHF0Rc4f6NNx5P1rGhv10A0Z2LwGIi7TlMDjqlTk0rA6g62rHJzSYJaL
         syr6/2vuoem/lUSWkQhRfUZHO+uJRBeMU1huECCnoiQHZdUdtspHoRyPG3yu4N+4nY/8
         WpSsOrsWeL/kA3/qp1kalIWRCxMOyFAcXnXvaMmaYq9sYFAqePKGPTc1XxNCCVqTJeqH
         efVg==
X-Gm-Message-State: APjAAAUT98ceYAnVrzMmHz7lXwKKPuJ0z4qiCkd+gImxO0A20jyzFjfN
        oJHaigTl+ogdZK7FpLtGH+4YIylZySaet+V6UFha+0cm
X-Google-Smtp-Source: APXvYqxQ8DtLmeAzs+5VWeB2Gdz5ZzKRF7gLOdRvhy2DWqwJIHm23YKNcX22+xkzBrqhwZiFwlBokOtLC2TXudHDan0=
X-Received: by 2002:a37:e312:: with SMTP id y18mr5456024qki.250.1574931134398;
 Thu, 28 Nov 2019 00:52:14 -0800 (PST)
MIME-Version: 1.0
References: <201911262053.C6317530@keescook> <00000000000085ce5905984f2c8b@google.com>
 <201911271124.F01A0B37@keescook>
In-Reply-To: <201911271124.F01A0B37@keescook>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Nov 2019 09:52:03 +0100
Message-ID: <CACT4Y+aEeUaTQioc85nPXG9GM_ODojdoywNoVEOf5b6yXXU0cg@mail.gmail.com>
Subject: Re: WARNING in generic_make_request_checks
To:     Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     syzbot <syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com>,
        00moses.alexander00@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Ilya Dryomov <idryomov@gmail.com>, joseph.qi@linux.alibaba.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, wgh@torlan.ru,
        zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Nov 26, 2019 at 11:45:00PM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         8b2ded1c block: don't warn when doing fsync on read-only d..
> > git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d727e10a28207217
> > dashboard link: https://syzkaller.appspot.com/bug?extid=21cfe1f803e0e158acf1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Note: testing is done by a robot and is best-effort only.
>
> It seems for successful tests, I still need to tell syzbot that this is
> fixed?

+syzkaller mailing list for syzbot discussion

Yes.
You used a commit. But patch testing may work with raw attached
patches, or on trees that are not merged, or it may just a trial run
on HEAD or run with additional debugging only and it may incidentally
succeed; or may be not incidentally but the patch disables part of
functionality just to check if it affects the crash or not, but it's
totally not a fix for the bug.
Nobody ever figured out how all of this could work; allocate time to
write a complete proposal for the workflow and implement this.
So at the moment patch testing functionality is completely unrelated
to the rest of the workflow. It's a convenience feature.


> #syz fix: block: don't warn when doing fsync on read-only devices
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/201911271124.F01A0B37%40keescook.
