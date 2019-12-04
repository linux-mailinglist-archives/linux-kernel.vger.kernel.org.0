Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8500711224A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2019 06:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfLDFAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Dec 2019 00:00:11 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:56192 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfLDFAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 00:00:11 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1icMlT-0001HY-8t; Wed, 04 Dec 2019 12:59:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1icMlK-0003XT-8n; Wed, 04 Dec 2019 12:59:42 +0800
Date:   Wed, 4 Dec 2019 12:59:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stephen Brennan <stephen@brennan.io>,
        Matt Mackall <mpm@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Raspberry Pi 4 HWRNG Support
Message-ID: <20191204045942.g3qmhpshphblgxhc@gondor.apana.org.au>
References: <20191120031622.88949-1-stephen@brennan.io>
 <3e78d01f-f7a4-b3c4-4d23-7be7d6ad764d@gmail.com>
 <20191121053046.coobocevp4uwwugb@gondor.apana.org.au>
 <5beb190c-fa77-6693-aead-4030930f5b8a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5beb190c-fa77-6693-aead-4030930f5b8a@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 08:55:04PM -0800, Florian Fainelli wrote:
>
> Rob has provided his Acked-by for the binding patch, are you targeting
> these changes for 5.5 or 5.6 at this point?

They are too late for 5.5 so it's going to be 5.6.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
