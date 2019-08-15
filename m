Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBADE8EB10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 14:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbfHOMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 08:06:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57220 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfHOMGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:06:55 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hyEWn-0003LN-1L; Thu, 15 Aug 2019 22:06:49 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hyEWl-0007hX-LO; Thu, 15 Aug 2019 22:06:47 +1000
Date:   Thu, 15 Aug 2019 22:06:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Phani Kiran Hemadri <phemadri@marvell.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: cavium/nitrox - Allocate asymmetric crypto
 command queues
Message-ID: <20190815120647.GD29355@gondor.apana.org.au>
References: <20190808121711.26495-1-phemadri@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808121711.26495-1-phemadri@marvell.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:17:37PM +0000, Phani Kiran Hemadri wrote:
> This patch adds support to allocate CNN55XX device AQMQ command queues
> required for submitting asymmetric crypto requests.
> 
> Signed-off-by: Phani Kiran Hemadri <phemadri@marvell.com>
> Reviewed-by: Srikanth Jampala <jsrikanth@marvell.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_dev.h |  4 ++
>  drivers/crypto/cavium/nitrox/nitrox_lib.c | 66 ++++++++++++++++++++++-
>  drivers/crypto/cavium/nitrox/nitrox_req.h | 30 +++++++++++
>  3 files changed, 99 insertions(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
