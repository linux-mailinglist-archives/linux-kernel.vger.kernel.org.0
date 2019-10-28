Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C2E72C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389615AbfJ1NlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 09:41:21 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2498 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729328AbfJ1NlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 09:41:21 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 57AF6E9C1175435F54AB;
        Mon, 28 Oct 2019 21:41:19 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 21:41:18 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 28 Oct 2019 21:41:18 +0800
Date:   Mon, 28 Oct 2019 21:44:05 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>
CC:     Chao Yu <chao@kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Gao Xiang <xiang@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] erofs: support superblock checksum
Message-ID: <20191028134405.GA186556@architecture4>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
 <20191023084536.GA16289@architecture4>
 <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <df7d7427-e7ca-5135-5db2-640eda30d253@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Mon, Oct 28, 2019 at 08:36:00PM +0800, Chao Yu wrote:
> On 2019/10/23 16:45, Gao Xiang wrote:

<snip>

> > That is quite a good point. :-)
> > 
> > My first thought is to check the following payloads of sb (e.g, some per-fs
> > metadata should be checked at mount time together. or for small images, check
> > the whole image at the mount time) as well since if we introduce a new feature
> > to some kernel version, forward compatibility needs to be considered. So it's
> > better to make proper scalability, for this case, we have some choices:
> >  1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
> >     totally 256M.)
> >  2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
> >     at all, don't consider any latter scalability.
> 
> Xiang, sorry for later reply...
> 
> I prefer method 2), let's enable chksum feature only on superblock first,
> chksum_blocks feature can be added later.

Okay, got it. I will resend patch soon.

Thanks,
Gao Xiang

> 
> Thanks,
> 
> > 
> > Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
> > and hold up this feature for the next erofs-utils release, but I think we can
> > get it ready for v5.5 since it is not quite complex feature...
> > 
> > Thanks,
> > Gao Xiang
> > 
> > .
> > 
