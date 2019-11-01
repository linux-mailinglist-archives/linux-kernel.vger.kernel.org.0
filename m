Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E77EBD99
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 07:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfKAGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Nov 2019 02:08:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37580 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfKAGIb (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:08:31 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQ6k-0001u5-7f; Fri, 01 Nov 2019 14:08:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQ6i-0004qj-5Y; Fri, 01 Nov 2019 14:08:24 +0800
Date:   Fri, 1 Nov 2019 14:08:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] CAAM bugfixes, small improvements
Message-ID: <20191101060824.txnywabazrcna53q@gondor.apana.org.au>
References: <20191022153013.3692-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022153013.3692-1-andrew.smirnov@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 08:30:07AM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains bugfixes and small improvement I made while doing
> more testing of CAAM code.
> 
> Changes since [v1]:
> 
>     - Rebased on latest cryptodev/master, series limited to just
>       devres changes
> 
>     - Minor code style changes as per feedback
> 
> [v1] lore.kernel.org/lkml/20190904023515.7107-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (6):
>   crypto: caam - use devres to unmap memory
>   crypto: caam - use devres to remove debugfs
>   crypto: caam - use devres to de-initialize the RNG
>   crypto: caam - use devres to de-initialize QI
>   crypto: caam - use devres to populate platform devices
>   crypto: caam - populate platform devices last
> 
>  drivers/crypto/caam/ctrl.c   | 222 ++++++++++++++++-------------------
>  drivers/crypto/caam/intern.h |   4 -
>  drivers/crypto/caam/qi.c     |   8 +-
>  drivers/crypto/caam/qi.h     |   1 -
>  4 files changed, 104 insertions(+), 131 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
