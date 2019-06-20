Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4C4CADC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFTJ3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 05:29:45 -0400
Received: from ozlabs.org ([203.11.71.1]:33263 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfFTJ3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 05:29:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TxNj40Q7z9s3l;
        Thu, 20 Jun 2019 19:29:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561022981;
        bh=K59OXEootkBW9/39ic60PcVuvJF1I7LsPOVfv1qbMPE=;
        h=Date:From:To:Cc:Subject:From;
        b=svCCjT6AsCF3x8LpPEOWxrWmQPgZz/qcS16fhNt71m95GWzTY+8aJVBveiFcov815
         q/8lPJD4byQaNEHefde3klVVCl7uzY3aEFSIFaenckV/SZpWP1lbNV78qx4Gb1rmxZ
         JAMo4vXDSxb05vPNmQNDCJ0z9gy4M8TxldtTEILdn+DVvfzpoYuU7U2Na0lwX9iaWn
         oVccTozQlGL6npQFMCXIS/7At4J3Pvw8yXuB61d9Z0WRj+UugzEVsmyl5xIAFzi+Mk
         Ee1LrqMwdmDtGztaGzOIpwVVSawNgmgIQ7RLBen92kztk2JT/gYN0p/rezWNnEWvRD
         nOsxrGTDa1mpA==
Date:   Thu, 20 Jun 2019 19:29:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pankaj Gupta <pagupta@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20190620192939.139bf5c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4KtIhbTHIDjH6/JTpyQoNoR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4KtIhbTHIDjH6/JTpyQoNoR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

After merging the nvdimm tree, today's linux-next build (i386 defconfig)
failed like this:

drivers/md/dm-table.c: In function 'device_synchronous':
drivers/md/dm-table.c:897:9: error: implicit declaration of function 'dax_s=
ynchronous'; did you mean 'device_synchronous'? [-Werror=3Dimplicit-functio=
n-declaration]
  return dax_synchronous(dev->dax_dev);
         ^~~~~~~~~~~~~~~
         device_synchronous
drivers/md/dm-table.c: In function 'dm_table_set_restrictions':
drivers/md/dm-table.c:1925:4: error: implicit declaration of function 'set_=
dax_synchronous'; did you mean 'device_synchronous'? [-Werror=3Dimplicit-fu=
nction-declaration]
    set_dax_synchronous(t->md->dax_dev);
    ^~~~~~~~~~~~~~~~~~~
    device_synchronous
cc1: some warnings being treated as errors

Caused by commit

  38887edec247 ("dm: enable synchronous dax")

CONFIG_DAX is not set for this build.

I have reverted that commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/4KtIhbTHIDjH6/JTpyQoNoR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0LUgMACgkQAVBC80lX
0GzxNAf3Qf1H6IS0CTWobhKTsaAIDGl5vnmUL3zJbOvM88FO0YUcnkvznZr6SWK8
5b7nZEXopjnAnhIxw1tnau2JL17ToJ5/+du/pUSHyhld48H054fDc0LD0P8dvQ4I
gwdbgkHXHFH5ZRXzWxjJwU+DWaKG53oHyD+ww9nTHnz0qSxPNHyC0jUlCoPcuagE
L51MucbLDZRUTeEnlyoVOYUWzKCSUXT2jhh/h29vvhpapA1lU74BNIcLsHjZhVFW
MEx3nWw7yaDL63Kq7hWN8m5y0ZVlb8C7GeeGpqf7ycu/WdrzlYWLkrscq7l58b94
lULd4ogV5nc1Y1r9E5/6le2sQdcx
=ilBF
-----END PGP SIGNATURE-----

--Sig_/4KtIhbTHIDjH6/JTpyQoNoR--
