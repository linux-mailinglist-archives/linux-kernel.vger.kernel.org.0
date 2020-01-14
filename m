Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8254813A415
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 10:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgANJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 04:46:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36640 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgANJqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578995164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MqMDjz/VvcVqy9TYrQgv7wG9Dsl85OcI1K5HrS1sw24=;
        b=UoNjdviUAVGLgzUZdOwpvxXGOr+as7b5SEnmvIazG69moCqZ4n28wORZ+Azn0b+qphLSJ+
        QacaztUxgm509X/2mUnhoN040c/ZjUztyrT9y6llgBOmmdk7kh6JtyIW7Br3+ueAjY8AHZ
        lyqKPmmQnwBdZmq/vE087OKRxpC6Xmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-QBsaalF3My6c6zFxcrOtcw-1; Tue, 14 Jan 2020 04:46:03 -0500
X-MC-Unique: QBsaalF3My6c6zFxcrOtcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97CFF593A0;
        Tue, 14 Jan 2020 09:46:01 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C87560BF1;
        Tue, 14 Jan 2020 09:45:54 +0000 (UTC)
Date:   Tue, 14 Jan 2020 17:45:50 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH V2] brd: check parameter validation before
 register_blkdev func
Message-ID: <20200114094550.GA18268@ming.t460p>
References: <8b32ff09-74aa-3b92-38e4-aab12f47597b@huawei.com>
 <20200114091456.GA22268@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114091456.GA22268@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 05:16:57PM +0800, Ming Lei wrote:
> On Mon, Jan 13, 2020 at 09:43:23PM +0800, Zhiqiang Liu wrote:
> > In brd_init func, rd_nr num of brd_device are firstly allocated
> > and add in brd_devices, then brd_devices are traversed to add each
> > brd_device by calling add_disk func. When allocating brd_device,
> > the disk->first_minor is set to i * max_part, if rd_nr * max_part
> > is larger than MINORMASK, two different brd_device may have the same
> > devt, then only one of them can be successfully added.
> 
> It is just because disk->first_minor is >= 0x100000, then same dev_t
> can be allocated in blk_alloc_devt().
> 
> 	MKDEV(disk->major, disk->first_minor + part->partno)
> 
> But block layer does support extended dynamic devt allocation, and brd
> sets flag of GENHD_FL_EXT_DEVT too.
> 
> So I think the correct fix is to fallback to extended dynamic allocation
> when running out of consecutive minor space.
> 
> How about the following approach?
> 
> And of course, ext devt allocation may fail too, but that is another
> generic un-solved issue: error handling isn't done for adding disk.
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index a8730cc4db10..9aa7ce7c9abf 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -398,7 +398,16 @@ static struct brd_device *brd_alloc(int i)
>  	if (!disk)
>  		goto out_free_queue;
>  	disk->major		= RAMDISK_MAJOR;
> -	disk->first_minor	= i * max_part;
> +
> +	/*
> +	 * Clear .minors when running out of consecutive minor space since
> +	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended devt
> +	 */
> +	if ((i * disk->minors) & ~MINORMASK)
> +		disk->minors = 0;
> +	else
> +		disk->first_minor	= i * disk->minors;
> +
>  	disk->fops		= &brd_fops;
>  	disk->private_data	= brd;
>  	disk->flags		= GENHD_FL_EXT_DEVT;

But still suggest to limit 'max_part' <= 256, and the name is actually
misleading, which just reserves consecutive minors.

However, I don't think it is a good idea to add limit on device number.


Thanks,
Ming

