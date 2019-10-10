Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1146AD2A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfJJMyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 08:54:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37592 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbfJJMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:54:01 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iIXx6-0001nl-6n; Thu, 10 Oct 2019 23:53:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 10 Oct 2019 23:53:53 +1100
Date:   Thu, 10 Oct 2019 23:53:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hw_random: move add_early_randomness() out of rng_mutex
Message-ID: <20191010125353.GA31566@gondor.apana.org.au>
References: <20190912133022.14870-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912133022.14870-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 03:30:22PM +0200, Laurent Vivier wrote:
> add_early_randomness() is called every time a new rng backend is added
> and every time it is set as the current rng provider.
> 
> add_early_randomness() is called from functions locking rng_mutex,
> and if it hangs all the hw_random framework hangs: we can't read sysfs,
> add or remove a backend.
> 
> This patch move add_early_randomness() out of the rng_mutex zone.
> It only needs the reading_mutex.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 60 +++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 16 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
