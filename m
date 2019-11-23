Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931A3107EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2019 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKWNwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Nov 2019 08:52:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:49426 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfKWNwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 08:52:45 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iYVq5-0003gi-7I; Sat, 23 Nov 2019 21:52:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iYVq0-00046X-Kk; Sat, 23 Nov 2019 21:52:36 +0800
Date:   Sat, 23 Nov 2019 21:52:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jamie Iles <jamie@jamieiles.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: picoxcell: adjust the position of
 tasklet_init and fix missed tasklet_kill
Message-ID: <20191123135236.johugbmuwpecnhsf@gondor.apana.org.au>
References: <20191123134817.30953-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123134817.30953-1-hslester96@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 09:48:17PM +0800, Chuhong Yuan wrote:
> Since tasklet is needed to be initialized before registering IRQ
> handler, adjust the position of tasklet_init to fix the wrong order.
> 
> Besides, to fix the missed tasklet_kill, this patch adds a helper
> function and uses devm_add_action_or_reset to kill the tasklet
> automatically.
> 
> Fixes: ce92136843cb ("crypto: picoxcell - add support for the picoxcell crypto engines")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v3:
>   - Use devm_add_action_or_reset to simplify the patch.
> 
>  drivers/crypto/picoxcell_crypto.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Thanks for the patch.  It looks much nicer.

> @@ -1655,6 +1660,14 @@ static int spacc_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> +	tasklet_init(&engine->complete, spacc_spacc_complete,
> +		     (unsigned long)engine);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, spacc_tasklet_kill,
> +				       &engine->complete);

Minor nit.  You only need devm_add_action as calling tasklet_kill
at this point should be a no-op.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
