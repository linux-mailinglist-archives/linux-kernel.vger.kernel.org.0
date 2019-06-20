Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90D04C742
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 08:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfFTGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 02:10:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34317 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfFTGKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 02:10:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TryK4GJMz9s00;
        Thu, 20 Jun 2019 16:10:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561011001;
        bh=0WhBsC+4o0OLnZMGP8BZUzOQGqtindWRsuVIP+YFVlI=;
        h=Date:From:To:Cc:Subject:From;
        b=m+Rr2+ukya2JmiyV9RpDg+33wy3RC3alZJ2QVaCk0ru6Aie9Cg19Dq69N9WX/s4YG
         qLdErzkjQorspm4Vtc4dZZXtEllTWNlYZG9B8Xin9y99oXVgNCJ01BOHTbMHwX9g3V
         aaPoqYKQoTAiGeus3apc7w0XpdOPoLijQXKkjJs89ZbwkCPMoKhY3xnxhZKhvNkl7k
         ACRqbmYnr6+i6Z9ehASMXJybYGCxuFK5IRf+4+7o2bGDloPE+3ueEk+ajLJiRuKL3y
         c3hfAXaAsCL+nWsYVUyKXPAwoDP7Ru8pwh5wUYjRtVeCE1U8jJ+sNg31n1s0zwxAMt
         kHHCdHweG3ntg==
Date:   Thu, 20 Jun 2019 16:10:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: linux-next: build warning after merge of the scsi tree
Message-ID: <20190620161000.7e5017b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Jj1n2oCW4zjll+uOaCF.5wK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Jj1n2oCW4zjll+uOaCF.5wK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scsi tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

In file included from include/linux/pci-dma-compat.h:8,
                 from include/linux/pci.h:2408,
                 from drivers/scsi/mvumi.c:13:
drivers/scsi/mvumi.c: In function 'mvumi_queue_command':
include/linux/dma-mapping.h:608:34: warning: 'sg' may be used uninitialized=
 in this function [-Wmaybe-uninitialized]
 #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                  ^~~~~~~~~~~~~~~~~~
drivers/scsi/mvumi.c:192:22: note: 'sg' was declared here
  struct scatterlist *sg;
                      ^~

Introduced by commit

  350d66a72adc ("scsi: mvumi: use sg helper to iterate over scatterlist")

--=20
Cheers,
Stephen Rothwell

--Sig_/Jj1n2oCW4zjll+uOaCF.5wK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LIzgACgkQAVBC80lX
0Gzt7Af/e1u6fMbvwkLJDZtwh7G2osR4E+e45qm948F0sW5fM7+A5EltFzpDgreA
xn6DO5tVQrSn5yE7R7gHGdYyO+ZcZS1IsYFBb5g2OiRC0YLTR+5dFIFvWTQWI2M6
rduMQS1B9E+z03k7cL7Ly/pAIAY7VzfKjWAtgFfXfPWdROgW26MJyRKjYhz8zqhV
hNMc58gDeupt9PuiRDcjXVWq6OGnv9bkxp9Y7x5IslDJOiYy/2xCIW9e4doYeaqo
XqRmsZbWCyZg+Y98DMY43gUSmL00rAVDbfBtbFyW/fhkeKWMRBxmSwf2lreOED9t
J9Wp5WgYJSuQ71MZiujQA3ykpTrj8w==
=cR3U
-----END PGP SIGNATURE-----

--Sig_/Jj1n2oCW4zjll+uOaCF.5wK--
