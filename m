Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0195743C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfGYDPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 23:15:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388449AbfGYDPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 23:15:09 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CFDA1E13BD828B343EFF;
        Thu, 25 Jul 2019 11:15:07 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 11:15:02 +0800
Subject: Re: [PATCH v2] f2fs: use EINVAL for superblock with invalid magic
To:     Icenowy Zheng <icenowy@aosc.io>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20190725030852.33161-1-icenowy@aosc.io>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <07060e23-bc6f-5d35-a7f3-e75c8ebb3b65@huawei.com>
Date:   Thu, 25 Jul 2019 11:15:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190725030852.33161-1-icenowy@aosc.io>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/7/25 11:08, Icenowy Zheng wrote:
> The kernel mount_block_root() function expects -EACESS or -EINVAL for a
> unmountable filesystem when trying to mount the root with different
> filesystem types.
> 
> However, in 5.3-rc1 the behavior when F2FS code cannot find valid block
> changed to return -EFSCORRUPTED(-EUCLEAN), and this error code makes
> mount_block_root() fail when trying to probe F2FS.
> 
> When the magic number of the superblock mismatches, it has a high
> probability that it's just not a F2FS. In this case return -EINVAL seems
> to be a better result, and this return value can make mount_block_root()
> probing work again.
> 
> Return -EINVAL when the superblock has magic mismatch, -EFSCORRUPTED in
> other cases (the magic matches but the superblock cannot be recognized).
> 
> Fixes: 10f966bbf521 ("f2fs: use generic EFSBADCRC/EFSCORRUPTED")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
