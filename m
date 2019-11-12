Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D03F870F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 04:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLDQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 22:16:58 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:38088 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfKLDQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.orG>);
        Mon, 11 Nov 2019 22:16:58 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iUMfY-0008Io-Cc; Tue, 12 Nov 2019 11:16:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iUMfT-0007aI-9H; Tue, 12 Nov 2019 11:16:35 +0800
Date:   Tue, 12 Nov 2019 11:16:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Kees Cook <keescook@chromium.org>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@lsc.ic.unicamp.br>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v4 3/8] crypto: x86/camellia: Use new glue function macros
Message-ID: <20191112031635.jm32vne33qxh7ojh@gondor.apana.org.au>
References: <20191111214552.36717-1-keescook@chromium.org>
 <20191111214552.36717-4-keescook@chromium.org>
 <3059417.7DhL3USBNQ@positron.chronox.de>
 <20191112031417.GB1433@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112031417.GB1433@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:14:17PM -0800, Eric Biggers wrote:
>
> Also, I don't see the point of the macros, other than to obfuscate things.  To
> keep things straightforward, I think we should keep the explicit function
> prototypes for each algorithm.

I agree.  Kees, please get rid of the macros.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
