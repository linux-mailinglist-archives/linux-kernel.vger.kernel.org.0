Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7C5F2A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 08:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGDGRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 02:17:34 -0400
Received: from ozlabs.org ([203.11.71.1]:39411 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDGRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 02:17:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fSSW1qNQz9s8m;
        Thu,  4 Jul 2019 16:17:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562221051;
        bh=WLaM3/8Y1UAQHrpmkH7iLNZCc/2/Lx/RkNQH9iNzB0k=;
        h=Date:From:To:Cc:Subject:From;
        b=BiGlo34DtbnnihgDosUdkjWChRtSitJQ03PJ/sFB+gQlscdEb62FQXiVr+vVeIVGq
         t6eD0yGyLd9QsgmyFDGkzJnyHijwWJEfLPC5FlMQEuepXnCvVoE7mCnUHMXx3hX+k9
         v+awzf/xE8YSGWtnd8LWR2EsRUN4leCjhEbu3ayhfbeZUTAmVfMmZC7lNkyJewiX3I
         62CTFn+IKG5JsWSQZIE5pn/rKewaTjwC7dtwGwyi9dqGxv0dgvg7THNuCfE+KdHe2W
         tihkU1JOWSPrOVrG6Gd4Z6kqMFTJ0vWQTEig1zGBHJwJOBLDSNZRnKedjX0sDRNvd3
         VPxuW58aIgDVA==
Date:   Thu, 4 Jul 2019 16:17:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warning after merge of the driver-core tree
Message-ID: <20190704161730.1e0f6046@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/63rvGd2Mj5A+672BLSUGUN="; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/63rvGd2Mj5A+672BLSUGUN=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the driver-core tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

fs/ubifs/debug.c: In function 'dbg_debugfs_init_fs':
fs/ubifs/debug.c:2812:6: warning: unused variable 'err' [-Wunused-variable]
  int err, n;
      ^~~

Introduced by commit

  702d6a834b49 ("ubifs: no need to check return value of debugfs_create fun=
ctions")

--=20
Cheers,
Stephen Rothwell

--Sig_/63rvGd2Mj5A+672BLSUGUN=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0dmfoACgkQAVBC80lX
0GwXDgf/Xz8NV8nIpSrgQXNzOq/drk8o4ebtcE+OZP0kigBXlS2J8G6yOAkl4ny8
t6MLplG0hRlsw+yS0UlB6oNzDtR/cSanUyet5b79c4lrLlI/UGMLW8hK3DWAkmnm
Vy5Urodxb+hJ7o4f4HkWqVLeK4gopi/5HrAUxhhVikPxUeCJKfXygdbTmhiEDG3e
Q6lMJYWg7sJdq9sCfImtqNiAXOE0AEnzZK0OCfHu1kr/ztOCjJ2wXqa+F3+e5n/5
oPG5+ZGTk/ecmX00T1HiQ12uWObUJ5H1wy3JynsQVoPBcxIpablDpgyqRPGq4l2h
hR7snPShigs5TRnJoZPk3O541VlT/A==
=R4Wl
-----END PGP SIGNATURE-----

--Sig_/63rvGd2Mj5A+672BLSUGUN=--
