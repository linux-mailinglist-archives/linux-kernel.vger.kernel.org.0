Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1AF73198
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGXO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 10:27:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:37172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbfGXO16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:27:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A8E9AE44;
        Wed, 24 Jul 2019 14:27:57 +0000 (UTC)
Message-ID: <3a2f952e090d972b33f62592b12399f9ef3b0513.camel@suse.de>
Subject: Re: [RFC 3/4] dma-direct: add dma_direct_min_mask
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     stefan.wahren@i2se.com, f.fainelli@gmail.com,
        Robin Murphy <robin.murphy@arm.com>, phil@raspberrypi.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jisheng.Zhang@synaptics.com, mbrugger@suse.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Wed, 24 Jul 2019 16:27:55 +0200
In-Reply-To: <20190724135657.GA9075@lst.de>
References: <20190717153135.15507-1-nsaenzjulienne@suse.de>
         <20190717153135.15507-4-nsaenzjulienne@suse.de>
         <20190718091526.GA25321@lst.de>
         <13dd1a4f33fcf814545f0d93f18429e853de9eaf.camel@suse.de>
         <58753252bd7964e3b9e9558b633bd325c4a898a1.camel@suse.de>
         <20190724135124.GA44864@arrakis.emea.arm.com>
         <20190724135657.GA9075@lst.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-m+/FyWNmUHFI+YRB/Gte"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m+/FyWNmUHFI+YRB/Gte
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-24 at 15:56 +0200, Christoph Hellwig wrote:
> On Wed, Jul 24, 2019 at 02:51:24PM +0100, Catalin Marinas wrote:
> > I think it may be better if we have both ZONE_DMA and ZONE_DMA32 on
> > arm64. ZONE_DMA would be based on the smallest dma-ranges as described
> > in the DT while DMA32 covers the first naturally aligned 4GB of RAM
> > (unchanged). When a smaller ZONE_DMA is not needed, it could be expande=
d
> > to cover what would normally be ZONE_DMA32 (or could we have ZONE_DMA a=
s
> > 0-bytes? I don't think GFP_DMA can still allocate memory in this case).
> >=20
> > We'd probably have to define ARCH_ZONE_DMA_BITS for arm64 to something
> > smaller than 32-bit but sufficient to cover the known platforms like
> > RPi4 (the current 24 is too small, so maybe 30). AFAICT,
> > __dma_direct_optimal_gfp_mask() figures out whether GFP_DMA or GFP_DMA3=
2
> > should be passed.
>=20
> ARCH_ZONE_DMA_BITS should probably become a variable.  That way we can
> just initialize it to the default 24 bits in kernel/dma/direct.c and
> allow architectures to override it in their early boot code.

Thanks both for your feedback. I'll start preparing a proper series.


--=-m+/FyWNmUHFI+YRB/Gte
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl04ausACgkQlfZmHno8
x/5nVAf/bB5PkXsWGRSrKIKToRRuuBU3F3Qkczzlf22bZ/BWtFMeSNlTL1Fz2BXY
fntHM/mLq5eBmbhnOMljQi4PSaNXX09olyWxJl4W6kJuDNyoAQ4+ncqWubT9Sevw
Kz7S8rqShYPxZT5vdNUHg/11Clx5lB1FkgmErz+Gc5qUunLClW66KuhTy6pls4vt
Odp5uE2S6j/YXpM1osSK7Ty3psAoyJ8QEGSlDiFFi4Zx69ycqmiKitmWYaAHCLu5
9a/KvFdyeE8UrF5sALymEDQr/G3V+G3AUtbI+xqsmTacUpCJYMhMJr2xtb3sWb5L
+UzW6OpVwWRETgf1XlNpbiIHOrAKKA==
=Tmgu
-----END PGP SIGNATURE-----

--=-m+/FyWNmUHFI+YRB/Gte--

