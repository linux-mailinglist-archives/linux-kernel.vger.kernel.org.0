Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7432125A09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 04:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLSDjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 22:39:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbfLSDjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:39:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86F6FE7A4898DE8BFA25;
        Thu, 19 Dec 2019 11:38:58 +0800 (CST)
Received: from huawei.com (10.175.127.16) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Dec 2019
 11:38:50 +0800
From:   Pan Zhang <zhangpan26@huawei.com>
To:     <christian.koenig@amd.com>, <michel@daenzer.net>,
        <alexander.deucher@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <ray.huang@amd.com>,
        <irmoy.das@amd.com>, <sam@ravnborg.org>, <zhangpan26@huawei.com>,
        <hushiyuan@huawei.com>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 2/3] gpu: drm: dead code elimination
Date:   Thu, 19 Dec 2019 11:38:31 +0800
Message-ID: <1576726711-14394-1-git-send-email-zhangpan26@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <484b831b-671a-12f4-8259-1cb6b75e93e3@daenzer.net>
References: <484b831b-671a-12f4-8259-1cb6b75e93e3@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.127.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 5:52 p.m., Michel Dänzer <michel@daenzer.net> wrote:

>> this set adds support for removal of gpu drm dead code.
>> 
>> patch2:
>> `num_entries` is a data of unsigned type(compilers always treat as 
>> unsigned int) and SIZE_MAX == ~0,
>> 
>> so there is a impossible condition:
>> '(num_entries > ((~0) - 56) / 72) => (max(0-u32) > 256204778801521549)'.

>While this looks correct for 64-bit, where size_t is unsigned long, on 32-bit it's unsigned int, in which case this isn't dead code.

and

On 2019-12-18 5:52 p.m., Christian König <christian.koenig@xxxxxxx> wrote:

>NAK, that calculation is not correct on 32-bit systems.

>Christian.

Yes, you are right. I just figured this out (because our Server usually uses 64 bits).

thanks.


>>Signed-off-by: Pan Zhang <zhangpan26@xxxxxxxxxx>
>>---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>index 85b0515..10a7f30 100644
>>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
>>@@ -71,10 +71,6 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>> 	unsigned i;
>> 	int r;
>> 
>>-	if (num_entries > (SIZE_MAX - sizeof(struct amdgpu_bo_list))
>>-				/ sizeof(struct amdgpu_bo_list_entry))
>>-		return -EINVAL;
>>-
>> 	size = sizeof(struct amdgpu_bo_list);
>> 	size += num_entries * sizeof(struct amdgpu_bo_list_entry);
>> 	list = kvmalloc(size, GFP_KERNEL);
>>
