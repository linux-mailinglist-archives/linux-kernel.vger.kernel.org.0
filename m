Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE94FAC3DA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 03:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406351AbfIGBXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 21:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405727AbfIGBXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 21:23:16 -0400
Received: from [192.168.0.103] (unknown [58.212.132.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1A52082C;
        Sat,  7 Sep 2019 01:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567819395;
        bh=G2qrEEZDP+ylIjE+oHbp2sIifoKcC+Sj0d+XOwYiqKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=d6Gi2iA2x7J2Xs5Qvy6fyPxLqpV0zG5uknZNOqx3ssG/vbfn8yYmzRKPKAcZC2F8p
         eFwYwhfpIGHdk2bTKSVnsEiEFwDeFHvBRuaailkso8jduBq2L0OrHQUAx3sTXz4SlE
         8vKf9lI1XrWiG8+ZEouRbqaYyTE0g48NHadZunXk=
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized field of inode
 page in is_alive()
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190906105426.109151-1-yuchao0@huawei.com>
 <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <080e8dee-4726-8294-622a-cac26e781083@kernel.org>
Date:   Sat, 7 Sep 2019 09:23:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190906234808.GC71848@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-9-7 7:48, Jaegeuk Kim wrote:
> On 09/06, Chao Yu wrote:
>> If inode is newly created, inode page may not synchronize with inode cache,
>> so fields like .i_inline or .i_extra_isize could be wrong, in below call
>> path, we may access such wrong fields, result in failing to migrate valid
>> target block.
> 
> If data is valid, how can we get new inode page?

is_alive()
{
...
	node_page = f2fs_get_node_page(sbi, nid);  <--- inode page

	source_blkaddr = datablock_addr(NULL, node_page, ofs_in_node);
...
}

datablock_addr()
{
...
	base = offset_in_addr(&raw_node->i);  <--- the base could be wrong here due to
accessing uninitialized .i_inline of raw_node->i.
...
}

Thanks,

> 
>>
>> - gc_data_segment
>>  - is_alive
>>   - datablock_addr
>>    - offset_in_addr
>>
>> Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/dir.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 765f13354d3f..b1840852967e 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -479,6 +479,9 @@ struct page *f2fs_init_inode_metadata(struct inode *inode, struct inode *dir,
>>  		if (IS_ERR(page))
>>  			return page;
>>  
>> +		/* synchronize inode page's data from inode cache */
>> +		f2fs_update_inode(inode, page);
>> +
>>  		if (S_ISDIR(inode->i_mode)) {
>>  			/* in order to handle error case */
>>  			get_page(page);
>> -- 
>> 2.18.0.rc1
