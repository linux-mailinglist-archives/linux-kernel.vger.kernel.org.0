Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6BF1406CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 10:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAQJrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 04:47:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbgAQJrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:47:46 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B6F29C345B17E1B5F1B3;
        Fri, 17 Jan 2020 17:32:12 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 17:32:11 +0800
Subject: Re: [PATCH][next] crypto: hisilicon: fix spelling mistake "disgest"
 -> "digest"
To:     Colin King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
References: <20200117092819.97640-1-colin.king@canonical.com>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <7df81648-eb73-c770-e5d4-65148cd46b95@huawei.com>
Date:   Fri, 17 Jan 2020 17:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200117092819.97640-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, thanks.


On 2020/1/17 17:28, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in an error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> index a0a35685e838..a2cfcc9ccd94 100644
> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
> @@ -690,7 +690,7 @@ static int sec_aead_auth_set_key(struct sec_auth_ctx *ctx,
>   		ret = crypto_shash_digest(shash, keys->authkey,
>   					  keys->authkeylen, ctx->a_key);
>   		if (ret) {
> -			pr_err("hisi_sec2: aead auth disgest error!\n");
> +			pr_err("hisi_sec2: aead auth digest error!\n");
>   			return -EINVAL;
>   		}
>   		ctx->a_key_len = blocksize;


