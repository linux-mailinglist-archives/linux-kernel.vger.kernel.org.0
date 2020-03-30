Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621371976BD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 10:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgC3IkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 04:40:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12145 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729399AbgC3IkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:40:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22950CB943F4500D454C;
        Mon, 30 Mar 2020 16:40:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 30 Mar
 2020 16:39:56 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: xattr.h: Make stub helpers inline
To:     YueHaibing <yuehaibing@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <qkrwngud825@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200328112736.28852-1-yuehaibing@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <aee7049c-0154-3280-79a4-8bdc8ef0acbf@huawei.com>
Date:   Mon, 30 Mar 2020 16:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200328112736.28852-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/28 19:27, YueHaibing wrote:
> Fix gcc warnings:
> 
> In file included from fs/f2fs/dir.c:15:0:
> fs/f2fs/xattr.h:157:13: warning: 'f2fs_destroy_xattr_caches' defined but not used [-Wunused-function]
>  static void f2fs_destroy_xattr_caches(struct f2fs_sb_info *sbi) { }
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
> fs/f2fs/xattr.h:156:12: warning: 'f2fs_init_xattr_caches' defined but not used [-Wunused-function]
>  static int f2fs_init_xattr_caches(struct f2fs_sb_info *sbi) { return 0; }
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: a999150f4fe3 ("f2fs: use kmem_cache pool during inline xattr lookups")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
