Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7AD3CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfJKJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 05:57:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfJKJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6930582A498;
        Fri, 11 Oct 2019 09:57:30 +0000 (UTC)
Received: from [10.36.118.168] (unknown [10.36.118.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4191A5D9C3;
        Fri, 11 Oct 2019 09:57:29 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: fix a crash after memory offline
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "mhocko@suse.com" <mhocko@suse.com>
References: <1570732366-16426-1-git-send-email-cai@lca.pw>
 <2e36a929-0fc7-d32a-d838-de746ff071fc@redhat.com>
 <1570734720.5937.32.camel@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <dbf95ea6-fe44-41c5-7f5a-a780e5ff42ba@redhat.com>
Date:   Fri, 11 Oct 2019 11:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1570734720.5937.32.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 11 Oct 2019 09:57:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.19 21:12, Qian Cai wrote:
> On Thu, 2019-10-10 at 20:55 +0200, David Hildenbrand wrote:
>> On 10.10.19 20:32, Qian Cai wrote:
>>> The linux-next series "mm/memory_hotplug: Shrink zones before removing
>>> memory" [1] seems make a crash easier to reproduce while reading
>>> /proc/pagetypeinfo after offlining a memory section. Fix it by using
>>> pfn_to_online_page() in the PFN walker.
>>
>> Can you please rephrase the subject+description to describe the actual
>> problem and drop the reference to the series?
> 
> I'd figure it is better for you to post this as you are on the top of this whole
> mess. What do you think?

You mean, I found the key to an unlimited amount of undetected BUGs, so 
I should fix them? ;)

In case you don't have time to explore all the dirty details, I can take 
it from here. Just let me know.

-- 

Thanks,

David / dhildenb
