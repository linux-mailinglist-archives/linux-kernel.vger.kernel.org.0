Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE619BDAB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgDBIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 04:38:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728612AbgDBIiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:38:15 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 549B628F6AF62727C616;
        Thu,  2 Apr 2020 16:37:50 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 2 Apr 2020
 16:37:42 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'params'
To:     Jason Yan <yanaijie@huawei.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20200402061545.23208-1-yanaijie@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6170e88e-5242-30dd-f624-1171aaa994de@huawei.com>
Date:   Thu, 2 Apr 2020 16:37:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200402061545.23208-1-yanaijie@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2020/4/2 14:15, Jason Yan wrote:
> Fix the following gcc warning:
> 
> fs/f2fs/compress.c:375:18: warning: variable 'params' set but not used [-Wunused-but-set-variable]
>   ZSTD_parameters params;
>                   ^~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks for the patch, would you mind that just merge this fix into
original path which is still in f2fs private git tree?

Thanks,

> ---
>  fs/f2fs/compress.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index f05ecf4cb899..df7b2d15eacd 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -372,12 +372,10 @@ static int zstd_compress_pages(struct compress_ctx *cc)
>  
>  static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
>  {
> -	ZSTD_parameters params;
>  	ZSTD_DStream *stream;
>  	void *workspace;
>  	unsigned int workspace_size;
>  
> -	params = ZSTD_getParams(F2FS_ZSTD_DEFAULT_CLEVEL, dic->clen, 0);
>  	workspace_size = ZSTD_DStreamWorkspaceBound(MAX_COMPRESS_WINDOW_SIZE);
>  
>  	workspace = f2fs_kvmalloc(F2FS_I_SB(dic->inode),
> 
