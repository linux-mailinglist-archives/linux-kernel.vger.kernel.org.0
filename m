Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C992F1AF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 05:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfEMDkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 May 2019 23:40:06 -0400
Received: from mail.windriver.com ([147.11.1.11]:41009 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEMDkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:40:06 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x4D3doEo017640
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 12 May 2019 20:39:51 -0700 (PDT)
Received: from [128.224.162.183] (128.224.162.183) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 12 May
 2019 20:39:50 -0700
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <jason.wessel@windriver.com>, <prarit@redhat.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
 <20190508081640.tvtnazr4tf5jijh7@holly.lan>
 <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
 <20190512090003.de52davu55rrg7kn@wychelm.lan>
From:   Wenlin Kang <wenlin.kang@windriver.com>
Message-ID: <0c5121f7-645c-3651-cccc-2ae836d415b6@windriver.com>
Date:   Mon, 13 May 2019 11:39:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190512090003.de52davu55rrg7kn@wychelm.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.183]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/19 5:00 PM, Daniel Thompson wrote:
> On Thu, May 09, 2019 at 10:56:03AM +0800, Wenlin Kang wrote:
>> On 5/8/19 4:16 PM, Daniel Thompson wrote:
>>> On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
>>>> The strncpy() function may leave the destination string buffer
>>>> unterminated, better use strlcpy() instead.
>>>>
>>>> This fixes the following warning with gcc 8.2:
>>>>
>>>> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
>>>> kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
>>>>      strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
>>>> ---
>>>>    kernel/debug/kdb/kdb_io.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
>>>> index 6a4b414..7fd4513 100644
>>>> --- a/kernel/debug/kdb/kdb_io.c
>>>> +++ b/kernel/debug/kdb/kdb_io.c
>>>> @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>>>    char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>>>>    {
>>>>    	if (prompt && kdb_prompt_str != prompt)
>>>> -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>>>> +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>>> Shouldn't that be strscpy?
>>
>> Hi Daniel
>>
>> I thought about strscpy, but I think strlcpy is better, because it only copy
>> the real number of characters if src string less than that size.
> Sorry, I'm confused by this. What behavior does strscpy() have that you
> consider undesirable in this case?


Hi Daniel

I checked strscpy() again, and think either is fine to me, if you think 
strscpy() is better, I can change it to this, and send v2, thanks for 
your review.


>
> Daniel.
>

-- 
Thanks,
Wenlin Kang

