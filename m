Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC9E19780E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgC3JxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 05:53:04 -0400
Received: from ozlabs.org ([203.11.71.1]:46125 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgC3JxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:53:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rSSZ3ycKz9sR4;
        Mon, 30 Mar 2020 20:53:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585561982;
        bh=4jveewqoWMuGDvURbvktCF/JmuR+wuFAHFkFlsXUd5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BXzFrF8P1+XKVf77cz6vhDpzOw1o/8beiOyrcJg0Ds9WzBdPBNrq6yJgelIocXcBv
         kjgaPlQL/n3wN/xF8WEZoOmTz+zOQ1t9SgRmYeSPXEInhRKtCwq2kpzMegvuzwcZWv
         fMPgvlLA7YMNA5HZXlzdnKShzYzWJvTYBc84htCxS+HhEHzSWQZJgNFMJJj9AKpuI1
         sfWn5Ok4fViSf38p7ff1Ai6jVN7rFDJu+qkG0Ovvnfnt0792IFZR/043K8rQNT+6++
         XAbzkICLYrSX05Yna+HnsKLjyhneU4gX/nqlNK4c6aKMiiTsIquE5S/SXteuW8IDFR
         nMR9QaAfpoIVA==
Date:   Mon, 30 Mar 2020 20:53:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Email address update
Message-ID: <20200330205300.7a077301@canb.auug.org.au>
In-Reply-To: <20200330101149.0e3263c7@why>
References: <20200330101149.0e3263c7@why>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A=x7SzMnQu7RsfsrRoNLFyY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A=x7SzMnQu7RsfsrRoNLFyY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Mon, 30 Mar 2020 10:11:49 +0100 Marc Zyngier <maz@kernel.org> wrote:
>
> It seems that I failed to update you on my email address change a few
> months ago, and that you've been sending notices of issues with
> linux/next [1] to my old address, which I don't have access to anymore.
>=20
> Could you please replace all instances of marc.zyngier@arm.com with
> maz@kernel.org as the point of contact for both the irqchip and kvm/arm
> trees?

Done.

--=20
Cheers,
Stephen Rothwell

--Sig_/A=x7SzMnQu7RsfsrRoNLFyY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6BwXwACgkQAVBC80lX
0GyXqwf/ULgxfbvcQLxjwQ3nznNw9P9TAzHguyOh5QNstFV0Ed/geV9+pImKQoIJ
50HkOglz007J9UEcEb88dhB6MbDiy57FgCUzjm8hsCxSre/acvQRyX700/GSCajg
cGCKO4X31MAYlIJMlcbvdF/p/W5taUD7Eqt+RdDT+OYajlXlZYJxZGsNR9ShoJTt
OiOgLtsar2jS0bo14t/P0Q00/GqLbascviLoBBVzJvrg6oCnCXn4Rcvm7bbkmEFy
9v4bi1vxSkm7noYsX56e0AhNezPEjrBYJLfWaYD6klcm6GffGpMC4h1/RGy/gkDw
x25DwP18xaoXp9ViSHy9s+ixIXl2aQ==
=W5R2
-----END PGP SIGNATURE-----

--Sig_/A=x7SzMnQu7RsfsrRoNLFyY--
