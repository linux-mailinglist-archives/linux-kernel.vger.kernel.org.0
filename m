Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB5822B68
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 07:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfETFtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 01:49:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41128 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbfETFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 01:49:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5DB5671AB52C5D36C19;
        Mon, 20 May 2019 13:49:41 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 13:49:38 +0800
Subject: Re: [PATCH] intel_th: msu: Fix unused variable warning on arm64
 platform
To:     <linux-kernel@vger.kernel.org>
References: <1558322600-63308-1-git-send-email-zhangshaokun@hisilicon.com>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <500b89b0-3d85-b1ab-4c13-abca31d184bd@hisilicon.com>
Date:   Mon, 20 May 2019 13:49:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1558322600-63308-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore this patch, I will update it and resend it.

On 2019/5/20 11:23, Shaokun Zhang wrote:
> Fix this compiler warning on arm64 platform.
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/hwtracing/intel_th/msu.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
> index 81bb54fa3ce8..e15ed5c308e1 100644
> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -780,7 +780,7 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
>  static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
>  {
>  	struct msc_window *win;
> -	int ret = -ENOMEM, i;
> +	int ret = -ENOMEM;
>  
>  	if (!nr_blocks)
>  		return 0;
> @@ -812,7 +812,7 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
>  		goto err_nomem;
>  
>  #ifdef CONFIG_X86
> -	for (i = 0; i < ret; i++)
> +	for (int i = 0; i < ret; i++)
>  		/* Set the page as uncached */
>  		set_memory_uc((unsigned long)msc_win_block(win, i), 1);
>  #endif
> @@ -860,8 +860,6 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
>   */
>  static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
>  {
> -	int i;
> -
>  	msc->nr_pages -= win->nr_blocks;
>  
>  	list_del(&win->entry);
> @@ -871,7 +869,7 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
>  	}
>  
>  #ifdef CONFIG_X86
> -	for (i = 0; i < win->nr_blocks; i++)
> +	for (int i = 0; i < win->nr_blocks; i++)
>  		/* Reset the page to write-back */
>  		set_memory_wb((unsigned long)msc_win_block(win, i), 1);
>  #endif
> 

