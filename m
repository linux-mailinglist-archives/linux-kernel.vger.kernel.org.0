Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6285C20C97
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2019 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfEPQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 May 2019 12:09:45 -0400
Received: from anholt.net ([50.246.234.109]:39970 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfEPQJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:09:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 2ED4610A3516;
        Thu, 16 May 2019 09:09:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MnM4LX1VAciX; Thu, 16 May 2019 09:09:43 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E0D3310A3478;
        Thu, 16 May 2019 09:09:42 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 56A602FE3AA9; Thu, 16 May 2019 11:09:42 -0500 (CDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v9 0/4] drm/vc4: Binner BO management improvements
In-Reply-To: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
References: <20190516145544.29051-1-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Thu, 16 May 2019 09:09:39 -0700
Message-ID: <87zhnm1iv0.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Changes sinve v8:
> * Added collected Reviewed-by;
> * Fixed up another problematic case as discussed on v8.

I think this is ready to go.  Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlzdi0MACgkQtdYpNtH8
nujdBQ//VPW+1gMNzDYIfpDvDr/na0v1xDiS9WknV4ahnTVQpDNzR/IytYXNrs+y
2y3Oex+mpo7AXdsOgajXN0sdTV931+rBssiCT78TvP8wO4A0DScaY0dpkC464L+N
7YY3PA/LL52B4Wwto5Zf27M4jgNs1YurtxTGptpqR5mc4HpjG4MZeoBdkcDIn8XU
MyeY1m6gVDeUMXb3i1rOjaDSwe6fY7S3Kxz+i9wUQFAGsjCZKlKDsI36X5cQ20j8
FZvRCA4GPyOs+BVW9oXu0dmjV3hv4K9G4MZATArfK6VhUmed7pwD4hirfjFsHa5c
EM+mqognki0HOohp/W0V1MzBB7ShRcVeZLjH5ZcbI36O55NvwmXDYhMzfJoEOvN+
fXLNY7T+yzYD/Cuo/w8BLPO7likUvNEX+IZenAOvd+dh6qhdTQYrt9YZPc4ktdhK
MYurOKb44Ik+Nr9d9VCxUDC31I4Ml6t2/5gMLUwC4VuW7RkeDHvtth1XYvwVg21c
snD1H98uDzm4KAmUDIsuJubu/A4oFdhAUGG5hEoJmkVpYal0apjxy94FfEeNRLDZ
kwkr1GzDyQb7GC7R4r3NhQP1MXtFflmq9btZPGNMpsB46hjwuitC8eDT+gP6PyYX
Fz/nY3Pn0LFkbIxoKWVyZjI3sUMMrLldwKewOOvOnIn/Gf/cNdw=
=EdI/
-----END PGP SIGNATURE-----
--=-=-=--
