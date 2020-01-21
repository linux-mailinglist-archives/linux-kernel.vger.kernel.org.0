Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8926D1439C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 10:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAUJra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 04:47:30 -0500
Received: from relay.sw.ru ([185.231.240.75]:55060 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgAUJra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:47:30 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itq7p-0005tQ-B0; Tue, 21 Jan 2020 12:47:09 +0300
Subject: Re: [PATCH block v2 2/3] block: Add support for REQ_NOZERO flag
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157917805422.88675.6477661554332322975.stgit@localhost.localdomain>
 <157917816325.88675.16481772163916741596.stgit@localhost.localdomain>
 <yq14kwpibf6.fsf@oracle.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3791a7fa-ea0c-d8ea-4b41-c968454b3787@virtuozzo.com>
Date:   Tue, 21 Jan 2020 12:47:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <yq14kwpibf6.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 09:14, Martin K. Petersen wrote:
> 
> Kirill,
> 
>> +	if (flags & BLKDEV_ZERO_NOUNMAP)
>> +		req_flags |= REQ_NOUNMAP;
>> +	if (flags & BLKDEV_ZERO_ALLOCATE)
>> +		req_flags |= REQ_NOZERO|REQ_NOUNMAP;
> 
> I find there is some dissonance between using BLKDEV_ZERO_ALLOCATE to
> describe this operation in one case and REQ_NOZERO in the other.
> 
> I understand why not zeroing is important in your case. However, I think
> the allocation aspect is semantically more important. Also, in the case
> of SCSI, the allocated blocks will typically appear zeroed. So from that
> perspective REQ_NOZERO doesn't really make sense. I would really prefer
> to use REQ_ALLOCATE to describe this operation. I agree that "do not
> write every block" is important too. I just don't have a good suggestion
> for how to express that as an additional qualifier to REQ_ALLOCATE_?.

No problem, I'll rename the modifier.

> Also, adding to the confusion: In the context of SCSI, ANCHOR requires
> UNMAP. So my head hurts a bit when I read REQ_NOZERO|REQ_NOUNMAP and
> have to translate that into ANCHOR|UNMAP.
> 
> Longer term, I think we should consider introducing REQ_OP_SINGLE_RANGE
> or something like that as an umbrella operation that can be used to
> describe zeroing, allocating, and other things that operate on a single
> LBA range with no payload. Thus removing both the writiness and the
> zeroness from the existing REQ_OP_WRITE_ZEROES conduit.
> 
> Naming issues aside, your patch looks fine. I'll try to rebase my SCSI
> patches on top of your series to see how things fit.

Ok, thanks.
