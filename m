Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2A1428F7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 12:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATLMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 06:12:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:39632 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgATLMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:12:40 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itUy7-00008M-PD; Mon, 20 Jan 2020 14:11:43 +0300
Subject: Re: [PATCH block v2 1/3] block: Add @flags argument to
 bdev_write_zeroes_sectors()
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917815798.88675.11900718803129164489.stgit@localhost.localdomain>
 <a8c5c5fd-d6b1-950e-0493-b5020e5ca87d@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <85d0dcea-d151-18e9-cb7a-8b277d168bc7@virtuozzo.com>
Date:   Mon, 20 Jan 2020 14:11:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a8c5c5fd-d6b1-950e-0493-b5020e5ca87d@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.01.2020 04:46, Bob Liu wrote:
> On 1/16/20 8:35 PM, Kirill Tkhai wrote:
>> This is a preparation for next patch, which introduces
>> a new flag BLKDEV_ZERO_ALLOCATE for calls, which need
>> only allocation of blocks and don't need actual blocks
>> zeroing.
>>
>> CC: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  block/blk-lib.c                     |    6 +++---
>>  drivers/md/dm-kcopyd.c              |    2 +-
>>  drivers/target/target_core_iblock.c |    4 ++--
>>  include/linux/blkdev.h              |    3 ++-
>>  4 files changed, 8 insertions(+), 7 deletions(-)
>>
> 
> Looks good to me.
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Thanks, Bob.
 
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index 5f2c429d4378..3e38c93cfc53 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -224,7 +224,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
>>  		return -EPERM;
>>  
>>  	/* Ensure that max_write_zeroes_sectors doesn't overflow bi_size */
>> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev);
>> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bdev, 0);
>>  
>>  	if (max_write_zeroes_sectors == 0)
>>  		return -EOPNOTSUPP;
>> @@ -362,7 +362,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>  	sector_t bs_mask;
>>  	struct bio *bio;
>>  	struct blk_plug plug;
>> -	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev);
>> +	bool try_write_zeroes = !!bdev_write_zeroes_sectors(bdev, 0);
>>  
>>  	bs_mask = (bdev_logical_block_size(bdev) >> 9) - 1;
>>  	if ((sector | nr_sects) & bs_mask)
>> @@ -391,7 +391,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
>>  			try_write_zeroes = false;
>>  			goto retry;
>>  		}
>> -		if (!bdev_write_zeroes_sectors(bdev)) {
>> +		if (!bdev_write_zeroes_sectors(bdev, 0)) {
>>  			/*
>>  			 * Zeroing offload support was indicated, but the
>>  			 * device reported ILLEGAL REQUEST (for some devices
>> diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
>> index 1bbe4a34ef4c..f1b8e7926dd4 100644
>> --- a/drivers/md/dm-kcopyd.c
>> +++ b/drivers/md/dm-kcopyd.c
>> @@ -831,7 +831,7 @@ void dm_kcopyd_copy(struct dm_kcopyd_client *kc, struct dm_io_region *from,
>>  		 */
>>  		job->rw = REQ_OP_WRITE_ZEROES;
>>  		for (i = 0; i < job->num_dests; i++)
>> -			if (!bdev_write_zeroes_sectors(job->dests[i].bdev)) {
>> +			if (!bdev_write_zeroes_sectors(job->dests[i].bdev, 0)) {
>>  				job->rw = WRITE;
>>  				break;
>>  			}
>> diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
>> index 51ffd5c002de..73a63e197bf5 100644
>> --- a/drivers/target/target_core_iblock.c
>> +++ b/drivers/target/target_core_iblock.c
>> @@ -117,7 +117,7 @@ static int iblock_configure_device(struct se_device *dev)
>>  	 * Enable write same emulation for IBLOCK and use 0xFFFF as
>>  	 * the smaller WRITE_SAME(10) only has a two-byte block count.
>>  	 */
>> -	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bd);
>> +	max_write_zeroes_sectors = bdev_write_zeroes_sectors(bd, 0);
>>  	if (max_write_zeroes_sectors)
>>  		dev->dev_attrib.max_write_same_len = max_write_zeroes_sectors;
>>  	else
>> @@ -468,7 +468,7 @@ iblock_execute_write_same(struct se_cmd *cmd)
>>  		return TCM_INVALID_CDB_FIELD;
>>  	}
>>  
>> -	if (bdev_write_zeroes_sectors(bdev)) {
>> +	if (bdev_write_zeroes_sectors(bdev, 0)) {
>>  		if (!iblock_execute_zero_out(bdev, cmd))
>>  			return 0;
>>  	}
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index c45779f00cbd..4cd69552df9a 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -1418,7 +1418,8 @@ static inline unsigned int bdev_write_same(struct block_device *bdev)
>>  	return 0;
>>  }
>>  
>> -static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
>> +static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev,
>> +						     unsigned int flags)
>>  {
>>  	struct request_queue *q = bdev_get_queue(bdev);
>>  
>>
>>
> 

