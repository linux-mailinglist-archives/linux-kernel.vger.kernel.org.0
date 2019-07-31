Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00B87B984
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGaGL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 02:11:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56005 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGaGL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:11:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45z33X43prz9sBF;
        Wed, 31 Jul 2019 16:11:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564553512;
        bh=BjGVFtlHDffJ7rNUzNSRvEZev0OoghzFDZvrQIGYrlg=;
        h=Date:From:To:Cc:Subject:From;
        b=dutBWZG6JSlQl0tId0rk9wVnhMEf93gl2wtG5T4vGQjtDfSMWMtcxdCSnPoa39VmP
         6WrMDiBNfQnVrUUa/d5ARAGdqmSNsF+z+/lAHvpzpU31FDYq7KwJii42cOYE/nwAmF
         3uw8tInpAIq9fyxTKE5sVGyjz2EhY/PzT/Dk89oO0kt8SJ+Xl1Oaz3oX8e1eia0IwQ
         GoVYdJuZRe8qd7DfjIs8OGNuaYIEjMCkVuzW/AwEwN6ERhVjjM2DkK1Y9yisafUSkK
         FP/SaLOQTHE4MX2JHCoZbkdl6nuNT8gfwKmhoT1BuCQOvNp4NbClcQPYKqkvFdHnUK
         RzqCVKBdDPd8g==
Date:   Wed, 31 Jul 2019 16:11:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190731161151.26ef081e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FG1oMfjCeT.q.0KjWWB07ay";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FG1oMfjCeT.q.0KjWWB07ay
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

mm/memcontrol.c: In function 'invalidate_reclaim_iterators':
mm/memcontrol.c:1160:11: warning: suggest parentheses around assignment use=
d as truth value [-Wparentheses]
  } while (memcg =3D parent_mem_cgroup(memcg));
           ^~~~~

Introduced by commit

  c48a2f5ce935 ("mm/memcontrol.c: fix use after free in mem_cgroup_iter()")

--=20
Cheers,
Stephen Rothwell

--Sig_/FG1oMfjCeT.q.0KjWWB07ay
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1BMScACgkQAVBC80lX
0GyFWgf7BW+k6r2+GOn4Czp4nkgTkq6jKiN5xddJd9LbyfbJcN3Xe9fsS48wseaG
gIaMImOyGgSXZkbm1pDZh1Q9se+sfXUlhQGB88KTw2EwzJZ9r4i8eetJLaRPH8nv
xiLyl9FUMvPNuSs9sXOo1JCHH2/GXqGwE7Ey1dx18/XMuBsj5l6/gTuPw4zlQY3t
Lc3NiLNF3CcblGe/M868Yz69/AkwaiKZTQk+4jh/WPpOmqndLJ6iVxJAP3d19p35
MW8YKT41pvKehAgfbO26obs89GN6hfZtVPr4+P0Y0Lc4ixisX/MOlPG1Ig5pLIkK
RfpE8/cUKYMaPrL6kiCh+H39CetAcA==
=is5d
-----END PGP SIGNATURE-----

--Sig_/FG1oMfjCeT.q.0KjWWB07ay--
