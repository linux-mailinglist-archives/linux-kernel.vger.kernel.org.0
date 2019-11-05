Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2EAEF3B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 03:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfKECtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 21:49:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727861AbfKECtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 21:49:49 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02C891ED94C3D443FDDB;
        Tue,  5 Nov 2019 10:49:48 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 5 Nov 2019
 10:49:44 +0800
Subject: Re: [PATCH 3/3] Revert "f2fs: use kvmalloc, if kmalloc is failed"
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191101095324.9902-1-yuchao0@huawei.com>
 <20191101095324.9902-3-yuchao0@huawei.com>
 <20191105000249.GA46956@jaegeuk-macbookpro.roam.corp.google.com>
 <40d0df3f-cc55-d31a-474b-76f57d96bd89@huawei.com>
 <20191105023835.GD692@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <00ade77c-5451-4953-0232-89342a029f33@huawei.com>
Date:   Tue, 5 Nov 2019 10:49:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191105023835.GD692@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/5 10:38, Eric Biggers wrote:
> On Tue, Nov 05, 2019 at 10:17:41AM +0800, Chao Yu wrote:
>> On 2019/11/5 8:02, Jaegeuk Kim wrote:
>>> On 11/01, Chao Yu wrote:
>>>> This reverts commit 5222595d093ebe80329d38d255d14316257afb3e.
>>>>
>>>> As discussed with Eric, as kvmalloc() will try kmalloc() first, so
>>>> when we need allocate large size memory, it'd better to use
>>>> f2fs_kvmalloc() directly rather than adding additional fallback
>>>> logic to call kvmalloc() after we failed in f2fs_kmalloc().
>>>>
>>>> In order to avoid allocation failure described in original commit,
>>>> I change to use f2fs_kvmalloc() for .free_nid_bitmap bitmap memory.
>>>
>>> Is there any problem in the previous flow?
>>
>> No existing problem, however, it's redundant to introduce fallback flow in
>> f2fs_kmalloc() like vmalloc() did, since we can call f2fs_vmalloc() directly in
>> places where we need large memory.
>>
>> Thanks,
>>
> 
> f2fs_kmalloc() also violated the naming convention used everywhere else in the
> kernel since it could return both kmalloc and vmalloc memory, not just kmalloc
> memory.  That's really error-prone since people would naturally assume it's safe
> to free the *_kmalloc()-ed memory with kfree().

Agreed.

Thanks,

> 
> - Eric
> .
> 
