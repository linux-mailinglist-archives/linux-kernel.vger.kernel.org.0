Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 956AC183EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2019 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEIC4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 22:56:23 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62113 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfEIC4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 22:56:23 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x492u8Vk004135
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 8 May 2019 19:56:08 -0700 (PDT)
Received: from [128.224.162.183] (128.224.162.183) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 May
 2019 19:56:07 -0700
Subject: Re: [PATCH] kdb: Fix bound check compiler warning
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <jason.wessel@windriver.com>, <prarit@redhat.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
 <20190508081640.tvtnazr4tf5jijh7@holly.lan>
From:   Wenlin Kang <wenlin.kang@windriver.com>
Message-ID: <ac8af42c-e69d-6fd0-1d76-73a37e8a672c@windriver.com>
Date:   Thu, 9 May 2019 10:56:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190508081640.tvtnazr4tf5jijh7@holly.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.183]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/19 4:16 PM, Daniel Thompson wrote:
> On Wed, May 08, 2019 at 09:52:39AM +0800, Wenlin Kang wrote:
>> The strncpy() function may leave the destination string buffer
>> unterminated, better use strlcpy() instead.
>>
>> This fixes the following warning with gcc 8.2:
>>
>> kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
>> kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
>>     strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
>> ---
>>   kernel/debug/kdb/kdb_io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
>> index 6a4b414..7fd4513 100644
>> --- a/kernel/debug/kdb/kdb_io.c
>> +++ b/kernel/debug/kdb/kdb_io.c
>> @@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
>>   char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
>>   {
>>   	if (prompt && kdb_prompt_str != prompt)
>> -		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
>> +		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
> Shouldn't that be strscpy?


Hi Daniel

I thought about strscpy, but I think strlcpy is better, because it only 
copy the real number of characters if src string less than that size.


>
>
> Daniel.
>
>>   	kdb_printf(kdb_prompt_str);
>>   	kdb_nextline = 1;	/* Prompt and input resets line number */
>>   	return kdb_read(buffer, bufsize);
>> -- 
>> 1.9.1
>>

-- 
Thanks,
Wenlin Kang

