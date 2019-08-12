Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A6489F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfHLNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 09:07:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfHLNHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:07:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F079DCBBE20D890C1DCE;
        Mon, 12 Aug 2019 21:07:01 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 12 Aug 2019
 21:06:59 +0800
Subject: Re: [PATCH][crypto-next] crypto: hisilicon: fix spelling mistake
 "HZIP_COMSUMED_BYTE" -> "HZIP_CONSUMED_BYTE"
To:     Colin King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.or>
References: <20190812111525.574-1-colin.king@canonical.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5D516472.4000905@hisilicon.com>
Date:   Mon, 12 Aug 2019 21:06:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190812111525.574-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/12 19:15, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the hzip_dfx_regs array, fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
> index 6e0ca75585d4..00ecae387fdd 100644
> --- a/drivers/crypto/hisilicon/zip/zip_main.c
> +++ b/drivers/crypto/hisilicon/zip/zip_main.c
> @@ -206,7 +206,7 @@ static struct debugfs_reg32 hzip_dfx_regs[] = {
>  	{"HZIP_AVG_DELAY                 ",  0x28ull},
>  	{"HZIP_MEM_VISIBLE_DATA          ",  0x30ull},
>  	{"HZIP_MEM_VISIBLE_ADDR          ",  0x34ull},
> -	{"HZIP_COMSUMED_BYTE             ",  0x38ull},
> +	{"HZIP_CONSUMED_BYTE             ",  0x38ull},

Yes, thanks.

Zhou

>  	{"HZIP_PRODUCED_BYTE             ",  0x40ull},
>  	{"HZIP_COMP_INF                  ",  0x70ull},
>  	{"HZIP_PRE_OUT                   ",  0x78ull},
> 

