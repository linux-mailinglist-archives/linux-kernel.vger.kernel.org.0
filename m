Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B65D0CBFA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 17:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390109AbfJDPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 11:45:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42678 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbfJDPp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:45:58 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPmC-0001Xm-Bc; Sat, 05 Oct 2019 01:45:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:45:51 +1000
Date:   Sat, 5 Oct 2019 01:45:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2] crypto: caam - use mapped_{src,dst}_nents for
 descriptor
Message-ID: <20191004154551.GC5148@gondor.apana.org.au>
References: <1569500789-7443-1-git-send-email-iuliana.prodan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569500789-7443-1-git-send-email-iuliana.prodan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 03:26:29PM +0300, Iuliana Prodan wrote:
> The mapped_{src,dst}_nents _returned_ from the dma_map_sg
> call (which could be less than src/dst_nents) have to be
> used to generate the job descriptors.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
> Changes since v1:
> - updated, with mapped_{src,dst}_nents, the set_rsa_pub_pdb, set_rsa_priv_f{1,2,3}_pdb functions.
> ---
>  drivers/crypto/caam/caampkc.c | 72 +++++++++++++++++++++++--------------------
>  drivers/crypto/caam/caampkc.h |  8 +++--
>  2 files changed, 45 insertions(+), 35 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
