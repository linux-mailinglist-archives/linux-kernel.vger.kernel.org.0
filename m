Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D963B7037E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 17:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfGVPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 11:19:31 -0400
Received: from ozlabs.org ([203.11.71.1]:60547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfGVPTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:19:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45sldW36T1z9sBF;
        Tue, 23 Jul 2019 01:19:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563808768;
        bh=bSZtbf5GaG1T1HT8834pDCpSu2DjDLDm/Ehs0z+A4qM=;
        h=Date:From:To:Cc:Subject:From;
        b=GKo6Rs5SBQBLgJ6YbZCb5Vux51qOFZx4CZulIlyVpfD57606ZlP6qSk7dXB/KQqii
         CK5oKctOpQQjpzjLG5O4YR1CeVYJN4E5ylJNrydIGRyi7cI0H7jqcDcMA6EJuFuk4/
         bCbICWQjZid/16sJml6Y6pFkaJBgQNaShjwkoZEoNZo0Dl7AYKj8xnwWfqFfaY8eVU
         xW7itpZVX4UBIQ2j3g7oRMEbiyfMyombwNmNocKFa5K9pBvv4pogycPurd7iVo5/BF
         v+Sad7eZtLsSMw8lSb7/SqgqptUwu+NdUS1LpXJPDvLEdih8VwCeZ1j23uLQxn2RKD
         qOZu3JUYtO9Rg==
Date:   Tue, 23 Jul 2019 01:19:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: linux-next: Fixes tags need some work in the sound-asoc-fixes tree
Message-ID: <20190723011920.78ade6dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3_/hqmPiRpU05D/=PH/cqin";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3_/hqmPiRpU05D/=PH/cqin
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  52db6685932e ("ASoC: simple_card_utils.h: care NULL dai at asoc_simple_de=
bug_dai()")

Fixes tag

  Fixes: commit 0580dde59438 ("ASoC: simple-card-utils: add asoc_simple_deb=
ug_info()")

has these problem(s):

  - leading word 'commit' unexpected

In commit

  6cd249cfad68 ("ASoC: max98357a: use mdelay for sdmode-delay")

Fixes tag

  Fixes: cec5b01f8f1c ("ASoC: max98357a: avoid speaker pop when playback

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more tha one line. Also, do not have
blank lines in with the tags, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/3_/hqmPiRpU05D/=PH/cqin
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl010/gACgkQAVBC80lX
0GzuTwf+ORbxIwJ/suZmP3jDL2AUrH1I2OAFkbB5D3HsbK0RKGCccPom9PbQvnrC
kLmUJq6M6UYo/CcQN90ZPcfxpO3/TWYww2RWtD3Rnd2eHI0bQOxEXnaZN9ejxjmG
fSvyhwuHj3U9cZRrNxeoMvg1xAT4OZSGcqRKSjACCbHtg1qISZOpVIHtP0JEbVIq
usjvV3KGhBvPIDjuBvJxXgqhORnZhITHTeicAOQNhBzyYuEGKs/nuAmFuvM9sf/x
3tvgVzF2m/HSjJXQNnVNmy4HwX3Ma0SZFjtXB0UwxgPAjBnbRHe332OLLp+i8e++
8p4nLwNSz28IuNN/VapTWFa+bxVqpw==
=Dl/n
-----END PGP SIGNATURE-----

--Sig_/3_/hqmPiRpU05D/=PH/cqin--
