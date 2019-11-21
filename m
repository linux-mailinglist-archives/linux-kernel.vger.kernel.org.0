Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69CFA105BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 22:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKUVTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 16:19:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43152 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 16:19:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so4842020ljh.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L59pxlP2h08giolehrbEu//J/zWHVNPRb2f26ecJqHM=;
        b=cHI403mFP70A3RgVqDv2UyS2js6BF1mI1YRiR/P7BDbQyTnZFaOYsC3SIL4X1UVXt9
         jXdZ/NK2In5G19otIuHbirY05Xi5rSZE+FPhBdyzIgjqlMQXogxnYynlfCsG3zMU+pZR
         lAIMOqlTk8L0KfipBKDFixcUBmcWuT/u49X2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L59pxlP2h08giolehrbEu//J/zWHVNPRb2f26ecJqHM=;
        b=mpZwNwhZVkvL8SdYFxz2qL6cAe9elmgci4V0vSpqDofGx+J20DCIDVK95cmfXl6mL5
         Gs6nlamefcanAO5q3CpTCu0jB9/HHIjg2L4IoFxy2IsQlNXhELOd5zli/6udn2z8RobW
         09J92VKAaKghCCTn1fmiz2oF65DsuLw011OByA7wJuM3pA6nVm4D1zwEtnzZgguHrF25
         MhkQIvgUB1zzhojAn3ome6WanwkHMXUjYwZSpNZ7mpaeWkMdiVhC7rTzfAyGK6O2QB19
         0H9Me2JRkXb/bOmJcBvR2L54a7S4nUXG98WikFHxkUHegZnw9ADcvYzSw2LhArJ3zh9Z
         rWYA==
X-Gm-Message-State: APjAAAUc+R+ZO5jioY4JN0XeuOzAkYVRlc5Pvq3NKfSltXbrXLWijUIb
        d2nLIcwI+evZdmzyu68DT1KhOecthak=
X-Google-Smtp-Source: APXvYqyCh2V7+3Kt5pc63WZ5AyFSi509/lB31HqLG73cU2sU+6OZVpeOY1SWmRi4hJ7/xJlERLTLJA==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr9222297lji.175.1574371171016;
        Thu, 21 Nov 2019 13:19:31 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m12sm2002295lfb.60.2019.11.21.13.19.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 13:19:29 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id m4so4852708ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 13:19:28 -0800 (PST)
X-Received: by 2002:a2e:9208:: with SMTP id k8mr9619555ljg.14.1574371167841;
 Thu, 21 Nov 2019 13:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20191114235008.185111-1-evgreen@chromium.org> <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia> <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
 <20191120191302.GV6235@magnolia> <CAE=gft6x1TmkkNTj+gktYMkHcysYyuYL50cavYusQ7hd9zChvA@mail.gmail.com>
 <20191120194507.GW6235@magnolia>
In-Reply-To: <20191120194507.GW6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 21 Nov 2019 13:18:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft4OcxPP7srBe_2bj8K_0jHGD8Ae_PbV1Rq-Nz4F8GtkQA@mail.gmail.com>
Message-ID: <CAE=gft4OcxPP7srBe_2bj8K_0jHGD8Ae_PbV1Rq-Nz4F8GtkQA@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] loop: Better discard support for block devices
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:45 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Wed, Nov 20, 2019 at 11:25:48AM -0800, Evan Green wrote:
> > On Wed, Nov 20, 2019 at 11:13 AM Darrick J. Wong
> > <darrick.wong@oracle.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 10:56:30AM -0800, Evan Green wrote:
> > > > On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > > > > > If the backing device for a loop device is itself a block device,
> > > > > > then mirror the "write zeroes" capabilities of the underlying
> > > > > > block device into the loop device. Copy this capability into both
> > > > > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > > > > >
> > > > > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > > > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > > > > presents a consistent interface for loop devices (that discarded data
> > > > > > is zeroed), regardless of the backing device type of the loop device.
> > > > > > There should be no behavior change for loop devices backed by regular
> > > > > > files.
> >
> > (marking this spot for below)
> >
> > > > > >
> > > > > > This change fixes blktest block/003, and removes an extraneous
> > > > > > error print in block/013 when testing on a loop device backed
> > > > > > by a block device that does not support discard.
> > > > > >
> > > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > > > ---
> > > > > >
> > > > > > Changes in v7:
> > > > > > - Rebase on top of Darrick's patch
> > > > > > - Tweak opening line of commit description (Darrick)
> > > > > >
> > > > > > Changes in v6: None
> > > > > > Changes in v5:
> > > > > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Updated commit description
> > > > > >
> > > > > > Changes in v2: None
> > > > > >
> > > > > >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> > > > > >  1 file changed, 29 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > > > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > > > > > --- a/drivers/block/loop.c
> > > > > > +++ b/drivers/block/loop.c
> > > > > > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > > > > >        * information.
> > > > > >        */
> > > > > >       struct file *file = lo->lo_backing_file;
> > > > > > +     struct request_queue *q = lo->lo_queue;
> > > > > >       int ret;
> > > > > >
> > > > > >       mode |= FALLOC_FL_KEEP_SIZE;
> > > > > >
> > > > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > > > +     if (!blk_queue_discard(q)) {
> > > > > >               ret = -EOPNOTSUPP;
> > > > > >               goto out;
> > > > > >       }
> > > > > > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
> > > > > >       struct file *file = lo->lo_backing_file;
> > > > > >       struct inode *inode = file->f_mapping->host;
> > > > > >       struct request_queue *q = lo->lo_queue;
> > > > > > +     struct request_queue *backingq;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * If the backing device is a block device, mirror its zeroing
> > > > > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > > > > +      * by block devices to keep consistent behavior with file-backed loop
> > > > > > +      * devices.
> > > > > > +      */

Wait, I went to make this change and realized there's already a comment here.

I can tweak the language a bit, but this is pretty much what you wanted, right?

> > > > > > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > > > > > +             backingq = bdev_get_queue(inode->i_bdev);
> > > > > > +             blk_queue_max_discard_sectors(q,
> > > > > > +                     backingq->limits.max_write_zeroes_sectors);
> > > > >
> > > > > max_discard_sectors?
> > > >
> > > > I didn't plumb max_discard_sectors because for my scenario it never
> > > > ends up hitting the block device that way.
> > > >
> > > > The loop device either uses FL_ZERO_RANGE or FL_PUNCH_HOLE. When
> > > > backed by a block device, that ends up in blkdev_fallocate(), which
> > > > always translates both of those into blkdev_issue_zeroout(), not
> > > > blkdev_issue_discard(). So it's really the zeroing capabilities of the
> > > > block device that matters, even for loop discard operations. It seems
> > > > weird, but I think this is the right thing because it presents a
> > > > consistent interface to loop device users whether backed by a file
> > > > system file, or directly by a block device. That is, a previously
> > > > discarded range will read back as zeroes.
> > >
> > > Ah, right.  Could you add this paragraph as a comment explaining why
> > > we're setting max_discard_sectors from max_write_zeroes_sectors?
> >
> > Sure. I put an explanation in the commit description (see spot I
> > marked above), but I agree a comment is probably also worthwhile.
>
> <nod> Sorry about the churn here.
>
> I have a strong preference towards documenting decisions like these
> directly in the code because (a) I suck at reading patch prologues, (b)
> someone reading the code after this gets committed will see it
> immediately and right next to the relevant code, and (c) spelunking
> through the git history of a file for commit messages is kind of clunky.
>
> Dunno if that's just my age showing (mmm, pre-bk linux) or what. :/
>
> --D
>
> > >
> > > --D
> > >
> > > > -Evan
