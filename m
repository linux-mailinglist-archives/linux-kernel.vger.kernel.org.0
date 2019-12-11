Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8211A83A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 10:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfLKJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 04:50:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55888 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbfLKJu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:50:56 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieydq-0000iP-RW; Wed, 11 Dec 2019 17:50:46 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieydn-0006eC-Cu; Wed, 11 Dec 2019 17:50:43 +0800
Date:   Wed, 11 Dec 2019 17:50:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCHv1 0/3] Enable crypto module on Amlogic GXBB SoC platform
Message-ID: <20191211095043.3kngq7wh77xvadge@gondor.apana.org.au>
References: <20191211084112.971-1-linux.amoon@gmail.com>
 <a4610efc-844a-2d43-5db1-cf813102e701@baylibre.com>
 <CANAwSgQOTA0mSvFW5otaCzFPHidhY7VFcrXZHjCD-1XkQpcx3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgQOTA0mSvFW5otaCzFPHidhY7VFcrXZHjCD-1XkQpcx3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:07:53PM +0530, Anand Moon wrote:
>
> name         : ecb(aes)
> driver       : ecb-aes-gxl
> module       : kernel
> priority     : 400
> refcnt       : 1
> selftest     : passed
> internal     : no
> type         : skcipher
> async        : yes
> blocksize    : 16
> min keysize  : 16
> max keysize  : 32
> ivsize       : 0
> chunksize    : 16
> walksize     : 16
> 
> name         : cbc(aes)
> driver       : cbc-aes-gxl
> module       : kernel
> priority     : 400
> refcnt       : 1
> selftest     : passed
> internal     : no
> type         : skcipher
> async        : yes
> blocksize    : 16
> min keysize  : 16
> max keysize  : 32
> ivsize       : 16
> chunksize    : 16
> walksize     : 16

Oh so you did actually get them loaded.  You need to run tcrypt with
mode=500 instead of 200 to test the async ciphers.  Does that work?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
