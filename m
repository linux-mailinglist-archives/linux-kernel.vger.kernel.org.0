Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73E862FD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2019 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfGIE7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jul 2019 00:59:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44405 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGIE7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 00:59:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jVTm1pTKz9sML;
        Tue,  9 Jul 2019 14:59:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562648348;
        bh=IEHeoS2OgHpqNZ7RELfpQGH8kplCB5dwSy4q0KPos0k=;
        h=Date:From:To:Cc:Subject:From;
        b=OZKQLhJxih1lN4cUZMw8FEwHhcgUDjlrHwstYYhpMI2eoOpy+SUkBFG4SXkJGopoK
         rgua0ScZVtumLQsgQXjDKgOF9jinSnefrm5EF3pUyEI8TyPk4lJzunrwNjBgsyoR13
         ARpTPS/vhWxdFChvgWxIDKNeRsuPwf1nSXFzQAeYLZ9HLZaKpctpfBB0NiZ7F6LmWf
         InqSMSRy5L8EvSVrT9urgEdWGJ3gMhpO6Gadh6mStJ0QAmFmzhVY+cX549D5l5xBoG
         Aq5v96M2TSsZNM8Pkm3u9OZF8lYLip9DdD95zokbaG1fewzEw8LPR7hiojqZ2X/su3
         xHiVET0BvLLoQ==
Date:   Tue, 9 Jul 2019 14:59:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: please clean up the mali-dp tree
Message-ID: <20190709145907.70b1db61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EUyOlaD3MNJCHo52EGHEtNo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EUyOlaD3MNJCHo52EGHEtNo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

Now that a rebased copy of the mali-dp tree has been merged into the
drm tree, please clean up the mali-dp tree as it is causing conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/EUyOlaD3MNJCHo52EGHEtNo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0kHxsACgkQAVBC80lX
0GznVwf/TbsXGoGT9+vTZufyCsyXI4HmngURGAIHUTEfOZuRVzfLvnoSu3ANi2D9
fnQDtygdt39Z1sEONyBKJGXHEJIW6jpfdLC+qsDGIvU7qK0NSyBsFQGSPUkM0r0M
Fn5DACu7eCqHscvS6f0pIrX8DqiQfvHTXKuG711gHdcvyQSjpPNjDPrUXaU0umQc
DhMJ/icsaJ+d88L3eu94Jcy5ZKuaqKtUkzAiU7trpdkuj21V56cLpt6xuhfvTiTk
keL/2X4V9wUx3mQ/evJ8++F562vi9L9nCfPUHRjgWNVOuYtHxAhbla691+akrpb9
w4+M8zbIOTF3PKrTCaYwPPRNVHVHUg==
=wJoE
-----END PGP SIGNATURE-----

--Sig_/EUyOlaD3MNJCHo52EGHEtNo--
