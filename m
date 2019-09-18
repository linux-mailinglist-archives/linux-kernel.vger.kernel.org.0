Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC6AB5EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfIRIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 04:17:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbfIRIRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:17:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03AD030A76A9;
        Wed, 18 Sep 2019 08:17:14 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C9925C21A;
        Wed, 18 Sep 2019 08:17:11 +0000 (UTC)
Subject: Re: [RFC PATCH] memalloc_noio: update the comment to make it cleaner
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20190917232820.23504-1-xiubli@redhat.com>
 <20190918072542.GC12770@dhcp22.suse.cz>
 <315246db-ec28-f5e0-e9b3-eba0cb60b796@redhat.com>
 <20190918081431.GD12770@dhcp22.suse.cz>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <e49636bd-11d2-b90c-d1b2-3afd89de43d2@redhat.com>
Date:   Wed, 18 Sep 2019 16:17:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918081431.GD12770@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 18 Sep 2019 08:17:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/18 16:14, Michal Hocko wrote:
> On Wed 18-09-19 16:02:52, Xiubo Li wrote:
>> On 2019/9/18 15:25, Michal Hocko wrote:
>>> On Wed 18-09-19 04:58:20, xiubli@redhat.com wrote:
>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> The GFP_NOIO means all further allocations will implicitly drop
>>>> both __GFP_IO and __GFP_FS flags and so they are safe for both the
>>>> IO critical section and the the critical section from the allocation
>>>> recursion point of view. Not only the __GFP_IO, which a bit confusing
>>>> when reading the code or using the save/restore pair.
>>> Historically GFP_NOIO has always implied GFP_NOFS as well. I can imagine
>>> that this might come as an surprise for somebody not familiar with the
>>> code though.
>> Yeah, it true.
>>
>>>    I am wondering whether your update of the documentation
>>> would be better off at __GFP_FS, __GFP_IO resp. GFP_NOFS, GFP_NOIO level.
>>> This interface is simply a way to set a scoped NO{IO,FS} context.
>> The "Documentation/core-api/gfp_mask-from-fs-io.rst" is already very detail
>> about them all.
>>
>> This fixing just means to make sure that it won't surprise someone who is
>> having a quickly through some code and not familiar much about the detail.
>> It may make not much sense ?
> Ohh, I do not think this would be senseless. I just think that the NOIO
> implying NOFS as well should be described at the level where they are
> documented rather than the api you have chosen.

Hmm, yeah totally agree :-)

Thanks
BRs
