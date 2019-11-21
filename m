Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7581047E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 02:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKUBMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 20:12:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7151 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfKUBMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:12:51 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BA7B8717D83CA5655174;
        Thu, 21 Nov 2019 09:12:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 21 Nov
 2019 09:12:41 +0800
Subject: Re: [PATCH v2] erofs: drop all vle annotations for runtime names
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <chao@kernel.org>,
        <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, Gao Xiang <xiang@kernel.org>
References: <20191108032526.40762-1-gaoxiang25@huawei.com>
 <20191108033733.63919-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c12e9c9d-74ed-2beb-4e07-f9fdd731d00f@huawei.com>
Date:   Thu, 21 Nov 2019 09:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191108033733.63919-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/8 11:37, Gao Xiang wrote:
> VLE was an old informal name of fixed-sized output
> compression came from released ATC'19 paper [1].
> 
> Drop those old annotations since erofs can handle
> all encoded clusters in block-aligned basis, which
> is wider than fixed-sized output compression after
> larger clustersize feature is fully implemented.
> 
> Unaligned encoded data won't be considered in EROFS
> since it's not friendly to inplace I/O and decompression
> inplace.
> 
> a) Fixed-sized output compression with 16KB pcluster:
>   ___________________________________
>  |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|
>  |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks
> 
> b) Block-aligned fixed-sized input compression with
>    16KB pcluster:
>   ___________________________________
>  |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxx00000|
>  |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks
> 
> c) Block-unaligned fixed-sized input compression with
>    16KB compression unit:
>   ____________________________________________
>  |..xxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|x.......|
>  |___ 0___|___ 1___|___ 2___|___ 3___|___ 4___| physical blocks
> 
> Refine better names for those as well.
> 
> [1] https://www.usenix.org/conference/atc19/presentation/gao
> 
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
