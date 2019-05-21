Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADBC25A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 23:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfEUVnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 17:43:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37481 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfEUVnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 17:43:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 457q5022KZz9s3Z;
        Wed, 22 May 2019 07:43:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558474998;
        bh=VLslGDXi1nLS5zOC5e0unUn83VnGb1HeqayhR5MbjPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVfVn6vCR58ksGTm3Kz62mvFD/aP9HM8dyGBXIH3kCo+noYxJKuNjqMHduISxr3Zz
         JAvv9T0uL+iBybdOBQioSUVBMudd6JuroiJGJ/at8j7IcG6K312zjXIdI8fqXKoWqY
         YNBNj7VA6JjU1ZMHCylxbfCoe4Qnl2qIQ1G8njC+0xIZn9JNeimdr4p2jt/+m3aV5J
         YfoT/TViq3MHC8mnivf70wb4ekHfXmTCkhPLM2JWh9o5UxEXjuaQgULB5m31ssiwtt
         hsDHW31paQ7k0I0GI3aiZYmOOH1rqxIY88G/2otEjSUv6ik4Oj+qKMmaN2QvrYdOXi
         jviTLZ4q8fMLQ==
Date:   Wed, 22 May 2019 07:43:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: Comments in Fixes: line (Was: Re: linux-next: Fixes tag needs
 some work in the drm-intel tree)
Message-ID: <20190522074313.347f039a@canb.auug.org.au>
In-Reply-To: <155844385673.15761.3434506339174536733@jlahtine-desk.ger.corp.intel.com>
References: <20190520221526.0e103916@canb.auug.org.au>
        <155844385673.15761.3434506339174536733@jlahtine-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=1dxdUJ9WnawpF7=6CXdUXL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=1dxdUJ9WnawpF7=6CXdUXL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joonas,

On Tue, 21 May 2019 16:04:16 +0300 Joonas Lahtinen <joonas.lahtinen@linux.i=
ntel.com> wrote:
>
> We also have an incoming patch where the Fixes: line has a comment in
> it. Does your tooling account for this when checking the Fixes: line?

I will make sure mine does.

--=20
Cheers,
Stephen Rothwell

--Sig_/=1dxdUJ9WnawpF7=6CXdUXL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzkcPEACgkQAVBC80lX
0GzFlwf+MRLCmFgKUnLP3fJYw0qVudP2JJ2+wXN3AJcl4p302jwHHLs34RTTSeN7
pxoR0xFFeaAIqytLYGfizowqX86Qv6dxiRTckoPuE3uw+SH76lcwQtZzgDTppYgo
axsQxTaRStKFYun8p8SNZdFfZF8BuI9kTl8OhUcrysVs+57v8etyZ+XyZspvzVQN
XR9Z4bIb1aufYEVJq0ygaQ0iCXzvfZOoeZdqrAJ+YWVwaG5D2G/JruOuDOU62E/D
tcYcQmFSO9Ry3hsbOWAgzAL4nU8XR9Xwem2gJmg+1rqBRIOhCj3/ZTtR5ODnFA8Q
IV3Uyqjc277gqQaOeVjGG8KCP+x4cQ==
=fjIr
-----END PGP SIGNATURE-----

--Sig_/=1dxdUJ9WnawpF7=6CXdUXL--
