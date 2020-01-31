Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334F714F020
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 16:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgAaPtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 10:49:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:54252 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgAaPtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 10:49:42 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ixYXt-0002sK-0i; Fri, 31 Jan 2020 18:49:25 +0300
Subject: Re: [PATCH v2] mm: Allocate shrinker_map on appropriate NUMA node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
Date:   Fri, 31 Jan 2020 18:49:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131154735.GA4520@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.01.2020 18:47, Michal Hocko wrote:
> On Fri 31-01-20 18:00:51, Kirill Tkhai wrote:
> [...]
>> @@ -333,8 +333,9 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>>  		/* Not yet online memcg */
>>  		if (!old)
>>  			return 0;
>> -
>> -		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
>> +		/* See comment in alloc_mem_cgroup_per_node_info()*/
>> +		tmp = node_state(nid, N_NORMAL_MEMORY) ? nid : NUMA_NO_NODE;
>> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, tmp);
>>  		if (!new)
>>  			return -ENOMEM;
> 
> I do not think this is a good pattern to copy. Why cannot you simply use
> kvmalloc_node with the given node? The allocator should fallback to the
> closest node if the given one doesn't have any memory.

Hm, why isn't the same scheme used in alloc_mem_cgroup_per_node_info() then?

Kirill
