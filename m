Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39449105CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 23:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKUWgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 17:36:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32933 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:36:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so3976004lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2Jylx8PFuLRy2WCWeEwRvTNTPuu/3y4ij0pIDLCdHk=;
        b=n7kt5gyBx7+CfN0u3awNWs09SUh4HqDtQ8C4yhDsqMjUifowUL/yemrQXqXtFZ+d6m
         vWN75RfzO6X5Vi1k/t5gVnaXMOOqjcVAjMjfMwCo7tlh0mlA3FTuNdtRrDHqX/wJMjKN
         yxEKySDdIRP22OyQXOvLPnKVuV6mSP7IPd8C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2Jylx8PFuLRy2WCWeEwRvTNTPuu/3y4ij0pIDLCdHk=;
        b=rR00/TK3TqQecLyeVS0RTFAi7QPiWWALog510HXJbz2ZiBcFDng+raQvy3fDgnyOAI
         Ggxe/9uf5ooZWWAl/qYcLNX7ig2p5RKcJuWI/l8f9EJUWNKtyTlo2NcJ3g4DYSo9b81U
         WtUjL3AujomcYYggvdCGz/c5qJGQJ54gNu26f5kDGLWbSpENUuiKa4K/8ptGU1mez2iR
         1wy8CO+E3MOTFsQo7Ozwa+0iXYSN+zibr2LhZ6ZjOy/OVONzgKZ9edY0vFiabJolnUwi
         cRb4K1hon3XuEWuMvTquRetVnpbV2LppN5nTzYsgcLA0n8xG/W697nb01S9MLoflErBR
         z0sA==
X-Gm-Message-State: APjAAAWGZdaG1o6p6+nv1x20lFg+GzZgw/Ghp8FZI3Dfy4GoTCcIdmrM
        MTjJ81LU6xRQ91+tHt007N26BPsKZgw=
X-Google-Smtp-Source: APXvYqxyqzzEAnvuLFxHUY2mnO/oz022VjTNktFLjCb2CjTjG/qj3LmgZNQw+CRp7pF7ICXYygqUxg==
X-Received: by 2002:a19:5211:: with SMTP id m17mr10072036lfb.126.1574375794762;
        Thu, 21 Nov 2019 14:36:34 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o10sm2167946lfn.64.2019.11.21.14.36.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:36:33 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id a17so3905826lfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:36:33 -0800 (PST)
X-Received: by 2002:ac2:4945:: with SMTP id o5mr9307426lfi.93.1574375792616;
 Thu, 21 Nov 2019 14:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20191114235008.185111-1-evgreen@chromium.org> <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
 <20191120022518.GU6235@magnolia> <CAE=gft4mjKc4QKFKxp2FX9G2rUMuE3_eDuW_3Oq7NqTYBQwEjg@mail.gmail.com>
 <20191120191302.GV6235@magnolia> <CAE=gft6x1TmkkNTj+gktYMkHcysYyuYL50cavYusQ7hd9zChvA@mail.gmail.com>
 <20191120194507.GW6235@magnolia> <CAE=gft4OcxPP7srBe_2bj8K_0jHGD8Ae_PbV1Rq-Nz4F8GtkQA@mail.gmail.com>
 <20191121212512.GA2981917@magnolia>
In-Reply-To: <20191121212512.GA2981917@magnolia>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 21 Nov 2019 14:35:56 -0800
X-Gmail-Original-Message-ID: <CAE=gft4uLmLKexyCdRi2N8iJxzuBMXW-rcw+ob_pxBfyLVNijg@mail.gmail.com>
Message-ID: <CAE=gft4uLmLKexyCdRi2N8iJxzuBMXW-rcw+ob_pxBfyLVNijg@mail.gmail.com>
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

