Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 627EF90D96
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2019 08:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Aug 2019 02:58:38 -0400
Received: from ozlabs.org ([203.11.71.1]:54951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfHQG6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:58:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 469WHb1gbnz9sDQ;
        Sat, 17 Aug 2019 16:58:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1566025115;
        bh=IgDPuugh05x57YEiYN8l0nhY63HAUdNvpnSeuQDLtzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PDUnjM99KXvRE/LY1XQl8szCrxOwfSSMNms7ZMIibixxcCVDs9T17uSzkBz5tvS0s
         cWTYRzY4vTs1EEjnnbFmUDFMsCrh9TnTubPFYiQbfLessT+i4bXUs2qHNJ0XBzvYnN
         QCsjPqAbva+NZv29Ro0m5bevRnB84TTmDtRXt/ACYmUB8ov95ERNdqMLzlpBL/Il+i
         yFvDS8BSXlRXIPqQkp/7PRk+0ItnOK5qeI4sJTo3QDVo+HDXQJgiXzkMBt0rMYLoTB
         duyAXrgHUw21TMRX9o32n+IiSM/OvW9/vhSCz1p2xSJR7BkRx9xTZ+NZzSNlzPIJt3
         z2hpwAzIfqrow==
Date:   Sat, 17 Aug 2019 16:58:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-ID: <20190817165833.369c943c@canb.auug.org.au>
In-Reply-To: <20190817064301.GA18544@lst.de>
References: <20190808154240.9384-1-hch@lst.de>
        <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
        <20190816062751.GA16169@infradead.org>
        <20190816115735.GB5412@mellanox.com>
        <20190816123258.GA22140@lst.de>
        <20190816140623.4e3a5f04ea1c08925ac4581f@linux-foundation.org>
        <20190817164124.683d67ff@canb.auug.org.au>
        <20190817064301.GA18544@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iX30a6+fK46SGJZm6D6NOuh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iX30a6+fK46SGJZm6D6NOuh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sat, 17 Aug 2019 08:43:01 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Sat, Aug 17, 2019 at 04:41:24PM +1000, Stephen Rothwell wrote:
> > I certainly prefer that method of API change :-)
> > (see the current "keys: Replace uid/gid/perm permissions checking with
> > an ACL" in linux-next and the (currently) three merge fixup patches I
> > am carrying.  Its not bad when people provide the fixes, but I am no
> > expert in most areas of the kernel ...) =20
>=20
> It would mean pretty much duplicating all the code.  And then never
> finish the migration because new users of the old interfaces keep
> popping up.  Compared to that I'd much much prefer either Linus
> taking it now or a branch.

Sure, I have no problem with either of these two choices, or, at least,
hints/resolutions when conflicts are expected.  My time (each day) is
already getting pretty short since we are almost up to -rc5 ...

--=20
Cheers,
Stephen Rothwell

--Sig_/iX30a6+fK46SGJZm6D6NOuh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1XpZkACgkQAVBC80lX
0GzXcQf9HYr6iyLSWWl6YlnndTg8ZfbycnJCmqM6lBYVCOkuVySHLdB4Eu2McHZv
DYKUMhRtQ3Mll/VNFZeeEDGrSLR3mhbLBT+BudyUeT/yeSkTQZifX9lXacio/4yk
SarLK0SXRZx2sI6LjoQ8iUzEhX8clDCcK1yO+qlyZEtGUt06JeKC+KJwWf5Rg6eC
zW7lGPDRr01bMwxNWbthufjq2NxHheaD/fPdKfUSd5byxSY70W992VuI733WwdCK
68fHAEOsFsyzTmQguV1vkF7t9bsLslj9aIYUvBOfx5EWjQ1ktJ+76qYGlyeVe6HH
6dOh9g3EbXB6FL6GtvGxnor89gnNiQ==
=2W8r
-----END PGP SIGNATURE-----

--Sig_/iX30a6+fK46SGJZm6D6NOuh--
