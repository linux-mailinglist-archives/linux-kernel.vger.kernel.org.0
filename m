Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23218ED8E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Mar 2020 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Mar 2020 21:07:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbgCWBHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:07:22 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F765C28ED1691C6004D;
        Mon, 23 Mar 2020 09:07:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 23 Mar
 2020 09:07:04 +0800
Subject: Re: [PATCH v2] f2fs: fix potential .flags overflow on 32bit
 architecture
To:     Joe Perches <joe@perches.com>, Chao Yu <chao@kernel.org>,
        <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20200322135614.10413-1-chao@kernel.org>
 <d88cce8ff37f336087899226668abcbcacd96baa.camel@perches.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c5b8115e-509d-9ace-ed4d-87bc2484d834@huawei.com>
Date:   Mon, 23 Mar 2020 09:07:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d88cce8ff37f336087899226668abcbcacd96baa.camel@perches.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/22 22:56, Joe Perches wrote:
> On Sun, 2020-03-22 at 21:56 +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
>> in 32bit architecture, since we introduced FI_MMAP_FILE flag
>> when we support data compression, we may access memory cross
>> the border of .flags field, corrupting .i_sem field, result in
>> below deadlock.
>>
>> To fix this issue, let's expand .flags as an array to grab enough
>> space to store new flags.
> []
>> +static inline void __set_inode_flag(struct inode *inode, int flag)
>> +{
>> +	if (!test_bit(flag % BITS_PER_LONG,
>> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]))
>> +		set_bit(flag % BITS_PER_LONG,
>> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
>> +}
> 
> I believe you don't need to do anything like this
> but just let test_bit and set_bit do the indexing.
> 
> 	if (!test_bit(flg, F2FS_I(inode->flags)))
> 		set_bit(flag, F2FS_I(inode->flags));
> 
> And there already is a function called test_and_set_bit()

Yup, I've cleaned up with test_and_{set,clear}_bit(), thanks for your
reminder.

Thanks,

> 
> 
> .
> 
