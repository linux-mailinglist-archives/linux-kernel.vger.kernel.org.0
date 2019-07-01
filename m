Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CC27599
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 07:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfEWFhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 01:37:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47208 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfEWFhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:37:50 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hTgQ9-0000gD-G3; Thu, 23 May 2019 13:37:41 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hTgQ5-0006ni-1e; Thu, 23 May 2019 13:37:37 +0800
Date:   Thu, 23 May 2019 13:37:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, stefan.wahren@i2se.com,
        wahrenst@gmx.net, linux-crypto@vger.kernel.org, mpm@selenic.com
Subject: Re: [PATCH 0/2] hwrng: Support for 7211 in iproc-rng200
Message-ID: <20190523053736.5jjevtz62lgddxtq@gondor.apana.org.au>
References: <20190510173112.2196-1-f.fainelli@gmail.com>
 <c3a3dc05-17fb-09fe-7a22-43e748f88164@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a3dc05-17fb-09fe-7a22-43e748f88164@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:49:12PM -0700, Florian Fainelli wrote:
> On 5/10/19 10:31 AM, Florian Fainelli wrote:
> > Hi Herbert,
> > 
> > This patch series adds support for BCM7211 to the iproc-rng200 driver,
> > nothing special besides matching the compatibile string and updating the
> > binding document.
> 
> Herbert, can you apply those patches?

Hi Florian:

Patch 1/2 is missing an ack from Rob.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
