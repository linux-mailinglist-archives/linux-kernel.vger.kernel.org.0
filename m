Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D151769E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 02:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCCBRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 20:17:31 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41784 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgCCBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:17:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TrVMJ8Z_1583198246;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TrVMJ8Z_1583198246)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Mar 2020 09:17:26 +0800
Subject: Re: [PATCH] ocfs2: Replace zero-length array with flexible-array
 member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20200213160244.GA6088@embeddedor>
 <1b78acd5-2b5f-55f1-5571-73f45d3c87f7@embeddedor.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <30493b5f-752d-147f-3d64-95b1c59895ae@linux.alibaba.com>
Date:   Tue, 3 Mar 2020 09:17:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1b78acd5-2b5f-55f1-5571-73f45d3c87f7@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late replay since I've missed the original mail.
This patch looks good to me.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

On 2020/3/3 07:57, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping: Who can take this?
> 
> Thanks
> --
> Gustavo
> 
> On 2/13/20 10:02, Gustavo A. R. Silva wrote:
>> The current codebase makes use of the zero-length array language
>> extension to the C90 standard, but the preferred mechanism to declare
>> variable-length types such as these ones is a flexible array member[1][2],
>> introduced in C99:
>>
>> struct foo {
>>         int stuff;
>>         struct boo array[];
>> };
>>
>> By making use of the mechanism above, we will get a compiler warning
>> in case the flexible array does not occur last in the structure, which
>> will help us prevent some kind of undefined behavior bugs from being
>> inadvertently introduced[3] to the codebase from now on.
>>
>> Also, notice that, dynamic memory allocations won't be affected by
>> this change:
>>
>> "Flexible array members have incomplete type, and so the sizeof operator
>> may not be applied. As a quirk of the original implementation of
>> zero-length arrays, sizeof evaluates to zero."[1]
>>
>> This issue was found with the help of Coccinelle.
>>
>> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
>> [2] https://github.com/KSPP/linux/issues/21
>> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  fs/ocfs2/journal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
>> index 68ba354cf361..b425f0b01dce 100644
>> --- a/fs/ocfs2/journal.c
>> +++ b/fs/ocfs2/journal.c
>> @@ -91,7 +91,7 @@ enum ocfs2_replay_state {
>>  struct ocfs2_replay_map {
>>  	unsigned int rm_slots;
>>  	enum ocfs2_replay_state rm_state;
>> -	unsigned char rm_replay_slots[0];
>> +	unsigned char rm_replay_slots[];
>>  };
>>  
>>  static void ocfs2_replay_map_set_state(struct ocfs2_super *osb, int state)
>>
