Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DAE33EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 08:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFDGCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 02:02:05 -0400
Received: from ozlabs.org ([203.11.71.1]:43691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbfFDGCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:02:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45J1XV4hT5z9s1c;
        Tue,  4 Jun 2019 16:02:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559628122;
        bh=QmUEdiCZy8KScyRjadMIzXOhxamIsaJsSVXTw+rv4X0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CT9ycWKNi3XoAKNZsuGx93XjwBUUSKRVl7sLBiQlaoba5YrpEVI7hxzAlv8ORfFEs
         uTpijtENhOFicgKb1r++UQgD7yU9w8CsVMIVC5fGLPFKy2JHCS+Sog2fHAb72RDGzX
         QPycU376MW006rJS6bW848UAsAhVHXFvvCVPCGqkFT4yLQn41/HJgj/HiSmaSkSuKB
         P7CxmpLY34lGEs7ufCdvT8oMS4N3CL+Woqyq7NdNrOxRfXOq4ptes5c7RXnIvftYvq
         79ryhx11FmcZx+1QQf9pnPQvapud8ShuSpycPPQ/52ZJuf+AIzkQpWTjRLMFmtaET0
         j+zgmXqBrY8ag==
Date:   Tue, 4 Jun 2019 16:02:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: linux-next: build failure after merge of the clockevents tree
Message-ID: <20190604160200.53bdf2c8@canb.auug.org.au>
In-Reply-To: <6592f64c-79c1-7ac4-dfa5-499362539319@linaro.org>
References: <20190603121350.653cacce@canb.auug.org.au>
        <6592f64c-79c1-7ac4-dfa5-499362539319@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=ThhywD3kNJlb7gyGjZmIPI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=ThhywD3kNJlb7gyGjZmIPI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, 4 Jun 2019 07:56:45 +0200 Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>
> I dropped the patch from my tree.

Thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/=ThhywD3kNJlb7gyGjZmIPI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz2CVgACgkQAVBC80lX
0Gw9SwgAjgufUU36XEzHKnStWSaTeI4dN1xdzs6rhq41ueRX/9GjXC9Lc4KivC8V
8DY2xaUgaDQUrxp5bnV8gtqrNjbeo19BNPlIithEKGoV72MB6wZK9M4JHdP6FFvv
v6qbXK8ARMGH7myR/a25vfbLxj9DxQzTKwElx87wEmTixvP5v9BjeUAKYsONS9ds
2yl+YIq7hglcX8bZpD9ETS1ca21gTixZ3wV6yN65GMMcm9/J0VfQRQwty7/6MBVl
8ZDsbQznC7ghuNhe4DUdloUwZ/PSlW64BneNnmKgNs3NboCmiteCN3nMOJEn+eTL
kyieIVg+f7HAh4RYdZTuALEBBLckPw==
=TiyF
-----END PGP SIGNATURE-----

--Sig_/=ThhywD3kNJlb7gyGjZmIPI--
