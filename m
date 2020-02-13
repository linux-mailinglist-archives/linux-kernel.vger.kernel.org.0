Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C8915C9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBMSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 13:04:42 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54160 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgBMSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:04:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TpuO.bO_1581617079;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpuO.bO_1581617079)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Feb 2020 02:04:40 +0800
Subject: Re: [Question] Why PageReadahead is not migrated by migration code?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <7691ab12-2e84-2531-f27d-2fae9045576d@linux.alibaba.com>
 <20200213173348.GS7778@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <185ce762-f25d-a013-6daa-8c288f1ff791@linux.alibaba.com>
Date:   Thu, 13 Feb 2020 10:04:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200213173348.GS7778@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/20 9:33 AM, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 09:06:58AM -0800, Yang Shi wrote:
>> Recently we saw some PageReadahead related bugs, so I did a quick check
>> about the use of PageReadahead. I just found the state is *not* migrated by
>> migrate_page_states().
>>
>> Since migrate_page() won't migrate writeback page, so if PageReadahead is
>> set it should just mean PG_readahead rather than PG_reclaim. So, I didn't
>> think of why it is not migrated.
>>
>> I dig into the history a little bit, but the change in migration code is too
>> overwhelming. But, it looks PG_readahead was added after migration was
>> introduced. Is it just a simple omission?
> It's probably more that it just doesn't matter enough.  If the Readahead
> flag is missing on a page then the application will perform slightly worse
> for a few pages as it ramps its readahead back up again.  On the other
> hand, you just migrated its pages to a different NUMA node, so chances
> are there are bigger perofmrance problems happening at this moment anyway.
>
> I think we probably should migrate it, but I can understand why nobody's
> noticed it before.

Thanks. I tend to agree the slight performance loss might be hidden by 
other things.

