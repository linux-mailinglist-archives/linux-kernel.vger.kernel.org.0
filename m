Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D09B6C8D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 07:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfGRFl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 01:41:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57812 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfGRFl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:41:56 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hnzAt-0007BF-Qk; Thu, 18 Jul 2019 13:41:51 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hnzAt-0005eb-5Q; Thu, 18 Jul 2019 13:41:51 +0800
Date:   Thu, 18 Jul 2019 13:41:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Rientjes <rientjes@google.com>
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Cfir Cohen <cfir@google.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch v2] crypto: ccp - Fix SEV_VERSION_GREATER_OR_EQUAL
Message-ID: <20190718054151.fi5akslvzp7h5b2w@gondor.apana.org.au>
References: <alpine.DEB.2.21.1907101426290.2777@chino.kir.corp.google.com>
 <e30eae0f-415b-842e-39c4-801227126367@amd.com>
 <alpine.DEB.2.21.1907121341210.37390@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907121341210.37390@chino.kir.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 01:41:58PM -0700, David Rientjes wrote:
> SEV_VERSION_GREATER_OR_EQUAL() will fail if upgrading from 2.2 to 3.1, for
> example, because the minor version is not equal to or greater than the
> major.
> 
> Fix this and move to a static inline function for appropriate type
> checking.
> 
> Fixes: edd303ff0e9e ("crypto: ccp - Add DOWNLOAD_FIRMWARE SEV command")
> Reported-by: Cfir Cohen <cfir@google.com>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  v2: no need to check api_major >= maj after checking api_major > maj
>      per Thomas
> 
>  drivers/crypto/ccp/psp-dev.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
