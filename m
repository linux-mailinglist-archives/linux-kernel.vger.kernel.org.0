Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D495927D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 06:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF1ETo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 00:19:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55958 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfF1ETo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:19:44 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hgiMO-0004wu-AY; Fri, 28 Jun 2019 12:19:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hgiMN-00026A-6w; Fri, 28 Jun 2019 12:19:39 +0800
Date:   Fri, 28 Jun 2019 12:19:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Keerthy <j-keerthy@ti.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, t-kristo@ti.com, nm@ti.com
Subject: Re: [PATCH 00/10] crypto: k3: Add sa2ul driver
Message-ID: <20190628041939.7yduk77x62twath6@gondor.apana.org.au>
References: <20190618120843.18777-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618120843.18777-1-j-keerthy@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:38:33PM +0530, Keerthy wrote:
> The series adds Crypto hardware accelerator support for SA2UL.
> SA2UL stands for security accelerator ultra lite.

Please cc linux-crypto@vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
