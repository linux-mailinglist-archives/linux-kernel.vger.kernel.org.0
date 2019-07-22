Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6370397
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfGVPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 11:21:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50429 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbfGVPV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:21:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45slhK0CXMz9sDQ;
        Tue, 23 Jul 2019 01:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563808914;
        bh=z5WiiJX5uAlUkmKbSRsDyoZNz71+vQZD44f1bmFgLLQ=;
        h=Date:From:To:Cc:Subject:From;
        b=R070fEDKq6+SZSfGZOYBBCpusQRtNWixAzbo2y28KBpWptUeofgNYAd/6Fi0WXnBj
         pgetVFz6hDlPBi7gzBDz7NiRBjZY1Wvx0k8MaVnkgjI3A76mOcKJTqz5WYMNeOm+WN
         qcXbUYyiTMFlcXBpWwZRs/mPSP82p3u11kdDVBCVOD869FlmOObfYmOuL4lKRMUwPY
         e0U+whQrqXeKnQjJAY8LBMISdZ8GqzqafctY32WOs9NtYTUPlwljz0KcaIzfwrMQTh
         f4b9rEh5NBHDxQ621dSb+GW0UhyIJSSeNCgFKL/VVZmGzDdhf9g8DQJEWW/EFMxiqk
         7jGdwNmWPXGBQ==
Date:   Tue, 23 Jul 2019 01:21:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: linux-next: Fixes tag needs some work in the mmc-fixes tree
Message-ID: <20190723012152.047dfd59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.0OxGC./vcPDMJYX9L7.6QX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.0OxGC./vcPDMJYX9L7.6QX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  665e985c2f41 ("mmc: meson-mx-sdio: Fix misuse of GENMASK macro")

Fixes tag

  Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/.0OxGC./vcPDMJYX9L7.6QX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl011JAACgkQAVBC80lX
0GwZhgf+OfVMHAS+i0XbufgaawA7goaFCehn8gFb9BE0w7HHYPJ5U8lZkIkhQPcV
eQybuPkCh8LzVFKyNQ/eFatCqA1bcKDOzVf89YFrRUxthnlk8s577d33LheWhPaN
Nv9x+OjRd1i9+mo7N8CJeIARObUgQdVOUJouwgETIo8C6XkU4SFnOrh5iqbZ0tyj
N9d9rpZ3tyGbdXKfO3kiy5HJaNYm8BON19Am4qdqMZkvWdRC0pcEv/gre3F4uOLG
q2cYhC17SLbK4vsXhM1CW70VoSZppmAyTeV0eaq8bN++XLPORuPGgbsZhHFfAv7W
WpXC/r6O8S2AbVrCiFXwgIHrP6hpXA==
=BsT2
-----END PGP SIGNATURE-----

--Sig_/.0OxGC./vcPDMJYX9L7.6QX--
