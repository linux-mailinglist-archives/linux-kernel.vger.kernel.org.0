Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23BEF66052
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2019 21:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfGKT7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 15:59:35 -0400
Received: from ajax.cs.uga.edu ([128.192.4.6]:55458 "EHLO ajax.cs.uga.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfGKT7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:59:34 -0400
X-Greylist: delayed 2416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 15:59:33 EDT
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (authenticated bits=0)
        by ajax.cs.uga.edu (8.14.4/8.14.4) with ESMTP id x6BJJFVn054162
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 11 Jul 2019 15:19:17 -0400
Received: by mail-lf1-f50.google.com with SMTP id h28so4811584lfj.5;
        Thu, 11 Jul 2019 12:19:17 -0700 (PDT)
X-Gm-Message-State: APjAAAWxheXejtPBkf3TaMAvpn/+tA0N+iGsz0xgfiAGKc7Mri0Xr5JA
        R7Zu/l2iW5sxEp5lgEyrt7/Hg+Elaq5qCPaS1oc=
X-Google-Smtp-Source: APXvYqwunc/O9uRDAgMduACqLWOqC09W6hXRDVHDdvBA5YcONGMc9t6fPqw9wsUN4kmB4dulWuL+7iJOiMAcA27WMv4=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr2543647lfh.177.1562872755598;
 Thu, 11 Jul 2019 12:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <1562830033-24239-1-git-send-email-wang6495@umn.edu> <CACVXFVO-gwVhZRajRx41_sYJKDTX2qZUnZVRXCB0NcegVVTGVw@mail.gmail.com>
In-Reply-To: <CACVXFVO-gwVhZRajRx41_sYJKDTX2qZUnZVRXCB0NcegVVTGVw@mail.gmail.com>
From:   Wenwen Wang <wenwen@cs.uga.edu>
Date:   Thu, 11 Jul 2019 14:18:42 -0500
X-Gmail-Original-Message-ID: <CAAa=b7fUF1NSDa-dr7VqCZ4wBm1vChe9BRpgx9A_S8wM_OoNAg@mail.gmail.com>
Message-ID: <CAAa=b7fUF1NSDa-dr7VqCZ4wBm1vChe9BRpgx9A_S8wM_OoNAg@mail.gmail.com>
Subject: Re: [PATCH] block/bio-integrity: fix a memory leak bug
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wenwen@cs.uga.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:22 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Thu, Jul 11, 2019 at 3:36 PM Wenwen Wang <wang6495@umn.edu> wrote:
> >
> > From: Wenwen Wang <wenwen@cs.uga.edu>
> >
> > In bio_integrity_prep(), a kernel buffer is allocated through kmalloc() to
> > hold integrity metadata. Later on, the buffer will be attached to the bio
> > structure through bio_integrity_add_page(), which returns the number of
> > bytes of integrity metadata attached. Due to unexpected situations,
> > bio_integrity_add_page() may return 0. As a result, bio_integrity_prep()
> > needs to be terminated with 'false' returned to indicate this error.
> > However, the allocated kernel buffer is not freed on this execution path,
> > leading to a memory leak.
> >
> > To fix this issue, free the allocated buffer before returning from
> > bio_integrity_prep().
> >
> > Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> > ---
> >  block/bio-integrity.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> > index 4db6208..bfae10c 100644
> > --- a/block/bio-integrity.c
> > +++ b/block/bio-integrity.c
> > @@ -276,8 +276,10 @@ bool bio_integrity_prep(struct bio *bio)
> >                 ret = bio_integrity_add_page(bio, virt_to_page(buf),
> >                                              bytes, offset);
> >
> > -               if (ret == 0)
> > +               if (ret == 0) {
> > +                       kfree(buf);
> >                         return false;
> > +               }
>
> This way may not be enough, and the bio payload needs to be freed.
>
> And you may refer to the error handling for 'IS_ERR(bip)', and bio->bi_status
> needs to be set, and bio_endio() needs to be called too.

Thanks for your comments! I will rework the patch.

Wenwen
