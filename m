Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43117A358
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCEKqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 05:46:02 -0500
Received: from foss.arm.com ([217.140.110.172]:47014 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgCEKqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:46:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F47731B;
        Thu,  5 Mar 2020 02:46:01 -0800 (PST)
Received: from [192.168.1.161] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09CC03F6C4;
        Thu,  5 Mar 2020 02:45:59 -0800 (PST)
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
 <20200304165336.GO16139@dhcp22.suse.cz>
 <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
 <20200305100023.GR16139@dhcp22.suse.cz>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <acf13158-40a3-4027-f36a-25d24efe3242@arm.com>
Date:   Thu, 5 Mar 2020 10:46:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200305100023.GR16139@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 3/5/20 10:00 AM, Michal Hocko wrote:
> On Thu 05-03-20 09:49:23, Vincenzo Frascino wrote:
>> Hi Michal,
>>
>> On 3/4/20 4:53 PM, Michal Hocko wrote:
>>> On Wed 04-03-20 14:23:48, Vincenzo Frascino wrote:
>>>> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
>>>> configuration options are enabled. Having them disabled triggers the
>>>> following warning at compile time:
>>>>
>>>> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
>>>> but not used [-Wunused-function]
>>>>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
>>>>  int n)
>>>>
>>>> Make mem_cgroup_id_get_many() dependent on MMU and MEMCG_SWAP to address
>>>> the issue.
>>>
>>> A similar patch has been proposed recently
>>> http://lkml.kernel.org/r/87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com.
>>> The conclusion was that the warning is not really worth adding code.
>>>
>>
>> Thank you for pointing this out, I was not aware of it. I understand that you
>> are against "#ifdeffery" in this case, but isn't it the case of adding at least
>> __maybe_unused? This would prevent people from reporting it over and over again
>> and you to have to push them back :) Let me know what do you think, in case I am
>> happy to change my patch accordingly.
> 
> We have discussed __maybe_unused in the email thread as well. I am not a
> great fan of that as mentioed there.
> 

I am aware of this. I was just exploring if there was a possibility of
addressing the warning, since if we leave all the warnings in scenarios like
randconfig can cause confusion in between real and non real issues.
Is there anything we can do?

-- 
Regards,
Vincenzo
