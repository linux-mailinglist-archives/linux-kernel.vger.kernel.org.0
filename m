Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74197DBDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 08:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504371AbfJRG2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Oct 2019 02:28:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36862 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392981AbfJRG2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:28:06 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iLLjx-0002ZQ-VJ; Fri, 18 Oct 2019 17:27:59 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Oct 2019 17:27:56 +1100
Date:   Fri, 18 Oct 2019 17:27:56 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: hash - initializing memory buffer for keys
Message-ID: <20191018062756.GA13096@gondor.apana.org.au>
References: <20191018050457.13809-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018050457.13809-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:04:56AM -0500, Kangjie Lu wrote:
> "ctx" is uninitialized. To avoid undefined behaviors or memory
> disclosures, we better initialize it.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Please be more specific about what undefined behaviours you're
referring to.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
