Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABC312550
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 02:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfECAGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 May 2019 20:06:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37206 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfECAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:06:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id h126so3188508lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7XiQW4yO5S75GOxtPW7qYJgx3vLILexPigP9cVq26Q=;
        b=kqp3rIPLnKkXsxqKe8m6UOPqXNL1ZiPyj+ow8LjF0BZ0NvuqIKemPw6OChxYP1qO0z
         vLuG0K8maM37uqvletWnDWnwzEIvgy8We4yqEb28xN4VJr8bSTS1i5jtnnqOaVXkeomF
         5bqT+7bF9PofJjZaPhysDZ++RkRfKxlK12obI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7XiQW4yO5S75GOxtPW7qYJgx3vLILexPigP9cVq26Q=;
        b=OfOqwu70I2jEaVzDq9e966w7F/KC9+6ScOIB3yxHdWIJfb+CdI9qgMQBsulYDIFHoq
         BDIRPcEOtlALo7HzaU7UtIyhGpb1ODyFiqxlMf8xhmRMmXZbMdiR/nnq/g35kl8GmZXg
         HdPLiKcs2pX/dGgd/UOB6gW7VttR7rGoiYkQRExHiBEOqUIXDfvQLMczAK0LJdTYw+P5
         fh8dJsZWgdq7wprtEQdXy4XBM9BbBz0GLqLB01NjNBnXOIAPhi0IqEFeQE8gKduXLAXw
         GXLukD/o4QzOENC6508pd5ptDCoIdT/5A8lIFp91itgzYKI5ia8DV+guUjTFipvPJbzR
         pKug==
X-Gm-Message-State: APjAAAXSw3xPA/WXZkJybEtc2Bu/FNazMgjL0Tp3lOKrAW2nEwvEIApP
        hnXzH17hbFA0Tv6LtqExF2/8Ugj8mno=
X-Google-Smtp-Source: APXvYqwUB9dHy2Q39wfNTNvtKDI/JUS7kfbFKyuGzHmSH5TweF96Rr8S162aLt0Ul1ZNbt+lzzGBPw==
X-Received: by 2002:ac2:4357:: with SMTP id o23mr3711684lfl.146.1556841975887;
        Thu, 02 May 2019 17:06:15 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n20sm77385lji.53.2019.05.02.17.06.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 17:06:15 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id f23so3837031ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 17:06:13 -0700 (PDT)
X-Received: by 2002:a2e:8ecd:: with SMTP id e13mr3509475ljl.30.1556841973316;
 Thu, 02 May 2019 17:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190502174409.74623-1-evgreen@chromium.org> <20190502174409.74623-3-evgreen@chromium.org>
In-Reply-To: <20190502174409.74623-3-evgreen@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 2 May 2019 17:05:37 -0700
X-Gmail-Original-Message-ID: <CAE=gft6ZcMnx15wemA4LraLY=cCGdKQgNtXf2DpABU=m0qd_DA@mail.gmail.com>
Message-ID: <CAE=gft6ZcMnx15wemA4LraLY=cCGdKQgNtXf2DpABU=m0qd_DA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] loop: Better discard support for block devices
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 10:44 AM Evan Green <evgreen@chromium.org> wrote:
>
> If the backing device for a loop device is a block device,
> then mirror the "write zeroes" capabilities of the underlying
> block device into the loop device. Copy this capability into both
> max_write_zeroes_sectors and max_discard_sectors of the loop device.
>
> The reason for this is that REQ_OP_DISCARD on a loop device translates
> into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
> presents a consistent interface for loop devices (that discarded data
> is zeroed), regardless of the backing device type of the loop device.
> There should be no behavior change for loop devices backed by regular
> files.
>
> While in there, differentiate between REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES, which are different for block devices,
> but which the loop device had just been lumping together, since
> they're largely the same for files.
>
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
> Changes in v4:
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
>
> Changes in v3:
> - Updated commit description
>
> Changes in v2: None
>
>  drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index bbf21ebeccd3..ca6983a2c975 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
>         return ret;
>  }
>
> -static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
> +static int lo_discard(struct loop_device *lo, struct request *rq,
> +               int mode, loff_t pos)
>  {
> -       /*
> -        * We use punch hole to reclaim the free space used by the
> -        * image a.k.a. discard. However we do not support discard if
> -        * encryption is enabled, because it may give an attacker
> -        * useful information.
> -        */
>         struct file *file = lo->lo_backing_file;
> -       int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> +       struct request_queue *q = lo->lo_queue;
>         int ret;
>
> -       if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> +       if (!blk_queue_discard(q)) {
>                 ret = -EOPNOTSUPP;
>                 goto out;
>         }
> @@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>         case REQ_OP_FLUSH:
>                 return lo_req_flush(lo, rq);
>         case REQ_OP_DISCARD:
> +               return lo_discard(lo, rq,
> +                       FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
> +
>         case REQ_OP_WRITE_ZEROES:
> -               return lo_discard(lo, rq, pos);
> +               return lo_discard(lo, rq,
> +                       FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
> +
>         case REQ_OP_WRITE:
>                 if (lo->transfer)
>                         return lo_write_transfer(lo, rq, pos);
> @@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
>         struct file *file = lo->lo_backing_file;
>         struct inode *inode = file->f_mapping->host;
>         struct request_queue *q = lo->lo_queue;
> +       struct request_queue *backingq;
> +
> +       /*
> +        * If the backing device is a block device, mirror its zeroing
> +        * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> +        * by block devices to keep consistent behavior with file-backed loop
> +        * devices.
> +        */
> +       if (S_ISBLK(inode->i_mode)) {

Gwendal pointed out elsewhere that this should be if
(S_ISBLK(inode->i_mode) && (lo->lo_encrypt_key_size == 0)). I think
that's correct because like the file-backed device, we want to fail
discard, forcing the user to manually zero out regions and write out
the encrypted zeroes. I'll plan to send a v5 soon.
