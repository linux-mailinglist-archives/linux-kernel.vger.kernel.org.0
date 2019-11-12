Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78457F9E08
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 00:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKLXRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 18:17:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:44266 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727226AbfKLXRi (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Tue, 12 Nov 2019 18:17:38 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iUfPe-0006vY-AT; Wed, 13 Nov 2019 07:17:30 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iUfPb-0001MR-AW; Wed, 13 Nov 2019 07:17:27 +0800
Date:   Wed, 13 Nov 2019 07:17:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Chris Healy <cphealy@gmail.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] enable CAAM's HWRNG as default
Message-ID: <20191112231727.bzgh42lc333gu4eu@gondor.apana.org.au>
References: <20191029162916.26579-1-andrew.smirnov@gmail.com>
 <226f5a669c2199408abcdec0ccddc9ff05672631.camel@pengutronix.de>
 <CAHQ1cqF3BgberQMMY3sKH5iabG3oN6-H=o-y00Q710zrB7KNgw@mail.gmail.com>
 <20191108151948.ojn6ga3preh66utl@gondor.apana.org.au>
 <CAHQ1cqGAtw5UVqGbr-05Tg0V9bXRRyP6SjqrXCiuwmLbgRrOBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGAtw5UVqGbr-05Tg0V9bXRRyP6SjqrXCiuwmLbgRrOBA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 07:13:02AM -0800, Andrey Smirnov wrote:
>
> If I am reading the datasheet right reseeding should be done every
> time CAAM is asked to generated random data.

If you can guarantee that everytime the driver reads n bytes from
the hardware, that the hardware is then reseeded with nbytes prior
to that read, then it should be good enough.

If the hardware only reseeds afterwards or reseeds with less than
n bytes then it is not sufficient.
 
> Even if prediction resistance is an acceptable approach, would it be
> better to expose underlying TRNG and downgrade current CAAM hwrng code
> to crypto rng API? If that's the best path forward, I am more than
> happy to go that way in v2.

If it offers true prediction resistance it should be good enough
to use the drivers/char/hw_random interface.  Otherwise please
switch to the Crypto API RNG interface.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
