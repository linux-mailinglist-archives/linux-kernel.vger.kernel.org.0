Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1920103188
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2019 03:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKTCZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Nov 2019 21:25:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53660 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfKTCZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 21:25:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK2OiYm169531;
        Wed, 20 Nov 2019 02:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=G6s/zscyWj8h/m2pMQYpt10yiZ1ZtNfx047wBMtS7fs=;
 b=J8CX4S19nk9vTn8+LEmWm1JRy9LGGdQM/fSTysl6K+AMKx06sLE2Z0zFN9bm0UcU+qUq
 DFkfACwfLGqqY/MeQJYzhrK51p3U9JjqyJcvnyf1F0d4v4lwmUGkeh1tlemVg3VRB6wh
 JjkxmRyOQHBxRaAArlaTdcmXqH7KWI05A7CpmdEvWPp/VZdjdDDML/Nifyfus/jSUOGm
 mIVcbc5ZGO1/cWQiOKnDPEfdyDZGvKZV57odChCB4PQXT/TpuDs3CrwjW9TwPTKX1tvF
 IW7P0zpFCmauZVtCHzC86JIVOLky0tziyFgxrrR5lqw4rY8VU0oiPuc3XvgdduCKRFLq NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wa9rqjmty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 02:25:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAK2NxY0087921;
        Wed, 20 Nov 2019 02:25:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wc0ahe56c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 02:25:26 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAK2PIh5013857;
        Wed, 20 Nov 2019 02:25:19 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Nov 2019 18:25:18 -0800
Date:   Tue, 19 Nov 2019 18:25:18 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alexis Savery <asavery@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] loop: Better discard support for block devices
Message-ID: <20191120022518.GU6235@magnolia>
References: <20191114235008.185111-1-evgreen@chromium.org>
 <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114154903.v7.2.I4d476bddbf41a61422ad51502f4361e237d60ad4@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9446 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 03:50:08PM -0800, Evan Green wrote:
> If the backing device for a loop device is itself a block device,
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
> This change fixes blktest block/003, and removes an extraneous
> error print in block/013 when testing on a loop device backed
> by a block device that does not support discard.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> 
> Changes in v7:
> - Rebase on top of Darrick's patch
> - Tweak opening line of commit description (Darrick)
> 
> Changes in v6: None
> Changes in v5:
> - Don't mirror discard if lo_encrypt_key_size is non-zero (Gwendal)
> 
> Changes in v4:
> - Mirror blkdev's write_zeroes into loopdev's discard_sectors.
> 
> Changes in v3:
> - Updated commit description
> 
> Changes in v2: None
> 
>  drivers/block/loop.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6a9fe1f9fe84..e8f23e4b78f7 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -427,11 +427,12 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>  	 * information.
>  	 */
>  	struct file *file = lo->lo_backing_file;
> +	struct request_queue *q = lo->lo_queue;
>  	int ret;
>  
>  	mode |= FALLOC_FL_KEEP_SIZE;
>  
> -	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
> +	if (!blk_queue_discard(q)) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
> @@ -862,6 +863,21 @@ static void loop_config_discard(struct loop_device *lo)
>  	struct file *file = lo->lo_backing_file;
>  	struct inode *inode = file->f_mapping->host;
>  	struct request_queue *q = lo->lo_queue;
> +	struct request_queue *backingq;
> +
> +	/*
> +	 * If the backing device is a block device, mirror its zeroing
> +	 * capability. REQ_OP_DISCARD translates to a zero-out even when backed
> +	 * by block devices to keep consistent behavior with file-backed loop
> +	 * devices.
> +	 */
> +	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
> +		backingq = bdev_get_queue(inode->i_bdev);
> +		blk_queue_max_discard_sectors(q,
> +			backingq->limits.max_write_zeroes_sectors);

max_discard_sectors?

--D

> +
> +		blk_queue_max_write_zeroes_sectors(q,
> +			backingq->limits.max_write_zeroes_sectors);
>  
>  	/*
>  	 * We use punch hole to reclaim the free space used by the
> @@ -869,22 +885,24 @@ static void loop_config_discard(struct loop_device *lo)
>  	 * encryption is enabled, because it may give an attacker
>  	 * useful information.
>  	 */
> -	if ((!file->f_op->fallocate) ||
> -	    lo->lo_encrypt_key_size) {
> +	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>  		q->limits.discard_granularity = 0;
>  		q->limits.discard_alignment = 0;
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
> -		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
> -		return;
> -	}
>  
> -	q->limits.discard_granularity = inode->i_sb->s_blocksize;
> -	q->limits.discard_alignment = 0;
> +	} else {
> +		q->limits.discard_granularity = inode->i_sb->s_blocksize;
> +		q->limits.discard_alignment = 0;
>  
> -	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> -	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> -	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
> +		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
> +	}
> +
> +	if (q->limits.max_write_zeroes_sectors)
> +		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
>  }
>  
>  static void loop_unprepare_queue(struct loop_device *lo)
> -- 
> 2.21.0
> 
