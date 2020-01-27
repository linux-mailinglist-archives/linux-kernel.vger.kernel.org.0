Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914AB14A180
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 11:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgA0KKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 05:10:01 -0500
Received: from relay.sw.ru ([185.231.240.75]:54034 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgA0KKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:10:00 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iw1KG-0000ID-Aj; Mon, 27 Jan 2020 13:09:00 +0300
Subject: Re: [PATCH v5 2/6] block: Pass op_flags into
 blk_queue_get_max_sectors()
To:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, song@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, Chaitanya.Kulkarni@wdc.com,
        darrick.wong@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157968992539.174869.7490844754165043549.stgit@localhost.localdomain>
 <157969068296.174869.13461609442947913096.stgit@localhost.localdomain>
 <8b77117b-1cc0-a379-2cdf-554a8060206c@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b0e1cd11-da05-3a84-9c64-14375f61515d@virtuozzo.com>
Date:   Mon, 27 Jan 2020 13:08:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8b77117b-1cc0-a379-2cdf-554a8060206c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.2020 05:37, Bob Liu wrote:
> On 1/22/20 6:58 PM, Kirill Tkhai wrote:
>> This preparation patch changes argument type, and now
>> the function takes full op_flags instead of just op code.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  block/blk-core.c       |    4 ++--
>>  include/linux/blkdev.h |    8 +++++---
>>  2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 50a5de025d5e..ac2634bcda1f 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1250,10 +1250,10 @@ EXPORT_SYMBOL(submit_bio);
>>  static int blk_cloned_rq_check_limits(struct request_queue *q,
>>  				      struct request *rq)
>>  {
>> -	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
>> +	if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, rq->cmd_flags)) {
>>  		printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
>>  			__func__, blk_rq_sectors(rq),
>> -			blk_queue_get_max_sectors(q, req_op(rq)));
>> +			blk_queue_get_max_sectors(q, rq->cmd_flags));
>>  		return -EIO;
>>  	}
>>  
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 0f1127d0b043..23a5850f35f6 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -989,8 +989,10 @@ static inline struct bio_vec req_bvec(struct request *rq)
>>  }
>>  
>>  static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
>> -						     int op)
>> +						     unsigned int op_flags)
>>  {
>> +	int op = op_flags & REQ_OP_MASK;
>> +
> 
> Nitpick. int op = req_op(rq);
> 
> Anyway, looks good to me.
> Reviewed-by: Bob Liu <bob.liu@oracle.com>

Thanks, Bob. I'll merge this nitpick and your "Reviewed-by" at next resend.
It will be after merge window is closed, and new patches are welcomed.

>>  	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
>>  		return min(q->limits.max_discard_sectors,
>>  			   UINT_MAX >> SECTOR_SHIFT);
>> @@ -1029,10 +1031,10 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
>>  	if (!q->limits.chunk_sectors ||
>>  	    req_op(rq) == REQ_OP_DISCARD ||
>>  	    req_op(rq) == REQ_OP_SECURE_ERASE)
>> -		return blk_queue_get_max_sectors(q, req_op(rq));
>> +		return blk_queue_get_max_sectors(q, rq->cmd_flags);
>>  
>>  	return min(blk_max_size_offset(q, offset),
>> -			blk_queue_get_max_sectors(q, req_op(rq)));
>> +			blk_queue_get_max_sectors(q, rq->cmd_flags));
>>  }
>>  
>>  static inline unsigned int blk_rq_count_bios(struct request *rq)
>>
>>
> 

