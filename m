Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 909F97FC13
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392371AbfHBOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbfHBOYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:24:04 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA07F20679;
        Fri,  2 Aug 2019 14:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564755843;
        bh=TgNcbo6TXcLbjq5+6OYqRgo/Qoe3xOKUkbU920IR4iE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QdJbHI4QqAf5coM6w57j/GQ9wNbAmk57r70Ay5RmCr8gUGhWlTy5PBEM5C4Q9zS5b
         BYxLuLKi1vFk7ymoVG9ICyvdZuUyI3H3IT5y+uj/bvDjvExZo9yOtoEANv0ymSdKIS
         3Ev9S/1AokA1xrp+CoDJCxpYvVX/4paPncNoZs1k=
Subject: Re: [PATCH] mailmap: add entry for Jaegeuk Kim
To:     Jonathan Corbet <corbet@lwn.net>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaegeuk@kernel.org
References: <20190802012135.31419-1-yuchao0@huawei.com>
 <20190802072626.405246e3@lwn.net>
From:   Chao Yu <chao@kernel.org>
Message-ID: <fe9cd2bc-76ed-5371-e0c3-b538e7a805e7@kernel.org>
Date:   Fri, 2 Aug 2019 22:23:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190802072626.405246e3@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-8-2 21:26, Jonathan Corbet wrote:
> On Fri, 2 Aug 2019 09:21:35 +0800
> Chao Yu <yuchao0@huawei.com> wrote:
> 
>> Add entry to connect all Jaegeuk's email addresses.
>>
>> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  .mailmap | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 477debe3d960..70d41c86e644 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -89,6 +89,9 @@ Henrik Kretzschmar <henne@nachtwindheim.de>
>>  Henrik Rydberg <rydberg@bitmath.org>
>>  Herbert Xu <herbert@gondor.apana.org.au>
>>  Jacob Shin <Jacob.Shin@amd.com>
>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
>> +Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
> 
> So as I understand it, the mailmap file is there mostly to ensure that a
> person's changesets are properly collected in 'git shortlog' and such.  As
> documented on the man page, it is used when a person's name is spelled
> differently at different times.
> 
> That doesn't appear to be the case here, and shortlog output is correct
> already.  Given that, do we *really* need to maintain a collection of old
> email addresses in the mailmap file?  What is the benefit of that?

IMO, when we use git-blame to find out who is response for specified code, w/o
mailmap we may just found old obsolete email address in the related commit; even
we can search full name for his/her new email address, how can we make sure they
are the same person... so anyway, it can help to find last valid/canonical email
address of someone.

Thanks,

> 
> Thanks,
> 
> jon
> 
