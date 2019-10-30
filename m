Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC686E9612
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 06:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfJ3F1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 01:27:50 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:33496
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfJ3F1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:27:50 -0400
X-IronPort-AV: E=Sophos;i="5.68,246,1569276000"; 
   d="scan'208";a="325073474"
Received: from ppp-seco11pareq2-46-193-149-47.wb.wifirst.net (HELO hadrien) ([46.193.149.47])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:27:47 +0100
Date:   Wed, 30 Oct 2019 06:27:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
cc:     outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        trivial@kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: sm750fb: Fix typo in
 comment
In-Reply-To: <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
Message-ID: <alpine.DEB.2.21.1910300627330.2471@hadrien>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com> <20191029232207.4113-2-gabrielabittencourt00@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2019, Gabriela Bittencourt wrote:

> Fixing typo in word 'and'.
>
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  drivers/staging/sm750fb/sm750_accel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 645813a87490..5925d7c7d464 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -224,7 +224,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>
>  	/*
>  	 * Note:
> -	 * DE_FOREGROUND are DE_BACKGROUND are don't care.
> +	 * DE_FOREGROUND and DE_BACKGROUND are don't care.
>  	 * DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS
>  	 * are set by set deSetTransparency().
>  	 */
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191029232207.4113-2-gabrielabittencourt00%40gmail.com.
>
