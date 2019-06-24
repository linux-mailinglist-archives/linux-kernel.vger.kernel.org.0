Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60301503F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 09:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfFXHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 03:47:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfFXHre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:47:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XLwz1Ysqz9s3l;
        Mon, 24 Jun 2019 17:47:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561362451;
        bh=Q4ISCzQVs7t3mt7+gvWch2GIu0OdDl3uEWJoPdf9mGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCbo4+qQ+mRLKyyb7hekaoEwBmOMUM7rW9H6yOI2BU1QUPMNNkV55fKryjCYzZJA+
         okTbqRJN2urhsTCXDUg0wRAxI580L7ybD9Zoi6kobUqCnHgtPQdFEmAFGQFzOKN5Up
         P7FQuzoqF1TUYyxa4h7tR2HonJoByOj/ZoaIfJp86pmGMV3iWwskvAMaZGAnr2QCOt
         rWJdPR49go/oRCB2WmHghcx2kiF4fdP0E61YEs4SwKDe6/xPalDxdFYKJ8u7r/1D9k
         8wo/5hbUZ9yT/w3YIQbEskNnsM9/tzadb4ar2COcNTZpP19EHynWV+rFy4YCHfhBJW
         5+Xnt93bdczyA==
Date:   Mon, 24 Jun 2019 17:47:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the pci tree
Message-ID: <20190624174729.327f2edf@canb.auug.org.au>
In-Reply-To: <20190624073443.GA13830@kroah.com>
References: <20190624171229.6415ca4f@canb.auug.org.au>
        <20190624073443.GA13830@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qrQUjtNwL=N=cvqZV=EIBV+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qrQUjtNwL=N=cvqZV=EIBV+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 24 Jun 2019 15:34:43 +0800 Greg KH <greg@kroah.com> wrote:
>
> No patch "below", but I'm sure the fixup is fine :)

Sorry about that (not sure what happened).  See below (t is trivial).

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/index.rst
index 239100accbf6,91055adde327..000000000000
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@@ -101,7 -101,7 +101,8 @@@ needed)
     filesystems/index
     vm/index
     bpf/index
 +   PCI/index
+    usb/index
     misc-devices/index
 =20
  Architecture-specific documentation

--Sig_/qrQUjtNwL=N=cvqZV=EIBV+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QgBEACgkQAVBC80lX
0Gzv3Af/TVBkW/Tw3vaFfeF1u90GjPYU96oIBznrtksEYHu6pWgditckMVEtR5ZR
FompAZc9lff/a925QIY7UU29ly2KBJ6l0YG1engRUzsUGsTpdT9A1aHnqMiWBocf
D1ZDRAvtjfUFSlqEHpuNI8gvL78kuivX+Nj1b2N14ZwOk59QTskCvgN/tujLAj3n
6IUa2w4EKyj+SVnUhFW10yHttiSWQQL/bjUDDpY3Fb+MXlHRUb2XZX5Ad0Yt0Gpt
otw+9ITbnt8LBaUhaNXGUh3pfTHUFkFchMMwb7x1PoxgPxKOEXER/8jPBJRUo2ki
i7Q9vrTuAKZArOorCfu8RfHU0I8h8A==
=nckV
-----END PGP SIGNATURE-----

--Sig_/qrQUjtNwL=N=cvqZV=EIBV+--
