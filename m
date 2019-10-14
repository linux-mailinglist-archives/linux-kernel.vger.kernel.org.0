Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDF4D5A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfJNEwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 00:52:46 -0400
Received: from ozlabs.org ([203.11.71.1]:48151 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfJNEwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 00:52:46 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
        id 46s5lZ61Wqz9sPZ; Mon, 14 Oct 2019 15:52:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1571028762;
        bh=iWErWVieEwX9iSuCACRAHe+fDMlfuKix+q5vZZBOBZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H70L8H62Vxr4L1kqmnym3DsBagpkvknXimYdMD9V9ociV7LDUerbifPI2M+ZF+gKB
         NbVWCEtaxLNqbISVhE5GxUzzy9X/MPnb781Tuld6xEY5pb7d4Ogx+EHyPQMZCnkvdT
         MxhVFP6E1owqxLVKQYTQwBtNqrmDx4CoVAl1cT9w=
Date:   Mon, 14 Oct 2019 15:51:39 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@ozlabs.org,
        mdroth@linux.vnet.ibm.com, aik@linux.ibm.com, paul.burton@mips.com,
        robin.murphy@arm.com, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, hch@lst.de, jasowang@redhat.com,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Message-ID: <20191014045139.GN4080@umbus.fritz.box>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0aF+6pWUK5w8WdCh"
Content-Disposition: inline
In-Reply-To: <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0aF+6pWUK5w8WdCh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2019 at 06:25:18PM -0700, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>=20
> In order to safely use the DMA API, virtio needs to know whether DMA
> addresses are in fact physical addresses and for that purpose,
> dma_addr_is_phys_addr() is introduced.
>=20
> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> cc: David Gibson <david@gibson.dropbear.id.au>
> cc: Michael Ellerman <mpe@ellerman.id.au>
> cc: Paul Mackerras <paulus@ozlabs.org>
> cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> cc: Alexey Kardashevskiy <aik@linux.ibm.com>
> cc: Paul Burton <paul.burton@mips.com>
> cc: Robin Murphy <robin.murphy@arm.com>
> cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> cc: Marek Szyprowski <m.szyprowski@samsung.com>
> cc: Christoph Hellwig <hch@lst.de>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

The change itself looks ok, so

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

However, I would like to see the commit message (and maybe the inline
comments) expanded a bit on what the distinction here is about.  Some
of the text from the next patch would be suitable, about DMA addresses
usually being in a different address space but not in the case of
bounce buffering.

> ---
>  arch/powerpc/include/asm/dma-mapping.h | 21 +++++++++++++++++++++
>  arch/powerpc/platforms/pseries/Kconfig |  1 +
>  include/linux/dma-mapping.h            | 20 ++++++++++++++++++++
>  kernel/dma/Kconfig                     |  3 +++
>  4 files changed, 45 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/includ=
e/asm/dma-mapping.h
> index 565d6f7..f92c0a4b 100644
> --- a/arch/powerpc/include/asm/dma-mapping.h
> +++ b/arch/powerpc/include/asm/dma-mapping.h
> @@ -5,6 +5,8 @@
>  #ifndef _ASM_DMA_MAPPING_H
>  #define _ASM_DMA_MAPPING_H
> =20
> +#include <asm/svm.h>
> +
>  static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type=
 *bus)
>  {
>  	/* We don't handle the NULL dev case for ISA for now. We could
> @@ -15,4 +17,23 @@ static inline const struct dma_map_ops *get_arch_dma_o=
ps(struct bus_type *bus)
>  	return NULL;
>  }
> =20
> +#ifdef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
> +/**
> + * dma_addr_is_phys_addr - check whether a device DMA address is a physi=
cal
> + *		address
> + * @dev:	device to check
> + *
> + * Returns %true if any DMA address for this device happens to also be a=
 valid
> + * physical address (not necessarily of the same page).
> + */
> +static inline bool dma_addr_is_phys_addr(struct device *dev)
> +{
> +	/*
> +	 * Secure guests always use the SWIOTLB, therefore DMA addresses are
> +	 * actually the physical address of the bounce buffer.
> +	 */
> +	return is_secure_guest();
> +}
> +#endif
> +
>  #endif	/* _ASM_DMA_MAPPING_H */
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 9e35cdd..0108150 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -152,6 +152,7 @@ config PPC_SVM
>  	select SWIOTLB
>  	select ARCH_HAS_MEM_ENCRYPT
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
>  	help
>  	 There are certain POWER platforms which support secure guests using
>  	 the Protected Execution Facility, with the help of an Ultravisor
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f7d1eea..6df5664 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -693,6 +693,26 @@ static inline bool dma_addressing_limited(struct dev=
ice *dev)
>  			    dma_get_required_mask(dev);
>  }
> =20
> +#ifndef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
> +/**
> + * dma_addr_is_phys_addr - check whether a device DMA address is a physi=
cal
> + *		address
> + * @dev:	device to check
> + *
> + * Returns %true if any DMA address for this device happens to also be a=
 valid
> + * physical address (not necessarily of the same page).
> + */
> +static inline bool dma_addr_is_phys_addr(struct device *dev)
> +{
> +	/*
> +	 * Except in very specific setups, DMA addresses exist in a different
> +	 * address space from CPU physical addresses and cannot be directly used
> +	 * to reference system memory.
> +	 */
> +	return false;
> +}
> +#endif
> +
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  		const struct iommu_ops *iommu, bool coherent);
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 9decbba..6209b46 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -51,6 +51,9 @@ config ARCH_HAS_DMA_MMAP_PGPROT
>  config ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	bool
> =20
> +config ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
> +	bool
> +
>  config DMA_NONCOHERENT_CACHE_SYNC
>  	bool
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0aF+6pWUK5w8WdCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2j/tgACgkQbDjKyiDZ
s5JjGg/+JngolQLtvjQamOxnEvRu2H1H2tVbqHMjiTaWHWflqa0S/1nocSzdtK2P
XWHQwkku6xRMD2WmRLBxLciSfstKP0LO/s6GMh9ATx9JkDgaR1ayhMc1t6yIRrLh
E1NNiwmwJBLNx4XDBV7ykagoSGaoF7LnOe2NFUeQ++IMMp61WYi95oc15s+JlEDG
FGvfLDXYwLNyzhE7f8XQ11WLzdhj2oGey8n+Kjqg7yFmcYrw3H8aWet9tl8pL8wi
QhATd99yJfC7Dwei+13Dg4b4ichGPn117SWXHd15FM6I6xkDOSwnq2nmCJOrcWrl
jVOWHpgQHsdtizpdpc0RvjSXYjA5uXTOl5rOMz3/LVY/unvELd+7ohxL2miOb5fu
PU26NMZXnL7Kc/vuvRemPvxYTX0RDH2JcOs8AmDaKWNony4yxqZENH2OUzkUQzuU
5sravuQc3pm7JiJKg3Qvb+30ufJkjRIhRWWRvUKBorR/rZnO4DrAWcmMD1Op4d7Y
1UHZTq3ebolz3NjC+n/OruacpccFEzfVst7LYVA7Ta0gNflF87Eskd66ANc3yCGZ
eaeXmRyg+eQS8jdWsiZC0s+pftkVnKV1aR97WP9s7fUByOCrsO7Obzt9yAsjQC8p
KynS5IvW4hY3deRymW3/sIX/qX+iWVm0z/7URc7CyskxWatq9xw=
=/s/t
-----END PGP SIGNATURE-----

--0aF+6pWUK5w8WdCh--
