Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1518143CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgAUMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 07:37:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:33024 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgAUMhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:37:42 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1itsm0-0007Qx-N2; Tue, 21 Jan 2020 15:36:48 +0300
Subject: Re: [PATCH v4 6/7] dm: Directly disable max_allocate_sectors for now
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, dm-devel@redhat.com, song@kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com
References: <157960325642.108120.13626623438131044304.stgit@localhost.localdomain>
 <157960337238.108120.18048939587162465175.stgit@localhost.localdomain>
 <20200121122458.GA9365@redhat.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f7e0fb38-a894-da33-c46b-e192ed907ee0@virtuozzo.com>
Date:   Tue, 21 Jan 2020 15:36:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121122458.GA9365@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.2020 15:24, Mike Snitzer wrote:
> On Tue, Jan 21 2020 at  5:42am -0500,
> Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> 
>> Since dm inherits limits from underlining block devices,
>> this patch directly disables max_allocate_sectors for dm
>> till full allocation support is implemented.
>>
>> This prevents high-level primitives (generic_make_request_checks(),
>> __blkdev_issue_write_zeroes(), ...) from sending REQ_ALLOCATE
>> requests.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  drivers/md/dm-table.c |    2 ++
>>  drivers/md/md.h       |    1 +
>>  2 files changed, 3 insertions(+)
> 
> You're mixing DM and MD changes in the same patch.
> 
> But I'm wondering if it might be best to set this default for stacking
> devices in blk_set_stacking_limits()?
> 
> And then it is up to each stacking driver to override as needed.

Hm. Sound like a good idea. This "lim->max_allocate_sectors = 0" in blk_set_stacking_limits()
should work for dm's dm_calculate_queue_limits(), since it calls blk_stack_limits(), which is:

	t->max_allocate_sectors = min(t->max_allocate_sectors,
				      b->max_allocate_sectors);

Could you please tell is this fix is also enough for md?

Kirill
