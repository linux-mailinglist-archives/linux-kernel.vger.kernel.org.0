Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1213B16B9D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 07:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgBYGgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 01:36:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:39448 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYGgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:36:41 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6TpY-0004kw-3P; Tue, 25 Feb 2020 09:36:32 +0300
Subject: Re: [PATCH 2/7] gcov_seq_next should increase position index
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <f65c6ee7-bd00-f910-2f8a-37cc67e4ff88@virtuozzo.com>
 <44b8bbff-0ade-d390-e2df-7a66d6c3f19c@linux.ibm.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <eda4c5d3-81fe-3970-9fc5-f9bc7b1c5bd8@virtuozzo.com>
Date:   Tue, 25 Feb 2020 09:36:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <44b8bbff-0ade-d390-e2df-7a66d6c3f19c@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,
Could you please pick up this patch too?

On 1/30/20 4:09 PM, Peter Oberparleiter wrote:
> On 24.01.2020 08:02, Vasily Averin wrote:
>> if seq_file .next fuction does not change position index,
>> read after some lseek can generate unexpected output.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> 
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> 
>> ---
>>  kernel/gcov/fs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
>> index e5eb5ea..cc4ee48 100644
>> --- a/kernel/gcov/fs.c
>> +++ b/kernel/gcov/fs.c
>> @@ -108,9 +108,9 @@ static void *gcov_seq_next(struct seq_file *seq, void *data, loff_t *pos)
>>  {
>>  	struct gcov_iterator *iter = data;
>>  
>> +	(*pos)++;
>>  	if (gcov_iter_next(iter))
>>  		return NULL;
>> -	(*pos)++;
>>  
>>  	return iter;
>>  }
>>
> 
> 
