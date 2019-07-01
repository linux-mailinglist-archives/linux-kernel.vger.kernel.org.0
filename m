Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508052759C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2019 07:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfEWFjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 01:39:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47222 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfEWFjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:39:07 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hTgRL-0000hH-M2; Thu, 23 May 2019 13:38:55 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hTgRF-0006oF-Lf; Thu, 23 May 2019 13:38:49 +0800
Date:   Thu, 23 May 2019 13:38:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: arm/sha512 - make function static
Message-ID: <20190523053849.u2rpdk5ddafrkcnx@gondor.apana.org.au>
References: <VI1PR07MB44324EFEF57062FCCA758358FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR07MB44324EFEF57062FCCA758358FD000@VI1PR07MB4432.eurprd07.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:07:14AM +0000, Philippe Mazenauer wrote:
> Function sha512_arm_final() is only used in this file, therefore should
> be static
> 
> ../arch/arm/crypto/sha512-glue.c:40:5: warning: no previous prototype for ‘sha512_arm_final’ [-Wmissing-prototypes]
>  int sha512_arm_final(struct shash_desc *desc, u8 *out)
>      ^~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>

An identical patch is already in the patchwork queue.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
