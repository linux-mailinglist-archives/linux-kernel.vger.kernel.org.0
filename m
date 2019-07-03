Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C563F5E69F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 16:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfGCO2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 10:28:10 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52166 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfGCO2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:28:10 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1higEw-0000eh-IQ; Wed, 03 Jul 2019 22:28:06 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1higEt-0000WS-TK; Wed, 03 Jul 2019 22:28:03 +0800
Date:   Wed, 3 Jul 2019 22:28:03 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] Clean up crypto documentation
Message-ID: <20190703142803.723vkrh5b65sxn7s@gondor.apana.org.au>
References: <156150616764.22527.16524544899486041609.stgit@taos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156150616764.22527.16524544899486041609.stgit@taos>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:43:36PM +0000, Hook, Gary wrote:
> Tidy up the crypto documentation by filling in some variable
> descriptions, make some grammatical corrections, and enhance
> formatting.
> 
> Changes since v1:
>  - Remove patch with superfluous change to index (patch 2)
>  - Remove unnecessary markup on function names in patch 3
>  - Un-add extraneous white space (patch 3)
> 
> ---
> 
> Gary R Hook (2):
>       crypto: doc - Add parameter documentation
>       crypto: doc - Fix formatting of new crypto engine content
> 
> 
>  Documentation/crypto/api-skcipher.rst  |    2 -
>  Documentation/crypto/crypto_engine.rst |  111 +++++++++++++++++++++-----------
>  include/linux/crypto.h                 |   11 +++
>  3 files changed, 85 insertions(+), 39 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
