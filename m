Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F1A82D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbfIDMcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 08:32:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60346 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfIDMcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:32:23 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i5US8-0000ub-V0; Wed, 04 Sep 2019 22:32:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 04 Sep 2019 22:31:59 +1000
Date:   Wed, 4 Sep 2019 22:31:59 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] crypto: inside-secure - Fix build error without
 CONFIG_PCI
Message-ID: <20190904123158.GA29870@gondor.apana.org.au>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <MN2PR20MB297342698B98343D49FC2C82CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_EA8-=Vc3aAdJSz7399Y5WBeKNjw_T3LEq7yOY2XQ+BA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 05:27:19AM -0700, Ard Biesheuvel wrote:
> 
> Did you try disabling CONFIG_PCI?

Indeed.  Even with my patch if you compile with CONFIG_PCI you still
get a warning:

  CC [M]  drivers/crypto/inside-secure/safexcel.o
../drivers/crypto/inside-secure/safexcel.c: In function \u2018safexcel_init\u2019:
../drivers/crypto/inside-secure/safexcel.c:1506:6: warning: unused variable \u2018rc\u2019 [-Wunused-variable]
  int rc;
      ^~

We should fix that in inside-secure.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
