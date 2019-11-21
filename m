Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9B104A47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 06:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfKUFbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 00:31:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34578 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbfKUFbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 00:31:13 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iXf3P-0000vj-W0; Thu, 21 Nov 2019 13:30:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iXf3G-0002bu-Mm; Thu, 21 Nov 2019 13:30:46 +0800
Date:   Thu, 21 Nov 2019 13:30:46 +0800
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
Message-ID: <20191121053046.coobocevp4uwwugb@gondor.apana.org.au>
References: <20191120031622.88949-1-stephen@brennan.io>
 <3e78d01f-f7a4-b3c4-4d23-7be7d6ad764d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e78d01f-f7a4-b3c4-4d23-7be7d6ad764d@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 08:09:57PM -0800, Florian Fainelli wrote:
> Hi Herbert,
> 
> On 11/19/2019 7:16 PM, Stephen Brennan wrote:
> > This patch series enables support for the HWRNG included on the Raspberry
> > Pi 4.  It is simply a rebase of Stefan's branch [1]. I went ahead and
> > tested this out on a Pi 4.  Prior to this patch series, attempting to use
> > the hwrng gives:
> > 
> >     $ head -c 2 /dev/hwrng
> >     head: /dev/hwrng: Input/output error
> > 
> > After this series, the same command gives two random bytes.
> 
> When we get a review from Rob, you can take patches 1-2 through your
> tree and Stefan/Nicholas can queue patches 3-4 through the BCM2835 tree
> where the DTS files already exist. Does that work for you?

Yes sure.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
