Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0FE13A9A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 13:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 07:48:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37586 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgANMsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4GqE2Lx+k2JThlIRuOZwkWMYwse09vSDmRyJ5N5ET+Y=; b=wuNFl2uWonj2S+6POiWKI5XZR
        4NUVe+SH2fp+SGWHoc8NPzlC26hmsxUaZuoImIWN0KxpfX4QevXRtioasxq8Ln8OPxr7lpqmc5BpO
        ZQnXJIriMGj0VXxVl3aDQSJtgB19WAxawavOQcslxGV9YJnMy5C2sitp3Lj26Yw29NUfQ=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irLbl-00085w-9b; Tue, 14 Jan 2020 12:47:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id F3D37D01965; Tue, 14 Jan 2020 12:47:44 +0000 (GMT)
Date:   Tue, 14 Jan 2020 12:47:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeff_chang@richtek.com
Subject: Re: [PATCH v6] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20200114124744.GT3897@sirena.org.uk>
References: <1578968526-13191-1-git-send-email-richtek.jeff.chang@gmail.com>
 <s5htv4yfpnt.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H88uUF932U8Oj0a6"
Content-Disposition: inline
In-Reply-To: <s5htv4yfpnt.wl-tiwai@suse.de>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H88uUF932U8Oj0a6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 08:44:22AM +0100, Takashi Iwai wrote:
> Jeff Chang wrote:

> > +	if (ret < 0)
> > +		return ret;
> > +	reg_data = (u8)ret;
> > +	if (on_off)
> > +		reg_data &= (~0x01);
> > +	else
> > +		reg_data |= 0x01;
> > +	return regmap_write(chip->regmap, MT6660_REG_SYSTEM_CTRL, reg_data);

> Hm, this looks like an open-code of forced update bits via regmap.
> But interestingly there is no corresponding standard helper for that.
> Essentially it should be regmap_update_bits_base() with force=1.

> Mark?

regmap_write_bits().

--H88uUF932U8Oj0a6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4duHAACgkQJNaLcl1U
h9Buowf/UyFuv5m4kkR3mDh23iVqGGfCUbs52vx5O6dxillJ76kZ71N7Vg2LPrOq
c9B8A7CLb2Ao2pTBr3o1ZONyZiRm1L+5OqyeZZzSnUnuECVsQASRgBpssbrUINHV
p5rY6kKIF5dKZGOBjmZWHSNjZ8GgC0BW4Si0P5WH0k7xDHlUsXQHiz47YXWcHQ2d
zjenB+X5Kg74bvJ6uh+5KM0kqhQPKSHw33HR7DejUQQMyQFQtNtQVkebVEXnMM6/
sItgCSyukh8F9TTWI6StXdTeJvcveaa1VUAqu68nImD0VL2im79DbbPzoMks/29G
GORmKiyK82lF0hw6y6zwOcga3GD/KQ==
=xw93
-----END PGP SIGNATURE-----

--H88uUF932U8Oj0a6--
