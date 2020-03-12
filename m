Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F61B183073
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 13:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgCLMi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 08:38:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59944 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCLMi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:38:26 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jCN6O-0001zi-SF; Thu, 12 Mar 2020 23:38:18 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 12 Mar 2020 23:38:16 +1100
Date:   Thu, 12 Mar 2020 23:38:16 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     John Allen <john.allen@amd.com>
Cc:     linux-crypto@vger.kernel.org, thomas.lendacky@amd.com,
        davem@davemloft.net, brijesh.singh@amd.com, bp@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto/ccp: Properly NULL variables on sev exit
Message-ID: <20200312123816.GA28885@gondor.apana.org.au>
References: <20200303135724.14060-1-john.allen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303135724.14060-1-john.allen@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 07:57:22AM -0600, John Allen wrote:
> Stale pointers left in static variables misc_dev and sp_dev_master will
> trigger use-after-free error when DEBUG_TEST_DRIVER_REMOVE is configured.
>                                                                                  
> John Allen (2):
>   crypto/ccp: Cleanup misc_dev on sev exit
>   crypto/ccp: Cleanup sp_dev_master on psp device destroy
> 
>  drivers/crypto/ccp/psp-dev.c | 3 +++
>  drivers/crypto/ccp/sev-dev.c | 6 +++---
>  drivers/crypto/ccp/sp-dev.h  | 1 +
>  drivers/crypto/ccp/sp-pci.c  | 9 +++++++++
>  4 files changed, 16 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
