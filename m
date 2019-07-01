Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E109B59270
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 06:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfF1ERr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 00:17:47 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55820 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1ERq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:17:46 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hgiKV-0004s6-UA; Fri, 28 Jun 2019 12:17:43 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hgiKU-000242-1n; Fri, 28 Jun 2019 12:17:42 +0800
Date:   Fri, 28 Jun 2019 12:17:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: ccree: minor fixes
Message-ID: <20190628041741.qy7poqm4dcrvjdcv@gondor.apana.org.au>
References: <20190617084631.23551-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617084631.23551-1-gilad@benyossef.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:46:26AM +0300, Gilad Ben-Yossef wrote:
> A bunch of minor fixes and sanity checks
> 
> Gilad Ben-Yossef (1):
>   crypto: ccree: add HW engine config check
> 
> Ofir Drang (3):
>   crypto: ccree: Relocate driver irq registration after clk init
>   crypto: ccree: check that cryptocell reset completed
>   crypto: ccree: prevent isr handling in case driver is suspended
> 
>  drivers/crypto/ccree/cc_driver.c    | 70 +++++++++++++++++++++++++----
>  drivers/crypto/ccree/cc_driver.h    |  6 +++
>  drivers/crypto/ccree/cc_host_regs.h | 20 +++++++++
>  drivers/crypto/ccree/cc_pm.c        | 11 +++++
>  drivers/crypto/ccree/cc_pm.h        |  7 +++
>  5 files changed, 105 insertions(+), 9 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
