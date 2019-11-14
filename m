Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27217FB51A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 17:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfKMQbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 11:31:03 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38315 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKMQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id q28so2482408lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QpMKeUckTo+mfsqua8T2tEC8J4sPP/J5YMuHM55DNSM=;
        b=bWoZXgu3t+1SaWAtU/jwNH6U8Hy9gVJ4UfDZ4WN9XQD+J6nmExUtkhx8clPb0XjbQb
         l9vLEexE16IWscCaTnQlE93R3ISCrbrbSGamb30v1mOOPudEd4r3azFX65/7sdsXj8IT
         E8T0qreFlHxihurW82OzLaud6lFo2y8DauHD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QpMKeUckTo+mfsqua8T2tEC8J4sPP/J5YMuHM55DNSM=;
        b=ebi6Uemc8KgXgv+F/HFhsU4b3UZRM9QPYNgbAqEtG7g//ZMqgeFvL9sRXW/b9vXZTE
         STJ2OsmRz4Qd/2chU8dir5s2dKkxIc55njlNq3o2VxRBeNhdItaF+h1218C3dNA1MR8E
         zqk07qD9i5HV9i6h04J9aqBhAnQJfzPJwAVbx8yribOMhxKhsJE0yEu0T3oue7TR+EEk
         gUbNXeg4b7WctmyBUQpmDktfdzeeLjg5f7alBND/NZxZ1/Cmb5ZORWc1lQZRNaqXKKPm
         DFY0oQS5OSZnd3ykGU3CMQhW7X8oCrcDB80AXXsrgbPunO9xY7X5Zw25fhaZu1qc274Z
         bQxw==
X-Gm-Message-State: APjAAAU67X+NZxARpwE1ZO/4UEni0AcqH/UqwT6B/X6ViRA5FHN5i21k
        rUJFgk3cMkc8qTyLf0xE82/4x3+ope0=
X-Google-Smtp-Source: APXvYqyBWT+zUeDJ/TJtwkp1rlmybxV7OCm8ZYs13kqIcx7Reha1K+7hekzzjgyoGvqFKUXmvrl/QQ==
X-Received: by 2002:ac2:4882:: with SMTP id x2mr3268905lfc.103.1573662659746;
        Wed, 13 Nov 2019 08:30:59 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id j207sm1335889lfj.77.2019.11.13.08.30.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:30:58 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id d22so3275372lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:30:57 -0800 (PST)
X-Received: by 2002:a2e:760d:: with SMTP id r13mr3194207ljc.15.1573662657118;
 Wed, 13 Nov 2019 08:30:57 -0800 (PST)
MIME-Version: 1.0
References: <20191111185030.215451-1-evgreen@chromium.org> <20191111185030.215451-3-evgreen@chromium.org>
 <20191112013639.GE6235@magnolia> <CAE=gft4KDC0r3S-5p-oHz0cBiwpPqJ8mYVJ2JP7ghnPdaR_u6w@mail.gmail.com>
 <20191113003939.GG6235@magnolia>
In-Reply-To: <20191113003939.GG6235@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 13 Nov 2019 08:30:19 -0800
X-Gmail-Original-Message-ID: <CAE=gft4JNKVaxiF26LV_Eqoofoy8yOEnAjm-+iDJL994R7rqsg@mail.gmail.com>
Message-ID: <CAE=gft4JNKVaxiF26LV_Eqoofoy8yOEnAjm-+iDJL994R7rqsg@mail.gmail.com>
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

