Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA312762C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfLTHHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 02:07:12 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58796 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfLTHHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 02:07:12 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iiCNL-0008TQ-Ki; Fri, 20 Dec 2019 15:07:03 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iiCNI-0007qR-P2; Fri, 20 Dec 2019 15:07:00 +0800
Date:   Fri, 20 Dec 2019 15:07:00 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: update documentation file path in MAINTAINERS
Message-ID: <20191220070700.6ufyaqkbvksiicgu@gondor.apana.org.au>
References: <20191211162120.1007580-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211162120.1007580-1-daniel.m.jordan@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 11:21:20AM -0500, Daniel Jordan wrote:
> It's changed since the recent RST conversion.
> 
> Fixes: bfcdcef8c8e3 ("padata: update documentation")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
