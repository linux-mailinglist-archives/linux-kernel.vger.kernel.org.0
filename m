Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE6030768
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2019 05:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfEaDzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 23:55:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59293 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfEaDzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:55:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45FVwR5Q9hz9sMM;
        Fri, 31 May 2019 13:55:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559274936;
        bh=WnJUe+4OzIfxQ+ASOkfghdjn8sCpv3/mIHffHIDJsQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4q6coGNwvuJX5mCdM6xpXznZhr089KKtaYqvROaO7VNhAejR8PvT1VjYOYRO0kPq
         2Nl+6Ykywh8zN1j/nLRYI6EwPMGeEpMJFPwUzZulGzWbA3bZ13XsleXoJrvRcg53KQ
         z0ZGJKKEYHahTxxofdIKEKisgEkl+6F1p51smHN8aWUE0rSS5wNVAzYOFkI/wsja3e
         ky5DVqhxMkMdzwGxZ1AqhwVHeiQTCT7to4jPRofmtZcYq+C3+8ZAj6TmApvVpd9bYS
         xQPFU7Bub6JiAizc9YtxZQqGTIXBAWeRECiFUjtuLKPTvXaZQ2F38pNZO7c3VwOhqw
         nQJjIwKBaVMSw==
Date:   Fri, 31 May 2019 13:55:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: linux-next: manual merge of the userns tree with the
 arc-current tree
Message-ID: <20190531135534.350dbf57@canb.auug.org.au>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A2520902@us01wembx1.internal.synopsys.com>
References: <20190530131721.0af603a4@canb.auug.org.au>
        <C2D7FE5348E1B147BCA15975FBA2307501A2520902@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Iel2uKWbKzZVD/3RL+cnIU/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vineet,

On Thu, 30 May 2019 17:11:33 +0000 Vineet Gupta <Vineet.Gupta1@synopsys.com=
> wrote:
>
> Thx for this. Unfortunately I had to force push my for-next due to broken=
 #7 and
> #8 above. So you may have to do this once again.

Thanks for the heads up, but "git rerere" seems to have still coped, so
its all good.

--=20
Cheers,
Stephen Rothwell

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzwpbYACgkQAVBC80lX
0GzYwwf+K7OLwYYZVhBTOJsBx7ulEkvkKcyEg/2GlTiYix6EC+dLiy7gXUbOH9UN
zWX2sWWGjgNCnRmXMWhEU72M0b8joL6Md5YNnDN2aSg7qK3Go5m1xIUQRQMPgM2M
BHEeDHDUrYQ3CUF3ILKZvC7pL7xt657ouKy+WyF0ynlT32EQHMPSR+bwvdsIQX/m
fWJRe3OnyD00buchCeNwo4kyL6vEt8aH08+t+p3nUkGwZ323lyWeUo9pwmCq683e
K4KDYVlWd7mg3N7bvkBhU0bgGSH+rpzePYvk1+QHEoCSAnvDw9sovFl714yMjanV
/8f+dMBd/3iGGrjsrqc3KQwUjYqfWw==
=fIvj
-----END PGP SIGNATURE-----

--Sig_/Iel2uKWbKzZVD/3RL+cnIU/--
