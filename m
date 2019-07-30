Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC897AB40
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfG3OmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 10:42:12 -0400
Received: from ozlabs.org ([203.11.71.1]:58509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731516AbfG3OmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:42:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yfQn59zQz9s8m;
        Wed, 31 Jul 2019 00:42:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564497729;
        bh=vUMUX/7k3pQXC5FL4whWy2LS4dQN6qjUSbztGnpKFb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X7i5oqvtODD3P29rlwibSJ50R+u572IKhvqmA7QGbDw006vmURD+kId8vehoq5Kr6
         qqOAWxv/yVr34hNxYD4p6Jbr8Cm7G4TEKDHHdPPmJuJGROojXIIdPOpNg/SbY5xFtW
         sc/fPQYhH9evC9ZxD7cAy8M0PLy5SwZ/Wz8Gpnj4bckbEglbO1EWdMv3l1lFUmLyVN
         dCaGjTmp+L8nMQHVcNFKVip5S+s01Mf7mMj8Abnlz2PpHbQzq2/0zX0AJqAOqvxFrz
         SIc5V5w/jrMKkdG4zHs3vdhyGJh8n6pNzB6ISxUbyPfN3mx66lLt9vQoJa9mablOGD
         zBphf0rm9oaKw==
Date:   Wed, 31 Jul 2019 00:41:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch
 fall-through
Message-ID: <20190731004153.6c6198fa@canb.auug.org.au>
In-Reply-To: <878ssfzjdk.fsf@concordia.ellerman.id.au>
References: <20190730143704.060a2606@canb.auug.org.au>
        <878ssfzjdk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pIdlFQu0i8FL/lm6/rYKL9L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Wed, 31 Jul 2019 00:28:55 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Why do we think it's an expected fall through? I can't really convince
> myself from the surrounding code that it's definitely intentional.

Its been that way since this code was introduced by commit

  0365ba7fb1fa ("[PATCH] ppc64: SMU driver update & i2c support")

in 2005 ...

--=20
Cheers,
Stephen Rothwell

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1AVzEACgkQAVBC80lX
0Gw/rwf+P6QPr+aB8iXvRzPQ1R6e2idCJJup+E7e51Z/Gl59GezLyodDWg3UcALE
lmzirNhyw1ZwnlhfpzcJ5pzHazfn7z/37UuqjUVenq9VWaYiZLRY6XA5ufe3aj6X
Q7xVeJplLON1xKRp+34fPYA3+mYQqNEWhgdsrHzxrSje+aXE3Wac0ArVLPL0ct59
/w/OOidJMAsh3InX2KUK3i83tGUPMyBby56/owxqpJLXFpuFlOpL+vb0ymEawkkL
/gqftyc45jwNC75tOE/17Km8qNqiFSKjQArDgDA3iyjLF1edvr/iNQZBjcRe9WFc
6+5WYM6uIpZVv+og6vpdSzUW3/zvug==
=1jvs
-----END PGP SIGNATURE-----

--Sig_/pIdlFQu0i8FL/lm6/rYKL9L--
