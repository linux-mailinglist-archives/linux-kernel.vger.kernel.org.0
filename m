Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDA87227
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 08:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405679AbfHIGUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 02:20:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37496 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405415AbfHIGUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 02:20:42 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvyGS-0007Rv-0g; Fri, 09 Aug 2019 16:20:36 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvyGQ-0002sq-Hg; Fri, 09 Aug 2019 16:20:34 +1000
Date:   Fri, 9 Aug 2019 16:20:34 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Gary Hook <gary.hook@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] crypto: ccp - Remove unnecessary includes
Message-ID: <20190809062034.GQ10392@gondor.apana.org.au>
References: <20190802232013.15957-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802232013.15957-1-helgaas@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:20:10PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> CCP includes <linux/pci.h> many times unnecessarily.  Add a couple
> DMA-related includes for dma_direction and dma_get_mask(), which were
> previously included indirectly via <linux/pci.h>.  Then remove the
> unnecessary includes of <linux/pci.h>.
> 
> Bjorn Helgaas (2):
>   crypto: ccp - Include DMA declarations explicitly
>   crypto: ccp - Remove unnecessary linux/pci.h include
> 
>  drivers/crypto/ccp/ccp-crypto.h    | 1 -
>  drivers/crypto/ccp/ccp-dev-v3.c    | 1 -
>  drivers/crypto/ccp/ccp-dev-v5.c    | 1 -
>  drivers/crypto/ccp/ccp-dev.h       | 2 +-
>  drivers/crypto/ccp/ccp-dmaengine.c | 1 +
>  drivers/crypto/ccp/ccp-ops.c       | 1 -
>  drivers/crypto/ccp/psp-dev.h       | 1 -
>  drivers/crypto/ccp/sp-dev.h        | 1 -
>  8 files changed, 2 insertions(+), 7 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
