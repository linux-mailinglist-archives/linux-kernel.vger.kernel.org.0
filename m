Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9707AAF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfG3O3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:29:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfG3O3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:29:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yf7c2NXQz9sBF;
        Wed, 31 Jul 2019 00:29:00 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch fall-through
In-Reply-To: <20190730143704.060a2606@canb.auug.org.au>
References: <20190730143704.060a2606@canb.auug.org.au>
Date:   Wed, 31 Jul 2019 00:28:55 +1000
Message-ID: <878ssfzjdk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warning (Building: powerpc):
>
> drivers/macintosh/smu.c: In function 'smu_queue_i2c':
> drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    cmd->info.devaddr &= 0xfe;
>    ~~~~~~~~~~~~~~~~~~^~~~~~~
> drivers/macintosh/smu.c:855:2: note: here
>   case SMU_I2C_TRANSFER_STDSUB:
>   ^~~~
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/macintosh/smu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> index 276065c888bc..23f1f41c8602 100644
> --- a/drivers/macintosh/smu.c
> +++ b/drivers/macintosh/smu.c
> @@ -852,6 +852,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
>  		break;
>  	case SMU_I2C_TRANSFER_COMBINED:
>  		cmd->info.devaddr &= 0xfe;
> +		/* fall through */
>  	case SMU_I2C_TRANSFER_STDSUB:
>  		if (cmd->info.sublen > 3)
>  			return -EINVAL;

Why do we think it's an expected fall through? I can't really convince
myself from the surrounding code that it's definitely intentional.

cheers
