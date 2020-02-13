Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 600FD15BB7E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 10:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgBMJTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 04:19:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42250 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729551AbgBMJTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:19:08 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2AeA-00047n-QW; Thu, 13 Feb 2020 17:18:58 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2Ae9-0006lb-GC; Thu, 13 Feb 2020 17:18:57 +0800
Date:   Thu, 13 Feb 2020 17:18:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     jens.wiklander@linaro.org, Rijo-john.Thomas@amd.com,
        chenzhou10@huawei.com, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, Devaraj.Rangasamy@amd.com,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH RESEND -next] tee: amdtee: amdtee depends on
 CRYPTO_DEV_CCP_DD
Message-ID: <20200213091857.424twarx2elaz7wy@gondor.apana.org.au>
References: <20200122091238.65484-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122091238.65484-1-yaohongbo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:12:38PM +0800, Hongbo Yao wrote:
> If CRYPTO_DEV_CCP_DD=m and AMDTEE=y, the following error is seen
> while building call.c or core.c
> 
> drivers/tee/amdtee/call.o: In function `handle_unload_ta':
> call.c:(.text+0x35f): undefined reference to `psp_tee_process_cmd'
> drivers/tee/amdtee/core.o: In function `amdtee_driver_init':
> core.c:(.init.text+0xf): undefined reference to `psp_check_tee_status
> 
> Fix the config dependency for AMDTEE here.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 757cc3e9ff ("tee: add AMD-TEE driver")
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
