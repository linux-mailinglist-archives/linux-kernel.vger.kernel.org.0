Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974D3CBF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390063AbfJDPp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:45:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42644 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389807AbfJDPp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:45:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPky-0001Rb-OR; Sat, 05 Oct 2019 01:44:37 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:44:33 +1000
Date:   Sat, 5 Oct 2019 01:44:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     ghook@amd.com, emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto: ccp - Release all allocated memory if sha
 type is invalid
Message-ID: <20191004154433.GX5148@gondor.apana.org.au>
References: <7ffc6a77-f4e3-7db9-4ec6-53d6e01d881d@amd.com>
 <20190919160449.4303-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919160449.4303-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 11:04:48AM -0500, Navid Emamdoost wrote:
> Release all allocated memory if sha type is invalid:
> In ccp_run_sha_cmd, if the type of sha is invalid, the allocated
> hmac_buf should be released.
> 
> v2: fix the goto.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/crypto/ccp/ccp-ops.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
