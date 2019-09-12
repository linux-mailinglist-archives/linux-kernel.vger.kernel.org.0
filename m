Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2350B1571
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 22:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfILUdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Sep 2019 16:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfILUdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:33:04 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7142081B;
        Thu, 12 Sep 2019 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568320383;
        bh=CB2XpztpavJGy3dm3AoMm+FcqVmWK1TrOXf41F5cmwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=caMq8O9OoJzYXInTCWtgcByNPiOWIaps2AzQGUoA3ebFQRsv7lBeXZ/lwMjbntD1H
         ReskcFFUIqcNtmZmgQ3lVrJJJwrn62/H+099nba/6y6v27Gd2ZShStQ0aaQu/8Rb4B
         kGjSRuutTV4HzCssIjjdbgN+Pdpk7Qzg4iQ57Ko8=
Date:   Thu, 12 Sep 2019 22:33:01 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        David Miller <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 3/9] dt-bindings: crypto: Add DT bindings documentation
 for sun8i-ce Crypto Engine
Message-ID: <20190912203301.is4ubixhk64dl5t7@localhost.localdomain>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-4-clabbe.montjoie@gmail.com>
 <20190907040116.lib532o2eqt4qnvv@flea>
 <20190911183158.GA8264@Red>
 <20190912093737.s6iu63sdncij2qib@localhost.localdomain>
 <CAGb2v678WGQm5PNy8GhOTpz+fYeLP3k0dnR0F00yyZpSRcA4yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGb2v678WGQm5PNy8GhOTpz+fYeLP3k0dnR0F00yyZpSRcA4yA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 09:26:27PM +0100, Chen-Yu Tsai wrote:
> > >
> > >   clock-names:
> > >     items:
> > >       - const: ahb
> > >       - const: mod
> > >       - const: mbus
> >
> > And here as well
> >
> > Something I missed earlier though was that we've tried to unify as
> > much as possible the ahb / apb / axi clocks around the bus name, it
> > would be great if you could do it.
>=20
> I think we also want to standardize "mbus" as "dram"?

Do we? The only user so far seems to be sun9i-de, while mbus has more
users. I don't really care though, both mbus and dram are pretty
generic to me. What makes you prefer dram over mbus?

Maxime