On Tue, Nov 12, 2019 at 4:40 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Tue, Nov 12, 2019 at 09:22:51AM -0800, Evan Green wrote:
> > Thanks for replying and taking a look Darrick. I didn't see your patch
> > in Jens tree when I looked just before sending it, but maybe I missed
> > it.
> >
> > On Mon, Nov 11, 2019 at 5:37 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Mon, Nov 11, 2019 at 10:50:30AM -0800, Evan Green wrote:
> > > > If the backing device for a loop device is a block device,
> > > > then mirror the "write zeroes" capabilities of the underlying
> > > > block device into the loop device. Copy this capability into both
> > > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > > >
> > > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > > presents a consistent interface for loop devices (that discarded data
> > > > is zeroed), regardless of the backing device type of the loop device.
> > > > There should be no behavior change for loop devices backed by regular
> > > > files.
> > > >
> > > > While in there, differentiate between REQ_OP_DISCARD and
> > > > REQ_OP_WRITE_ZEROES, which are different for block devices,
> > > > but which the loop device had just been lumping together, since
> > > > they're largely the same for files.
> > > >
> > > > This change fixes blktest block/003, and removes an extraneous
> > > > error print in block/013 when testing on a loop device backed
> > > > by a block device that does not support discard.
> > > >
> > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > ---
> > > >
> > > > Changes in v6: None
> > > > Changes in v5:
> > > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > > >
> > > > Changes in v4:
> > > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > > >
> > > > Changes in v3:
> > > > - Updated commit description
> > > >
> > > > Changes in v2: None
> > > >
> > > >  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
> > > >  1 file changed, 37 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > index d749156a3d88..236f6deb0772 100644
> > > > --- a/drivers/block/loop.c
> > > > +++ b/drivers/block/loop.c
> > > > @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
> > > >       return ret;
> > > >  }
> > > >
> > > > -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> > > > +static int lo_discard(struct loop_device *lo, struct request *rq,
> > > > +             int mode, loff_t pos)
> > > >  {
> > > > -     /*
> > > > -      * We use punch hole to reclaim the free space used by the
> > > > -      * image a.k.a. discard. However we do not support discard if
> > > > -      * encryption is enabled, because it may give an attacker
> > > > -      * useful information.
> > > > -      */
> > > >       struct file *file = lo->lo_backing_file;
> > > > -     int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> > > > +     struct request_queue *q = lo->lo_queue;
> > > >       int ret;
> > > >
> > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > +     if (!blk_queue_discard(q)) {
> > > >               ret = -EOPNOTSUPP;
> > > >               goto out;
> > > >       }
> > > > @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
> > > >       case REQ_OP_FLUSH:
> > > >               return lo_req_flush(lo, rq);
> > > >       case REQ_OP_DISCARD:
> > > > +             return lo_discard(lo, rq,
> > > > +                     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> > > > +
> > > >       case REQ_OP_WRITE_ZEROES:
> > > > -             return lo_discard(lo, rq, pos);
> > > > +             return lo_discard(lo, rq,
> > > > +                     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> > >
> > > Yes, this more or less reimplements what's already in -next...
> >
> > Agree, this part would disappear if I rebased on top of your patch.
> > This series has been around for awhile, you see :)
>
> Oh.  Didn't quite realize that. :/
>
> > > > +
> > > >       case REQ_OP_WRITE:
> > > >               if (lo->transfer)
> > > >                       return lo_write_transfer(lo, rq, pos);
> > > > @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
> > > >       struct file *file = lo->lo_backing_file;
> > > >       struct inode *inode = file->f_mapping->host;
> > > >       struct request_queue *q = lo->lo_queue;
> > > > +     struct request_queue *backingq;
> > > > +
> > > > +     /*
> > > > +      * If the backing device is a block device, mirror its zeroing
> > > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > > +      * by block devices to keep consistent behavior with file-backed loop
> > > > +      * devices.
> > > > +      */
> > > > +     if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> > > > +             backingq = bdev_get_queue(inode->i_bdev);
> > >
> > > What happens if the inode is from a filesystem that can have multiple
> > > backing devices (like btrfs)?
> >
> > Then I would expect S_ISBLK(inode->i_mode) would not be true. This is
> > only for when you've created a loop device directly on top of a block
> > device (ie you pointed the loop device at /dev/sda). We use this in
> > our Chrome OS installer because it makes the logic simple whether
> > you're installing to a real disk or a file image.
>
> Heh, doh, that's right. :)
>
> Sorry, for some reason I misread that as "If the backing device of the
> filesystem from which the inode came is a block device..."
>
> Might I suggest rewording the first sentence of the comment to read "If
> the loop device's backing device is itself a block device" for oafs like
> me? :)

Sure, I'll do that. Another spin coming shortly...

-Evan
