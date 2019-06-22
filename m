Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BBF4F606
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfFVNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 09:47:52 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfFVNrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 09:47:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45WH1c2yQYz9s3l;
        Sat, 22 Jun 2019 23:47:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561211269;
        bh=pP/8rMNEo83cpR500udcxqn4E35bj9H9Xfz9zsR2n8w=;
        h=Date:From:To:Cc:Subject:From;
        b=H3dLip3dRNFjZZmjWavWcZYic6ViRlGUYALCCp3mPERzhpt071/4pj99DVyS8G+EL
         ZiQJwNj12u6xha21IABhk7No7xZWiqyWMdgtZNyyG0FdWqG5isAGPgBheQZ/M8D+Bo
         j6hg9du1iBtzDTPItcg7ggkbZF0rVxpmfGuirDYkEUZX2FjKZ7+rlgWByY68oDfMSK
         77J5OnZ6/eoME6X+DhjKwfkAow/00V8aaY18mXrjXx+Y2hJycFCqaU2H/crDNOwlwF
         cBmtmqam4F7oDVwokX4XqtfdDVcxC0T8/X9sVhKZmqwQrTSk8eY71DNUI/Yg7vGB9I
         p53uOLvPNMiWQ==
Date:   Sat, 22 Jun 2019 23:47:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190622234746.2381cc3e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K50yG8sqz+Yd0EA5SCVXrpi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K50yG8sqz+Yd0EA5SCVXrpi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mauro,

In commit

  3a959dcd11a4 ("media: mt9m111: add regulator support")

Fixes tag

  Fixes: 5c10113cc668 ("media: mt9m111: make a standalone v4l2 subdevice")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

  5d7cc01b20fc ("[media] media: mt9m111: make a standalone v4l2 subdevice")

--=20
Cheers,
Stephen Rothwell

--Sig_/K50yG8sqz+Yd0EA5SCVXrpi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0OMYIACgkQAVBC80lX
0Gyt9Af+N7R6Dg/CE19bLovcHCXRgXk4nfOmzFKe6Jj+41+itR4Uh51KOTIvCsQT
2jozS3CmqKnpR9k/NFPPMEfE8pzD1UhL2GNwCFou7uluYAbmcKavWUWp/UQQ6JTE
esZ+329WGTPL2kr/pLPpSVE91tRDkl17vVygUytGHU1ywdT5/biaguzCf/tKMAqB
wWozZVrjColA2b9JlgGqKvd98RrTXqw6loazLnlUs2tyy1GtIzP1DAvg5j2nqdkI
0aZ7qC6JyuINwTH5/3gBALplGhDOS3ub6KbY63cpq7uG5G21FFgC4y5/gGKu2Iwp
nAFpC7AxtqD7PAO1zhLLqiw4uQwMZg==
=5nWe
-----END PGP SIGNATURE-----

--Sig_/K50yG8sqz+Yd0EA5SCVXrpi--
