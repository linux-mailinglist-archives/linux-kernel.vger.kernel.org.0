Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877CC54D44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfFYLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 07:08:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36297 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbfFYLIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:08:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Y3LG2Gnyz9s4V;
        Tue, 25 Jun 2019 21:08:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561460902;
        bh=W0ECW50hvw2G4vsI4j5cuqsDfInS3gxdEMOmRINPb+k=;
        h=Date:From:To:Cc:Subject:From;
        b=CJs+uATBLA+P6kWt3XKcoNARZq1MpbH8VeYWexGMCZjD/rzkoBZowvh2MJzeghbmS
         QnNHY6w7C2fZWI8YeilPwZ9dIQe61sq6U9asLcXWE+0KN3b4B+3GHfiMV1Q6Ma5T1P
         J+5xSnU4l75x7+POadbmM1q7UVfKv4Xyeh1Vz9hGH7zZ9iBtcs9hdCIwQGRRBF7q0m
         767Xc9p+0wT/HicdjOVM6vFgUbspcC2WGuLSmoGjMJOuEzuWClxb+1XtOuWAZXwi5u
         c8G3li7WvZ8HXmvkVdZOkTPeWzXV/uxI066rOPP6SNq2O4NJiihYjL+gfvYi1YylhG
         kYUx54xF4jJdw==
Date:   Tue, 25 Jun 2019 21:08:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20190625210821.6907304a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6n6sD438XUAGHphu/xXTfdl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6n6sD438XUAGHphu/xXTfdl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c1ed2864526e ("smb3: minor cleanup of compound_send_recv")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6n6sD438XUAGHphu/xXTfdl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0SAKUACgkQAVBC80lX
0GwcJgf9G09rYD6cJKzZADFCcwLEuhz6EjCMK1KaXtRPlBJld1U75mvA61sMgZMF
05aLZFMpOCn51R9yfxIGp5n5MXU5mdLbUHSry3PiiqiTJ44Xb6eYY6QZeSF81A0u
nx2ZdSdEE7S9uKFKQ2rDdmtMFer8a58/sXmINt8uxSH0xPiGgnIwcguipd93nyKa
9PxtlRij07sENMzIBl66ych387z4lTzHTgxnlcdnAm2gbUWKNngiVIAjNiJWUd7C
hucESseduUKODQVW8Kcc7w8/ufjxyzTWBcsQJ8FDZXXDpBdk4FbYP9KjXiyNpuIQ
lZmX6JCvwfjnIMLqbFQeQd/PRR2bZw==
=9KXw
-----END PGP SIGNATURE-----

--Sig_/6n6sD438XUAGHphu/xXTfdl--
