Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816EB14523E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 11:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgAVKOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 05:14:01 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39108 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVKOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:14:01 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iuD1J-0000Vo-TK; Wed, 22 Jan 2020 18:13:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iuD1G-00042A-TX; Wed, 22 Jan 2020 18:13:55 +0800
Date:   Wed, 22 Jan 2020 18:13:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] crypto: ccree - fixes and cleanups
Message-ID: <20200122101354.dfo3ukeu4lhhkr25@gondor.apana.org.au>
References: <20200116101447.20374-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116101447.20374-1-gilad@benyossef.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:14:35PM +0200, Gilad Ben-Yossef wrote:
> A bunch of fixes and code cleanups for the ccree driver
> 
> Gilad Ben-Yossef (8):
>   crypto: ccree - fix AEAD decrypt auth fail
>   crypto: ccree - turn errors to debug msgs
>   crypto: ccree - fix pm wrongful error reporting
>   crypto: ccree - cc_do_send_request() is void func
>   crypto: ccree - fix PM race condition
>   crypto: ccree - split overloaded usage of irq field
>   crypto: ccree - make cc_pm_put_suspend() void
>   crypto: ccree - erase unneeded inline funcs
> 
> Hadar Gat (2):
>   crypto: ccree: fix typos in error msgs
>   crypto: ccree: fix typo in comment
> 
> Ofir Drang (1):
>   crypto: ccree - fix FDE descriptor sequence
> 
>  drivers/crypto/ccree/cc_aead.c        | 22 +++----
>  drivers/crypto/ccree/cc_cipher.c      | 54 ++++++++++++++--
>  drivers/crypto/ccree/cc_driver.c      | 16 ++---
>  drivers/crypto/ccree/cc_driver.h      |  5 +-
>  drivers/crypto/ccree/cc_pm.c          | 37 +++--------
>  drivers/crypto/ccree/cc_pm.h          | 17 +----
>  drivers/crypto/ccree/cc_request_mgr.c | 90 ++++-----------------------
>  drivers/crypto/ccree/cc_request_mgr.h |  8 ---
>  8 files changed, 93 insertions(+), 156 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
