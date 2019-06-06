Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B893E36BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 07:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFFFkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 01:40:47 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37757 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFFkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 01:40:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45KDyz70Swz9s3l;
        Thu,  6 Jun 2019 15:40:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559799644;
        bh=05otM2RfXszcLYY6GO4FdaQJRpZRyGnM74UilqAt4zU=;
        h=Date:From:To:Cc:Subject:From;
        b=FBCQNeWASieWkfXlMrESILKT08kikV2Ce/bLiuSlkkhbJPvVirBzJropZmleYm4/E
         +qoTq3bSEqSFZj8IBnL0OpqydqnhsSMjnSkts1dSiCwlEHePybzlcTy8n0/Vs4c1CX
         qghJNKqCifHzsPb4AzPBwJmx3NUOP46AvVZ4uP0WnH9A8R8VyA26HB+8Qu1i8RhQcM
         VM92iiEt7lfkKwb+kwHWq5t+FNYzTN1HOHnsUNwoQJx2sbvtAhKXWduuJdhW+N17zu
         UcBANdTFiRMvabXTMHheDUKJzXb63t6dJbbvLrpDwalFaCU3opzLcq5OPOBdI6VqeL
         BjXYmvUaO8zXw==
Date:   Thu, 6 Jun 2019 15:40:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: linux-next: manual merge of the pidfd tree with Linus' tree
Message-ID: <20190606154034.7d8ba5d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P82a9gtvGIURYM1Ekb4W_o0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P82a9gtvGIURYM1Ekb4W_o0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pidfd tree got a conflict in:

  tools/testing/selftests/pidfd/pidfd_test.c

between commit:

  1fcd0eb356ad ("tests: fix pidfd-test compilation")

from Linus' tree and commit:

  233ad92edbea ("pidfd: add polling selftests")

from the pidfd tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/P82a9gtvGIURYM1Ekb4W_o0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz4p1IACgkQAVBC80lX
0GyrXggAiI/EPPvyqGl/jsf+PRndL5BZ2c9nKe5AlOG+tD8poTyrAvz7a8iPvd0v
QGuYnPtPt/AJVIBf8PvfB+XbNI+pwzw+Agy7+J2qboB4PcqxOk5t4j1nZ0pGRz4P
f4hetzqVgjIU+68r+5kR1Hm81u0sMfqVg8rrIMvchZB3THxDugaLy4byLSXJKkzH
v9vtKYog/Wpxe4px1NhxUbO8RaLMUyBm/+H1smgkpNQ7FrpzV12Gjdn2KS8nTD3r
0HYiheEFLSGaIOir2xxRu84+zZ8yPF1g2C27Q6f5vvYTbQkGmo7R27ME8e8sbZ5T
ZJFR5E6MgWJ/737Vx8ws67YdnU1Mdg==
=+018
-----END PGP SIGNATURE-----

--Sig_/P82a9gtvGIURYM1Ekb4W_o0--
