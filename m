Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D29CDCBA77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 14:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbfJDMcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 08:32:07 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48532 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbfJDMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 08:32:07 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B2FD82E14F4;
        Fri,  4 Oct 2019 15:32:03 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TxAVv5XQSr-W3VuDMEm;
        Fri, 04 Oct 2019 15:32:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570192323; bh=+i0jOrrLfQPrDUuheuo6YLNQK4D8UGbkmlbpUExrIVo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=ikR5ETkxTe3SdJiX6aDCiOHtJs6PiHkBJcT7YQGhGZZGinlfS+v3drAb6EnMCdjjR
         aTuZo3S//Yy+rv+RCEE2p/bnwcRBukXtueRV/EJcHS64g4PzjlU/3+ewksOGCi+57x
         LBjFnNp/uMpQTKd7dYdpAncztx9m6NdSQNIdXEJA=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id d4v5Xzfe5F-W2IqedPq;
        Fri, 04 Oct 2019 15:32:03 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/swap: piggyback lru_add_drain_all() calls
To:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <157018386639.6110.3058050375244904201.stgit@buzz>
 <20191004121017.GG32665@bombadil.infradead.org>
 <20191004122727.GA10845@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <257f6172-971b-e0bd-0a74-30a0d143d6f9@yandex-team.ru>
Date:   Fri, 4 Oct 2019 15:32:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191004122727.GA10845@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/10/2019 15.27, Michal Hocko wrote:
> On Fri 04-10-19 05:10:17, Matthew Wilcox wrote:
>> On Fri, Oct 04, 2019 at 01:11:06PM +0300, Konstantin Khlebnikov wrote:
>>> This is very slow operation. There is no reason to do it again if somebody
>>> else already drained all per-cpu vectors after we waited for lock.
>>> +	seq = raw_read_seqcount_latch(&seqcount);
>>> +
>>>   	mutex_lock(&lock);
>>> +
>>> +	/* Piggyback on drain done by somebody else. */
>>> +	if (__read_seqcount_retry(&seqcount, seq))
>>> +		goto done;
>>> +
>>> +	raw_write_seqcount_latch(&seqcount);
>>> +
>>
>> Do we really need the seqcount to do this?  Wouldn't a mutex_trylock()
>> have the same effect?
> 
> Yeah, this makes sense. From correctness point of view it should be ok
> because no caller can expect that per-cpu pvecs are empty on return.
> This might have some runtime effects that some paths might retry more -
> e.g. offlining path drains pcp pvces before migrating the range away, if
> there are pages still waiting for a worker to drain them then the
> migration would fail and we would retry. But this not a correctness
> issue.
> 

Caller might expect that pages added by him before are drained.
Exiting after mutex_trylock() will not guarantee that.

For example POSIX_FADV_DONTNEED uses that.
