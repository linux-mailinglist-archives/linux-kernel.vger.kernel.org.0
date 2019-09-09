Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC8AD42D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 09:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfIIHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Sep 2019 03:53:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:32890 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbfIIHxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:53:20 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i7EU2-0007cL-GH; Mon, 09 Sep 2019 17:53:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 09 Sep 2019 17:53:08 +1000
Date:   Mon, 9 Sep 2019 17:53:08 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] CAAM bugfixes, small improvements
Message-ID: <20190909075308.GC21364@gondor.apana.org.au>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904023515.7107-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 07:35:03PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This series bugfixes and small improvement I made while doing more
> testing of CAAM code:
> 
>  - "crypto: caam - make sure clocks are enabled first"
> 
>    fixes a recent regression (and, conincidentally a leak cause by one
>    of my i.MX8MQ patches)
> 
>  - "crypto: caam - use devres to unmap JR's registers"
>    "crypto: caam - check irq_of_parse_and_map for errors"
> 
>    are small improvements
> 
>  - "crypto: caam - dispose of IRQ mapping only after IRQ is freed"
> 
>    fixes a bug introduced by my i.MX8MQ series
> 
>  - "crypto: caam - use devres to unmap memory"
>    "crypto: caam - use devres to remove debugfs"
>    "crypto: caam - use devres to de-initialize the RNG"
>    "crypto: caam - use devres to de-initialize QI"
>    "crypto: caam - user devres to populate platform devices"
>    "crypto: caam - populate platform devices last"
> 
>    are devres conversions/small improvments
> 
>  - "crypto: caam - convert caamrng to platform device"
>    "crypto: caam - change JR device ownership scheme"
> 
>    are more of an RFC than proper fixes. I don't have a very high
>    confidence in those fixes, but I think they are a good conversation
>    stater about the best approach to fix those issues
> 
> Thanks,
> Andrey Smirnov
> 
> Andrey Smirnov (12):
>   crypto: caam - make sure clocks are enabled first
>   crypto: caam - use devres to unmap JR's registers
>   crypto: caam - check irq_of_parse_and_map for errors
>   crypto: caam - dispose of IRQ mapping only after IRQ is freed
>   crypto: caam - use devres to unmap memory
>   crypto: caam - use devres to remove debugfs
>   crypto: caam - use devres to de-initialize the RNG
>   crypto: caam - use devres to de-initialize QI
>   crypto: caam - user devres to populate platform devices
>   crypto: caam - populate platform devices last
>   crypto: caam - convert caamrng to platform device
>   crypto: caam - change JR device ownership scheme
> 
>  drivers/crypto/caam/caamrng.c | 102 +++++-------
>  drivers/crypto/caam/ctrl.c    | 294 ++++++++++++++++++----------------
>  drivers/crypto/caam/intern.h  |   4 -
>  drivers/crypto/caam/jr.c      |  90 ++++++++---
>  drivers/crypto/caam/qi.c      |   8 +-
>  drivers/crypto/caam/qi.h      |   1 -
>  6 files changed, 267 insertions(+), 232 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
