Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8F217E4C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 17:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCIQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 12:29:16 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58560 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCIQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:29:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5B62C1C0316; Mon,  9 Mar 2020 17:29:14 +0100 (CET)
Date:   Mon, 9 Mar 2020 17:29:12 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     jbrunet@baylibre.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/soc/meson: fix irq leak in error path
Message-ID: <20200309162912.GA21498@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Irq seems to be leaked in error path. Fix that.

Signed-off-by: Pavel Machek <pavel@denx.de>

---

I noticed problem during -stable review, and don't have hardware or
ability to test the patch. Handle with care.

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 2f44e93359f6..fbac6de891cd 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -249,7 +249,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *compone=
nt,
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret =3D clk_prepare_enable(fifo->pclk);
 	if (ret)
-		return ret;
+		goto free_irq;
=20
 	/* Setup status2 so it reports the memory pointer */
 	regmap_update_bits(fifo->map, FIFO_CTRL1,
@@ -270,8 +269,14 @@ int axg_fifo_pcm_open(struct snd_soc_component *compon=
ent,
 	/* Take memory arbitror out of reset */
 	ret =3D reset_control_deassert(fifo->arb);
 	if (ret)
-		clk_disable_unprepare(fifo->pclk);
+		goto free_clk;
+
+	return 0;
=20
+free_clk:
+	clk_disable_unprepare(fifo->pclk);
+free_irq:
+	free_irq(fifo->irq, ss);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(axg_fifo_pcm_open);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5mbtgACgkQMOfwapXb+vJefgCeM7d1Qx3cehrDJzEYzLcj4iyP
CKMAnA6pptOXe9GMjiERO2VaCYnThakN
=fqcx
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
