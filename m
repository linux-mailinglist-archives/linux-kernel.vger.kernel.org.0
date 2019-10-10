Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B674D21FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 09:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbfJJHlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 03:41:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732882AbfJJHlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:41:15 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4C19D4DFAB656DEBD2AC;
        Thu, 10 Oct 2019 15:41:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 10 Oct
 2019 15:41:01 +0800
Subject: Re: [PATCH for-next 4/5] erofs: clean up decompress queue stuffs
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Li Guifu" <bluce.liguifu@huawei.com>
References: <20191008125616.183715-1-gaoxiang25@huawei.com>
 <20191008125616.183715-4-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <387d99a6-6140-5804-4a8b-13e2aa64e5f9@huawei.com>
Date:   Thu, 10 Oct 2019 15:41:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008125616.183715-4-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/8 20:56, Gao Xiang wrote:
> Previously, both z_erofs_unzip_io and z_erofs_unzip_io_sb
> record decompress queues for backend to use.
> 
> The only difference is that z_erofs_unzip_io is used for
> on-stack sync decompression so that it doesn't have a super
> block field (since the caller can pass it in its context),
> but it increases complexity with only a pointer saving.
> 
> Rename z_erofs_unzip_io to z_erofs_decompressqueue with
> a fixed super_block member and kill the other entirely,
> and it can fallback to sync decompression if memory
> allocation failure.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
