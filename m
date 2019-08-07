Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C60842DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2019 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfHGDV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 23:21:26 -0400
Received: from ozlabs.org ([203.11.71.1]:56639 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHGDV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 23:21:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463GxZ5nJlz9sNm;
        Wed,  7 Aug 2019 13:21:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1565148083;
        bh=Zj56/N6J9SqSEYqx4TFSlTMJwiW/FCBC7anYs5vZGTE=;
        h=Date:From:To:Cc:Subject:From;
        b=Cr8l9KKSRD1cgAFy73xZ6XxjUMfZf0bzV6yACwmcV1XhGCyHVlNCxBhFw3gpar14Y
         Nn4ZILYLnI64wGUrFMOnAxk75JU0XoQjDPDRA3aIUCH5Z0IsolOZIOUb8HtHw6GWBX
         UL2ji/Z/KWyG2qH7HQRlAmfwjHP1cQYkEF0cyw8yffl8EsAVojwT0MYU0GbdoJR+Zt
         Jm7PT5O5Pf1HqdRh2Y2I0Y+8+DCk9elrAZXpDcjC6CeC85EhOUFzIjscovAhAKMcGY
         hAWjZY01KSl3Oectk9Niod6S5Giwj4V2MBi0+pWarxbCEX4k2S5j6w98pAzhV1NRTC
         1Ojq2muakB/tg==
Date:   Wed, 7 Aug 2019 13:21:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190807132122.698277b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CDHrW63E0.twJ01h6XrsSgb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CDHrW63E0.twJ01h6XrsSgb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function 'amdgpu_bo_release_=
notify':
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1245:28: error: 'struct ttm_buff=
er_object' has no member named 'resv'
  reservation_object_lock(bo->resv, NULL);
                            ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1247:47: error: 'struct ttm_buff=
er_object' has no member named 'resv'
  r =3D amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->resv, &fence);
                                               ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1253:30: error: 'struct ttm_buff=
er_object' has no member named 'resv'
  reservation_object_unlock(bo->resv);
                              ^~

Caused by commit

  5a5011a72489 ("drm/amdgpu: switch driver from bo->resv to bo->base.resv")

interacting with commit

  ab2f7a5c18b5 ("drm/amdgpu: Implement VRAM wipe on release")

from the amdgpu tree.

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 7 Aug 2019 13:17:54 +1000
Subject: [PATCH] drm/amdgpu: fix up for "drm/amdgpu: switch driver from bo-=
>resv to bo->base.resv"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index b2c03be51c29..2d07f16f1789 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1242,15 +1242,15 @@ void amdgpu_bo_release_notify(struct ttm_buffer_obj=
ect *bo)
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
 		return;
=20
-	reservation_object_lock(bo->resv, NULL);
+	reservation_object_lock(bo->base.resv, NULL);
=20
-	r =3D amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->resv, &fence);
+	r =3D amdgpu_fill_buffer(abo, AMDGPU_POISON, bo->base.resv, &fence);
 	if (!WARN_ON(r)) {
 		amdgpu_bo_fence(abo, fence, false);
 		dma_fence_put(fence);
 	}
=20
-	reservation_object_unlock(bo->resv);
+	reservation_object_unlock(bo->base.resv);
 }
=20
 /**
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/CDHrW63E0.twJ01h6XrsSgb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1KQ7IACgkQAVBC80lX
0Gx9xQgAnT0UG7gTC4SWsKJsckbfUk5lxfcwSny+VZR29NGb3WjT4YzhiU/Xnbdw
J5Ifvhnu8JGxHQgv+/0x/2tE1jfK7LssrRYXbzu/0KVfgOLIe1IGEJ3a+rxoIM7x
QShhok2gWudajNFMdS3zD66JDVk/u/F0hvduM4SQSBES1fEwqFSbZWbQecol4OTm
RSfLRGcyZhpvRqbuI2xTHloswHQHsRFSU6f3EGwaClQnEdYJFiUV2E7rGGROd7QP
fXTY08hV0wUOdAuoBFRJRyNakaoAK/Qe1LprR4uG4FCyWo+Q/E6xOJ5AchhHCHC5
onh3r3kitOFYGwOANgcbPldfVYHsuQ==
=OTBj
-----END PGP SIGNATURE-----

--Sig_/CDHrW63E0.twJ01h6XrsSgb--
