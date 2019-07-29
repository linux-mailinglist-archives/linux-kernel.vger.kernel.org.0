Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90C079B17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfG2VbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 17:31:03 -0400
Received: from ozlabs.org ([203.11.71.1]:42997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbfG2VbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:31:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45yCY05ZxRz9sBF;
        Tue, 30 Jul 2019 07:31:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564435860;
        bh=Po9+HUmzX5hL3NuL0JMT0eWxx2i4/OkdHWdvgrl87gQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GAuJ8BFFsY9ufvTeB+5U64VafwIMb/w5S7k8LcLuVUZ0pJ4qQkkfe4g/N7YbhlCxB
         RD8pryKby0mzUQoOL9mVr4KFJF7pYZOOO8Uj5acsdsK5wcRZ1eV1PT/7lnaP3lyf4r
         Jnu2YzTDcU0QyVkpKhBeu6f+8Rkzssmccs9ogFOlMvWsQzHSv7pOViQ2rzFBCGZcJX
         EAJyAAlPS+gvjRIK1nYdP7j3Fuyuk+6PMT0/fGDpY4xMLmOUl1TuJovau9h4v2hZrG
         hSvWDO2j5Z/jtV9givVYzhgD3h2misqnx6XLAj1Zi/A0+ctODDGGaz7ttysWkxKUlp
         ZMhTTS7958Rlg==
Date:   Tue, 30 Jul 2019 07:30:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the coresight tree
Message-ID: <20190730073058.03ad7d6b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Chphge1Ugu.UVoFMV7Vxln2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Chphge1Ugu.UVoFMV7Vxln2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  7d131e267b7c ("coresight: funnel: Convert pr_warn to dev_warn for obsolet=
e bindings")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Chphge1Ugu.UVoFMV7Vxln2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0/ZZIACgkQAVBC80lX
0GzK6wf+MfRi4MZiRstQ4rIOXrEWg4QPCmJvzo1OaRsUBvHuRUzUsMkZ0p4QY8n/
tWlaWe55aCYfkOcy8MdoFKn+YCnrxspMBuKqlf902A3phWCeVwBEJTiG5grYiOuo
RwQkJuIbA2QqkPfRvCjvDs7/fQ2Bt8mknxoI7cfqT31aDCgkGfCGY09Qa5aIw5Jf
oghEvWLhER7/IN35R4kWFTvhPVp8k+TW1/szdv4czx6rgMlEixS3DitVo/cTuw6c
3loeOn3GMkcVQIsuI/DvJ6SAmOu3yJ2DovvGA+fbAaodlFreDurC3dQw0SVJHY+w
/ULXoRATKY3rXTJtK0x+WXD9XZjBjw==
=IOQ2
-----END PGP SIGNATURE-----

--Sig_/Chphge1Ugu.UVoFMV7Vxln2--
