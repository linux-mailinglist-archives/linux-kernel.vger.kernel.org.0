Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0484E745
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfFULld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 07:41:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfFULlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:41:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VcGJ2BnWz9s4V;
        Fri, 21 Jun 2019 21:41:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561117289;
        bh=IJZ9MBhkOnX8UeUtLbRa+iceXBCLLi5U3KV3hQANtp0=;
        h=Date:From:To:Cc:Subject:From;
        b=n+thdKWWhF26yQRPjtlvBt5Y3P5UccVFzi7niBsmYI/11ZMBEV2e0El7oV2WhlZTM
         BEwjml9TeyvuL9l9xTmRKAUywH3eigjfTFNZ4EC5FhC8UuMHme6zeiK8h43fdtVEsK
         arI/kFNuQOY/WFikl3iNWZ1e+UqybthedcBV3UmGNbg12GLHQl2AvUwmASLx9k0tVZ
         nz/5QaNs66gXp7/hkJeK8O8K6e+GkYpCNjsKbFSH21XRZj+KzEsYJYU1vYh2MB9rVv
         apJO8lTD7uNnNquEJhBHQgKUSmHKOcpweOYn9pMDXL5m42eoi330sweMkQrG+EXGw7
         uL1EuBkxzOUsA==
Date:   Fri, 21 Jun 2019 21:41:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: linux-next: Fixes tags need some work in the drm-fixes tree
Message-ID: <20190621214125.6fb68eee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4V3qudpAXLoFUGuq/4lQ8fY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4V3qudpAXLoFUGuq/4lQ8fY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  912bbf7e9ca4 ("gpu: ipu-v3: image-convert: Fix image downsize coefficient=
s")

Fixes tag

  Fixes: 70b9b6b3bcb21 ("gpu: ipu-v3: image-convert: calculate per-tile

has these problem(s):

  - Please don't split Fixes tags across more than one line

In commit

  bca4d70cf1b8 ("gpu: ipu-v3: image-convert: Fix input bytesperline for pac=
ked formats")

Fixes tag

  Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline

has these problem(s):

  - Please don't split Fixes tags across more than one line

In commit

  ff391ecd65a1 ("gpu: ipu-v3: image-convert: Fix input bytesperline width/h=
eight align")

Fixes tag

  Fixes: d966e23d61a2c ("gpu: ipu-v3: image-convert: fix bytesperline

has these problem(s):

  - Please don't split Fixes tags across more than one line

--=20
Cheers,
Stephen Rothwell

--Sig_/4V3qudpAXLoFUGuq/4lQ8fY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MwmYACgkQAVBC80lX
0Gw8/ggAmp6BXM1yok7PGdrUeuZO3ZUpBk7wH0HQF6/IDo4r0Qg88D1cOxcyCCAt
FJAIiQNAAq0mN8VxoNSBhvNKMFfyv60avcxrGNhRq73C8NO4Ivv9Sc1TqcjrdZib
ERO5EBQ/wHYJl14XDnmnM+rGQnzHUS/nLh9bsmi3r84034nXYVuUbyQ8gycyYFFA
J/ruc3Cpmn0kWAmYIWbjUG4VWm47OramSJHJTg1pm4bZ1CF9PgcwTaLQ1z44UlV4
Z3JcOoSML6AJP1EiBvHiUHHam99Hmh3UANlJjOCkMHiFylAOVi9+0KhuxiOeXrOU
TOSo2xgvvZISqx3iD6pPCZ94wnQTew==
=W5UV
-----END PGP SIGNATURE-----

--Sig_/4V3qudpAXLoFUGuq/4lQ8fY--
