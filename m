Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007CF85A63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 08:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfHHGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 02:18:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbfHHGSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 02:18:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53A80D5E323807A7AC4A;
        Thu,  8 Aug 2019 14:18:01 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 8 Aug 2019
 14:17:53 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix build error while CONFIG_NLS=m
To:     YueHaibing <yuehaibing@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20190808020253.27276-1-yuehaibing@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4e1c457e-621f-e9bd-e625-3a9f27da2277@huawei.com>
Date:   Thu, 8 Aug 2019 14:18:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190808020253.27276-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haibing,

Thanks for the patch!

Out of curiosity, does Hulk Robot check linux-next git repo as well? This will
be more valuable if the bug can be found during development of related patch?

On 2019/8/8 10:02, YueHaibing wrote:
> If CONFIG_F2FS_FS=y but CONFIG_NLS=m, building fails:
> 
> fs/f2fs/file.o: In function `f2fs_ioctl':
> file.c:(.text+0xb86f): undefined reference to `utf16s_to_utf8s'
> file.c:(.text+0xe651): undefined reference to `utf8s_to_utf16s'
> 
> Select CONFIG_NLS to fix this.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
