Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE17B8F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Mar 2020 04:04:28 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:43646 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgCFJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:04:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TroHhKw_1583485460;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TroHhKw_1583485460)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Mar 2020 17:04:21 +0800
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
To:     Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     aarcange@redhat.com, daniel.m.jordan@oracle.com,
        hannes@cmpxchg.org, hughd@google.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, kravetz@us.ibm.com, mhocko@kernel.org,
        mm-commits@vger.kernel.org, tj@kernel.org, vdavydov.dev@gmail.com,
        willy@infradead.org, yang.shi@linux.alibaba.com
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 17:04:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/6 上午11:32, Qian Cai 写道:
> 
>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>
>>
>> The patch titled
>>     Subject: mm/vmscan: remove unnecessary lruvec adding
>> has been removed from the -mm tree.  Its filename was
>>     mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>
>> This patch was dropped because it had testing failures
> Andrew, do you have more information about this failure? I hit a bug
> here under memory pressure and am wondering if this is related
> which might save me some time digging…
> 
> [ 4389.727184][ T6600] mem_cgroup_update_lru_size(00000000bb31aaed, 0, -7): lru_size -1

This bug seems failed due to a update_lru_size() missing or misplace, but
what's I changed on this patch seems unlike to cause this bug.

Anyway, Qian, could you do me a favor to remove this patch and try again?
Since I am trying ltp's oom01 case,
# i=0; while :; do echo $((i++)); oom01; sleep 5; done
It runs well in dozens times on my qemu and hardware machine, on akpm branch commit f2cbd107a99b,
which included my 6 patches.


Andrew,

What's the reproduce steps for this test failure?

Thanks a lot for everyone!
Alex
