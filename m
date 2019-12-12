Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C811C9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 10:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfLLJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 04:54:34 -0500
Received: from verein.lst.de ([213.95.11.211]:32911 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbfLLJye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:54:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 59FF468B05; Thu, 12 Dec 2019 10:54:31 +0100 (CET)
Date:   Thu, 12 Dec 2019 10:54:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, mst@redhat.com, jejb@linux.ibm.com, hch@lst.de,
        linux-nvme@lists.infradead.org,
        Someswarudu Sangaraju <ssomesh@amazon.com>
Subject: Re: [RFC PATCH] block/genhd: Notify udev about capacity change
Message-ID: <20191212095431.GA3720@lst.de>
References: <20191210030131.4198-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210030131.4198-1-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 03:01:31AM +0000, Balbir Singh wrote:
> Allow block/genhd to notify user space (via udev) about disk size changes
> using a new helper disk_set_capacity(), which is a wrapper on top
> of set_capacity(). disk_set_capacity() will only notify via udev if
> the current capacity or the target capacity is not zero.
> 
> disk_set_capacity() is not enabled for all devices, just virtio block,
> xen-blockfront, nvme and sd. Owners of other block disk devices can
> easily move over by changing set_capacity() to disk_set_capacity()
> 
> Background:
> 
> As a part of a patch to allow sending the RESIZE event on disk capacity
> change, Christoph (hch@lst.de) requested that the patch be made generic
> and the hacks for virtio block and xen block devices be removed and
> merged via a generic helper.
> 
> Testing:
> 1. I did some basic testing with an NVME device, by resizing it in
> the backend and ensured that udevd received the event.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
> ---
>  block/genhd.c                | 19 +++++++++++++++++++
>  drivers/block/virtio_blk.c   |  4 +---
>  drivers/block/xen-blkfront.c |  5 +----
>  drivers/nvme/host/core.c     |  2 +-
>  drivers/scsi/sd.c            |  2 +-
>  include/linux/genhd.h        |  1 +
>  6 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index ff6268970ddc..94faec98607b 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
>  
> +/*
> + * Set disk capacity and notify if the size is not currently
> + * zero and will not be set to zero

Nit: Use up all the 80 chars per line.  Also maybe turn this into a
kerneldoc comment.  I think you also want to mention the notification
as well.

> +EXPORT_SYMBOL_GPL(disk_set_capacity);
> +
> +
>  void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)

No need for the double empty line.

>  {
>  	if (queue_is_mq(q))
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 7ffd719d89de..869cd3c31529 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c

And you probably want to turn this into a series with patch 1 adding
the infrastructure, and then one patch per driver switched over.
