Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3882B18307A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 13:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCLMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 08:39:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59984 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgCLMj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:39:28 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCN7Q-00022c-Gk; Thu, 12 Mar 2020 23:39:21 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 23:39:20 +1100
Date:   Thu, 12 Mar 2020 23:39:20 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Vitaly Andrianov <vitalya@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hw_random: move TI Keystone driver into the config menu
 structure
Message-ID: <20200312123920.GE28885@gondor.apana.org.au>
References: <06417e19-57fe-c090-c493-d4c481dfee00@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06417e19-57fe-c090-c493-d4c481dfee00@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:21:48PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Move the TI Keystone hardware random number generator into the
> same menu as all of the other hardware random number generators.
> 
> This makes the driver config be listed in the correct place in
> the kconfig tools.
> 
> Fixes: eb428ee0e3ca ("hwrng: ks-sa - add hw_random driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vitaly Andrianov <vitalya@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: linux-crypto@vger.kernel.org
> ---
>  drivers/char/hw_random/Kconfig |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
