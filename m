Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8234E57DE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2019 03:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJZBkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 21:40:10 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfJZBkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:40:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C28C73ADE1FA7A9539E2;
        Sat, 26 Oct 2019 09:40:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 26 Oct
 2019 09:40:03 +0800
Subject: Re: [PATCH 1/2] f2fs: delete duplicate information on sysfs nodes
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Hridya Valsaraju <hridya@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kernel-team@android.com>
References: <20191023214821.107615-1-hridya@google.com>
 <edc52873-b40d-5047-dba0-d693548eb16d@huawei.com>
 <20191025182325.GC24183@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6d09b590-053f-98ad-e628-2c352d989f01@huawei.com>
Date:   Sat, 26 Oct 2019 09:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191025182325.GC24183@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/26 2:23, Jaegeuk Kim wrote:
> On 10/24, Chao Yu wrote:
>> On 2019/10/24 5:48, Hridya Valsaraju wrote:
>>> This patch merges the sysfs node documentation present in
>>> Documentation/filesystems/f2fs.txt and
>>> Documentation/ABI/testing/sysfs-fs-f2fs
>>> and deletes the duplicate information from
>>> Documentation/filesystems/f2fs.txt. This is to prevent having to update
>>> both files when a new sysfs node is added for f2fs.
>>> The patch also makes minor formatting changes to
>>> Documentation/ABI/testing/sysfs-fs-f2fs.
>>
>> Jaegeuk, any particular reason to add duplicated description on f2fs.txt previously?
> 
> Not at all, thus, I asked Hridya to consolidate them. :P

Alright...

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
> .
> 
