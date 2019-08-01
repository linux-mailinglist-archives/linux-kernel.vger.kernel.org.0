Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00E7E509
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732795AbfHAVy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 17:54:58 -0400
Received: from ozlabs.org ([203.11.71.1]:34175 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbfHAVy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:54:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4603xB6btMz9s3Z;
        Fri,  2 Aug 2019 07:54:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564696495;
        bh=KPSAi5E+QrUSQRNI6r1fH4edAAA6UKpIr2v3WfOzsUM=;
        h=Date:From:To:Cc:Subject:From;
        b=Zjzn8KFhqkkNwUTuWoG0Xvc1yGBWR3A9ezgltqCmGPDn25E8O+0dQ8dECIltwbTiU
         Uq3zA0LUOldzWueWuZKRyqqTLvQxzyx5/WSnw2uaE1UCj9CqdCKbP849IOOCsea3Lp
         rpUOzcswmjphrkGjkvQB7QLaLrB38iISvWMeH0oWMI2oNt0NE5OOVSEZ2jqzdVhCX3
         bVzgX+PpXcqgxMHy+g1CiFa+BNq4BRd8ubiwSOWgeAaMT2dsupwoSaKX7X7Zl5HfVn
         wIUD1hxSXULnH84j6+v+yqWPA6Z6RtGX3jZBwfSR6mK2nnxoUQGvo2FVUttEQj7S6Q
         aLJXzvIGNqY+A==
Date:   Fri, 2 Aug 2019 07:54:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20190802075453.06066be1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tvn2OBSDkwMEDVigN//YA/m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tvn2OBSDkwMEDVigN//YA/m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c3ab166ec798 ("SMB3: Kernel oops mounting a encryptData share with CONFIG=
_DEBUG_VIRTUAL")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Tvn2OBSDkwMEDVigN//YA/m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DX60ACgkQAVBC80lX
0GxHhgf+IB5SocUd0MMJ3udUo6oRImUgkO4C10Y5xlU9lvYlehoV4DT348vKYMYB
mGqvq4Og5JHUXg3CG4XR06uLQATcXJn7ao7zUqHixOL1a+idvNAFCZ2mjqL74QsS
9ZwqxwZFdGb5ELYWqoq1vxN2a6eTRpSmjRgf2XYinEzdNvR5BVkMDmXw7BkwLtN+
zcBIFefBRWYoocKqbV4QkJlw3usjjnDWvSL2pSyim5yJlP6Bqax9wkqYkOHr3cFf
jp43R8ytVZRH8Vnm8Wn2WAlUXCT8qlR+h2fIkVXttuRJYzh7kwT/TYZqLNEY/D4j
EZyenU+Bdy1TUg7hvSO9X3jIVpjfmA==
=Dju+
-----END PGP SIGNATURE-----

--Sig_/Tvn2OBSDkwMEDVigN//YA/m--
