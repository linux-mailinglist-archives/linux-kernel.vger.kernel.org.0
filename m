Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A95159EEC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 03:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbgBLCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 21:06:33 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57730 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBLCGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:06:32 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j1hQ5-0001BF-TF; Wed, 12 Feb 2020 10:06:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j1hQ4-0007hA-DZ; Wed, 12 Feb 2020 10:06:28 +0800
Date:   Wed, 12 Feb 2020 10:06:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] crypto: export() overran state buffer on test vector
Message-ID: <20200212020628.7grnopgwm6shn3hi@gondor.apana.org.au>
References: <20200206085442.GA5585@Red>
 <20200207065719.GA8284@sol.localdomain>
 <20200207104659.GA10979@Red>
 <20200208085713.ftuqxhatk6iioz7e@gondor.apana.org.au>
 <20200211192118.GA24059@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211192118.GA24059@Red>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:21:18PM +0100, Corentin Labbe wrote:
> 
> Do you mean that I should abandon ahash as a fallback ?

Perhaps switching to shash is not as straightforward because of
SG handling.  But if you're getting problems with statesize
perhaps at least force a sync ahash algorithm might be a good
idea.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
