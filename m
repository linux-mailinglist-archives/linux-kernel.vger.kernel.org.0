Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AFA5C64C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 02:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfGBAZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jul 2019 20:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfGBAZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:25:24 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9319C21721;
        Tue,  2 Jul 2019 00:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562027123;
        bh=MPIDSjZSqrqTeWvWT//E/0wZy5fEnuIgGI95YyoSxss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K17hf1xlfaVcjMn/oGAGN5LYYVhtG4iXNAAmaxiEg6SyeDPInPxpVPw9wjAXFJ5Yg
         T+yiH8itPf3deW5gsoP+7cb8s7Psg8LUbHUvGwIGZ6WFZTbzcNOAvJrUISTps6zu/7
         S2f7kL+yDqHTPQbr/5Lua9vshmIaF/SqxhPY5dYg=
Date:   Mon, 1 Jul 2019 17:25:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Cfir Cohen <cfir@google.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp/gcm - use const time tag comparison.
Message-ID: <20190702002522.GA693@sol.localdomain>
References: <20190702000132.88836-1-cfir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702000132.88836-1-cfir@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 05:01:32PM -0700, Cfir Cohen wrote:
> Avoid leaking GCM tag through timing side channel.
> 
> Signed-off-by: Cfir Cohen <cfir@google.com>
> ---
>  drivers/crypto/ccp/ccp-ops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-ops.c b/drivers/crypto/ccp/ccp-ops.c
> index db8de89d990f..633670220f6c 100644
> --- a/drivers/crypto/ccp/ccp-ops.c
> +++ b/drivers/crypto/ccp/ccp-ops.c
> @@ -840,7 +840,8 @@ static int ccp_run_aes_gcm_cmd(struct ccp_cmd_queue *cmd_q,
>  		if (ret)
>  			goto e_tag;
>  
> -		ret = memcmp(tag.address, final_wa.address, AES_BLOCK_SIZE);
> +		ret = crypto_memneq(tag.address, final_wa.address,
> +				    AES_BLOCK_SIZE) ? -EBADMSG : 0;
>  		ccp_dm_free(&tag);
>  	}
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Looks like this needs:

	Fixes: 36cf515b9bbe ("crypto: ccp - Enable support for AES GCM on v5 CCPs")
	Cc: <stable@vger.kernel.org> # v4.12+

- Eric
