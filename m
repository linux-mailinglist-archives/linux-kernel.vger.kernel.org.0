Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2535D2CB13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE1QHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 12:07:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:38226 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfE1QHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:07:45 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hVedY-0005la-Dm; Tue, 28 May 2019 19:07:40 +0300
Subject: Re: [PATCH REBASED 1/4] mm: Move recent_rotated pages calculation to
 shrink_inactive_list()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     akpm@linux-foundation.org, daniel.m.jordan@oracle.com,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <155290113594.31489.16711525148390601318.stgit@localhost.localdomain>
 <155290127956.31489.3393586616054413298.stgit@localhost.localdomain>
 <20190528155134.GA14663@cmpxchg.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3c081218-0dc9-54f2-839e-00adca089831@virtuozzo.com>
Date:   Tue, 28 May 2019 19:07:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528155134.GA14663@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.2019 18:51, Johannes Weiner wrote:
> On Mon, Mar 18, 2019 at 12:27:59PM +0300, Kirill Tkhai wrote:
>> @@ -1945,6 +1942,8 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>>  		count_memcg_events(lruvec_memcg(lruvec), PGSTEAL_DIRECT,
>>  				   nr_reclaimed);
>>  	}
>> +	reclaim_stat->recent_rotated[0] = stat.nr_activate[0];
>> +	reclaim_stat->recent_rotated[1] = stat.nr_activate[1];
> 
> Surely this should be +=, right?
> 
> Otherwise we maintain essentially no history of page rotations and
> that wreaks havoc on the page cache vs. swapping reclaim balance.

Sure, thanks.

Kirill
