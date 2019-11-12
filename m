Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F5F9707
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 18:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfKLRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 12:23:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34057 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfKLRXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:23:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so18730399ljf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqZ6aoRyIylIecsmSSAb9dRfDRU1BzAByAgXnVXCrRM=;
        b=ZTeGh3lZndBxwdlvDeCbDyVi53WE1KSHIiiPlnOEl2C5MK39x6ya8Za7A++QrC/sAG
         he/U/ARZm4oqi4XF4Il6/LqSjNzi+bpAISHwSpTaHlPuPZqfDTu56u61oWg6zr2M+2+q
         kcHa7bKFHVpAbG7XmDjp+y4LGApQCXMob08GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqZ6aoRyIylIecsmSSAb9dRfDRU1BzAByAgXnVXCrRM=;
        b=lCAMjx3Z8P9aG9KY2lDWyu1wsIJPTjrZ8YDySrgrtRCFE+MKKtL/1SvznPv9a1VjqO
         QoFuP+hmTGPneoiUP3ch9bGMMubvYCJjYg7RJoN2zlaNJ6sxrGhHl4P+iK7hDjZHor/L
         xNMQZZv8bVCDF6W16lwLtpj9A9zmOIkWtgogK6h4KDgcWg+CG0n6/R9YEu4TIOBiOM4G
         9ck2Jul/g6hhhbhCw2WL6u8TyuIBM8tZnU41kFkPEyt6BfJ5V11sjVpJ2zmrTig8Yyts
         b14YV7YWQ4IhTb2k/7xxYxpjblrwDBwbF0d5t/qvRwaEDuMIfob4lxJTQSN8Bp0HBaeB
         wlAw==
X-Gm-Message-State: APjAAAWQp7HGs/wxoRPnaPm8t2mykZsl6/gtaJRO4fpYhjkdsHHKx6Wx
        Er+HhjgNk/uKhI8mJQ9HfEFURsrc84M=
X-Google-Smtp-Source: APXvYqzPUj2V90b0+3tN4yY1c4v1MpZjBCJIS8S7et1X8Asu2kCtOdhtoq+XxHXjpid1xd7JXQ81Mg==
X-Received: by 2002:a2e:301a:: with SMTP id w26mr15887189ljw.116.1573579410290;
        Tue, 12 Nov 2019 09:23:30 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id m62sm9935239lfa.10.2019.11.12.09.23.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:23:29 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id n21so18718639ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:28 -0800 (PST)
X-Received: by 2002:a2e:8518:: with SMTP id j24mr10027880lji.13.1573579407981;
 Tue, 12 Nov 2019 09:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-3-evgreen@chromium.org>
 <20191112013639.GE6235@magnolia>
In-Reply-To: <20191112013639.GE6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 12 Nov 2019 09:22:51 -0800
X-Gmail-Original-Message-ID: <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
Message-ID: <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] loop: Better discard support for block devices
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
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

Thanks for replying and taking a look Darrick. I didn't see your patch
in Jens tree when I looked just before sending it, but maybe I missed
it.

On Mon, Nov 11, 2019 at 5:37 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Mon, Nov 11, 2019 at 10:50:30AM -0800, Evan Green wrote:
> > If the backing device for a loop device is a block device,
> > then mirror the "write zeroes" capabilities of the underlying
> > block device into the loop device. Copy this capability into both
> > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> >
> > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > presents a consistent interface for loop devices (that discarded data
> > is zeroed), regardless of the backing device type of the loop device.
> > There should be no behavior change for loop devices backed by regular
> > files.
> >
> > While in there, differentiate between REQ_OP_DISCARD and
> > REQ_OP_WRITE_ZEROES, which are different for block devices,
> > but which the loop device had just been lumping together, since
> > they're largely the same for files.
> >
> > This change fixes blktest block/003, and removes an extraneous
> > error print in block/013 when testing on a loop device backed
> > by a block device that does not support discard.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > ---
> >
> > Changes in v6: None
> > Changes in v5:
> > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> >
> > Changes in v4:
> > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> >
> > Changes in v3:
> > - Updated commit description
> >
> > Changes in v2: None
> >
> >  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > index d749156a3d88..236f6deb0772 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> >       return ret;
> >  }
> >
> > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > +static int lo_discard(struct loop_device *lo, struct request *rq,
> > +             int mode, loff_t pos)
> >  {
> > -     /*
> > -      * We use punch hole to reclaim the free space used by the
> > -      * image a.k.a. discard. However we do not support discard if
> > -      * encryption is enabled, because it may give an attacker
> > -      * useful information.
> > -      */
> >       struct file *file = lo->lo_backing_file;
> > -     int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > +     struct request_queue *q = lo->lo_queue;
> >       int ret;
> >
> > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > +     if (!blk_queue_discard(q)) {
> >               ret = -EOPNOTSUPP;
> >               goto out;
> >       }
> > @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> >       case REQ_OP_FLUSH:
> >               return lo_req_flush(lo, rq);
> >       case REQ_OP_DISCARD:
> > +             return lo_discard(lo, rq,
> > +                     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> > +
> >       case REQ_OP_WRITE_ZEROES:
> > -             return lo_discard(lo, rq, pos);
> > +             return lo_discard(lo, rq,
> > +                     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
>
> Yes, this more or less reimplements what's already in -next...

Agree, this part would disappear if I rebased on top of your patch.
This series has been around for awhile, you see :)

>
> > +
> >       case REQ_OP_WRITE:
> >               if (lo->transfer)
> >                       return lo_write_transfer(lo, rq, pos);
> > @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
> >       struct file *file = lo->lo_backing_file;
> >       struct inode *inode = file->f_mapping->host;
> >       struct request_queue *q = lo->lo_queue;
> > +     struct request_queue *backingq;
> > +
> > +     /*
> > +      * If the backing device is a block device, mirror its zeroing
> > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > +      * by block devices to keep consistent behavior with file-backed loop
> > +      * devices.
> > +      */
> > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > +             backingq = bdev_get_queue(inode->i_bdev);
>
> What happens if the inode is from a filesystem that can have multiple
> backing devices (like btrfs)?

Then I would expect S_ISBLK(inode->i_mode) would not be true. This is
only for when you've created a loop device directly on top of a block
device (ie you pointed the loop device at /dev/sda). We use this in
our Chrome OS installer because it makes the logic simple whether
you're installing to a real disk or a file image.

>
> > +             blk_queue_max_discard_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
> > +
> > +             blk_queue_max_write_zeroes_sectors(q,
> > +                     backingq->limits.max_write_zeroes_sectors);
>
> Also, seeing as filesystems tend to implement PUNCH_HOLE and ZERO_RANGE
> on their own independent of the hardware capabilities of the underlying
> device, it doesn't make much sense to forward the blockdev limits to the
> loop device.
>
> (Put another way, XFS's ZERO_RANGE implementation can zero hundreds of
> gigabytes at a time even if the underlying device is a spinning rust.)

Hopefully my comment above addresses this too (there is no file system
in the scenario I'm coding for).
