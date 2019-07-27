Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8B776B3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 07:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfG0FHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 01:07:48 -0400
Received: from ozlabs.org ([203.11.71.1]:43053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbfG0FHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:07:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45wYqN0Df9z9s8m;
        Sat, 27 Jul 2019 15:07:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564204064;
        bh=9VKOPpnCFNPvhE4WbCH3Jd3UIbwkeUe5Udt6mTVfzQA=;
        h=Date:From:To:Cc:Subject:From;
        b=U/JngwsaMcSUk+pVEdrV1ZabkstSszx7BdFKOumorvjeO7QIDgE1V6HTbACt7Qzpi
         KW1VWHri8P3GNTJYyNMmrO7o2/h9+JtGYccnrV1gSf0wz5nIPZYbaJuvlmQBOE6CEB
         scL8spAIPkeUPz54Op2wUkU9d3oSj5x0+J3aJIqAcuR2Nrf64iPt36VfOrT9GA+MqJ
         UjwmfRlV6FIc+ZJRkTijMxI7IMS4+rHBxIAoZkaX7YK4Qmpr9HP2o/dwVHNmTkUUOw
         dFU3GKopotF1bf7GniAmX+Bvql6CznK9OB8Hn0xmqq+iIBc6OlCSYwRrNcR/s1Eixx
         NmcfrYD0NstSw==
Date:   Sat, 27 Jul 2019 15:07:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hook, Gary" <Gary.Hook@amd.com>
Subject: linux-next: Signed-off-by missing for commit in the crypto tree
Message-ID: <20190727150738.3640330a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3xuTo3MPgvbTu/7bDhsMuiR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  53a5d5192803 ("crypto: ccp - Log an error message when ccp-crypto fails t=
o load")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl073BoACgkQAVBC80lX
0GxGewf/ad86dxEWUFE63NAJ28+iTnoxJkqp6Yc4Gg97n03HSMgqL4Cq/5KEkkq/
kwo7WE5ND6KZX3llmDZ5iKOx9LaO2XlYiWusCrpjhRIV16gyBshl4tJVnJFcDPNy
Ve5ma/lbGlrktND25/ORtaZh2Z/hxJVCh9yudXpYif7sGKN4a3MEbfg18LcdGlUS
oO7Ry2aqxZKkSDFfO8V1DdE1dn8hcCRKlVfRIjg7veQ0G9Y4NF78CbOgYgywwQ2Z
69d1wf8km1H4+ivrKj3kBDgadUa9Nzw82ySIpJI+VI/4scOyk127hY3isgiYE60O
5gEPU7is3YXib3Zap598UjTEot+tww==
=nznr
-----END PGP SIGNATURE-----

--Sig_/3xuTo3MPgvbTu/7bDhsMuiR--