On Thu, Nov 21, 2019 at 1:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Nov 21, 2019 at 01:18:51PM -0800, Evan Green wrote:
> > On Wed, Nov 20, 2019 at 11:45 AM Darrick J. Wong
> > <darrick.wong@oracle.com> wrote:
> > >
> > > On Wed, Nov 20, 2019 at 11:25:48AM -0800, Evan Green wrote:
> > > > On Wed, Nov 20, 2019 at 11:13 AM Darrick J. Wong
> > > > <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > On Wed, Nov 20, 2019 at 10:56:30AM -0800, Evan Green wrote:
> > > > > > On Tue, Nov 19, 2019 at 6:25 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > > > >
> > > > > > > On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> > > > > > > > If the backing device for a loop device is itself a block device,
> > > > > > > > then mirror the "write zeroes" capabilities of the underlying
> > > > > > > > block device into the loop device. Copy this capability into both
> > > > > > > > max_write_zeroes_sectors and max_discard_sectors of the loop device.
> > > > > > > >
> > > > > > > > The reason for this is that REQ_OP_DISCARD on a loop device translates
> > > > > > > > into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> > > > > > > > presents a consistent interface for loop devices (that discarded data
> > > > > > > > is zeroed), regardless of the backing device type of the loop device.
> > > > > > > > There should be no behavior change for loop devices backed by regular
> > > > > > > > files.
> > > >
> > > > (marking this spot for below)
> > > >
> > > > > > > >
> > > > > > > > This change fixes blktest block/003, and removes an extraneous
> > > > > > > > error print in block/013 when testing on a loop device backed
> > > > > > > > by a block device that does not support discard.
> > > > > > > >
> > > > > > > > Signed-off-by: Evan Green <evgreen@chromium.org>
> > > > > > > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > > > > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > > > > > > > ---
> > > > > > > >
> > > > > > > > Changes in v7:
> > > > > > > > - Rebase on top of Darrick's patch
> > > > > > > > - Tweak opening line of commit description (Darrick)
> > > > > > > >
> > > > > > > > Changes in v6: None
> > > > > > > > Changes in v5:
> > > > > > > > - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> > > > > > > >
> > > > > > > > Changes in v4:
> > > > > > > > - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> > > > > > > >
> > > > > > > > Changes in v3:
> > > > > > > > - Updated commit description
> > > > > > > >
> > > > > > > > Changes in v2: None
> > > > > > > >
> > > > > > > >  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
> > > > > > > >  1 file changed, 29 insertions(+), 11 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> > > > > > > > index 6a9fe1f9fe84..e8f23e4b78f7 100644
> > > > > > > > --- a/drivers/block/loop.c
> > > > > > > > +++ b/drivers/block/loop.c
> > > > > > > > @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> > > > > > > >        * information.
> > > > > > > >        */
> > > > > > > >       struct file *file = lo->lo_backing_file;
> > > > > > > > +     struct request_queue *q = lo->lo_queue;
> > > > > > > >       int ret;
> > > > > > > >
> > > > > > > >       mode |= FALLOC_FL_KEEP_SIZE;
> > > > > > > >
> > > > > > > > -     if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> > > > > > > > +     if (!blk_queue_discard(q)) {
> > > > > > > >               ret = -EOPNOTSUPP;
> > > > > > > >               goto out;
> > > > > > > >       }
> > > > > > > > @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
> > > > > > > >       struct file *file = lo->lo_backing_file;
> > > > > > > >       struct inode *inode = file->f_mapping->host;
> > > > > > > >       struct request_queue *q = lo->lo_queue;
> > > > > > > > +     struct request_queue *backingq;
> > > > > > > > +
> > > > > > > > +     /*
> > > > > > > > +      * If the backing device is a block device, mirror its zeroing
> > > > > > > > +      * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> > > > > > > > +      * by block devices to keep consistent behavior with file-backed loop
> > > > > > > > +      * devices.
> > > > > > > > +      */
> >
> > Wait, I went to make this change and realized there's already a comment here.
> >
> > I can tweak the language a bit, but this is pretty much what you wanted, right?
>
> Yep.
>

Jens, any opinions? I'm happy to spin one more time to clarify the
comment as follows if desired, or leave it as-is too!

        /*
         * If the backing device is a block device, mirror its zeroing
         * capability. Set the discard sectors to the block device's zeroing
         * capabilities because loop discards result in blkdev_issue_zeroout(),
         * not blkdev_issue_discard(). This maintains consistent behavior with
         * file-backed loop devices: discarded regions read back as zero.
         */
