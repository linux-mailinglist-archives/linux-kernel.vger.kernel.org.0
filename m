Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 767C5A9AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2019 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbfIEGZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Sep 2019 02:25:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731359AbfIEGZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:25:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 81238E957918129EA04E;
        Thu,  5 Sep 2019 14:25:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 14:25:28 +0800
Message-ID: <5D70AA57.5080700@huawei.com>
Date:   Thu, 5 Sep 2019 14:25:27 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Will Deacon <will@kernel.org>, <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <catalin.marinas@arm.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] crypto: arm64: Use PTR_ERR_OR_ZERO rather than its implementation.
References: <1567493656-19916-1-git-send-email-zhongjiang@huawei.com> <20190904102526.5vtdv5ofuezn7fre@willie-the-truck>
In-Reply-To: <20190904102526.5vtdv5ofuezn7fre@willie-the-truck>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/4 18:25, Will Deacon wrote:
> On Tue, Sep 03, 2019 at 02:54:16PM +0800, zhong jiang wrote:
>> PTR_ERR_OR_ZERO contains if(IS_ERR(...)) + PTR_ERR. It is better to
>> use it directly. hence just replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm64/crypto/aes-glue.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/crypto/aes-glue.c b/arch/arm64/crypto/aes-glue.c
>> index ca0c84d..2a2e0a3 100644
>> --- a/arch/arm64/crypto/aes-glue.c
>> +++ b/arch/arm64/crypto/aes-glue.c
>> @@ -409,10 +409,8 @@ static int essiv_cbc_init_tfm(struct crypto_skcipher *tfm)
>>  	struct crypto_aes_essiv_cbc_ctx *ctx = crypto_skcipher_ctx(tfm);
>>  
>>  	ctx->hash = crypto_alloc_shash("sha256", 0, 0);
>> -	if (IS_ERR(ctx->hash))
>> -		return PTR_ERR(ctx->hash);
>>  
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(ctx->hash);
>>  }
>>  
>>  static void essiv_cbc_exit_tfm(struct crypto_skcipher *tfm)
> Acked-by: Will Deacon <will@kernel.org>
Thanks.

Sincerely,
zhong jiang
> Assuming this will go via Herbert.
>
> Will
>
> .
>


