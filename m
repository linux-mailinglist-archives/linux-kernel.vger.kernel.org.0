Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F53F2ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 14:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfKGNGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 08:06:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55974 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfKGNGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=31tH8imhyAu65xFR993XAkvnUKdU7S1CP1JaRPRgook=; b=eHLSutooyCgBVdcqx8X/iUgci
        3vaFocBU/uewl/9xNXdLiOB/QlBGLufMrd0QfKYhdBtIkRVOXog/tRqbx2cneXxaTlBWtqWefBu1c
        1P8uOu48nIvAIRYrl7zv84Ahnz1LJJTUDASqncItmJ9LWMPbq4/Py5qJWhVUj23PoV+Js=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iShUq-0004MO-V5; Thu, 07 Nov 2019 13:06:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 2584C27431AF; Thu,  7 Nov 2019 13:06:44 +0000 (GMT)
Date:   Thu, 7 Nov 2019 13:06:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org,
        stephan@gerhold.net, Barry Song <Baohua.Song@csr.com>
Subject: Re: [PATCH 1/1] mfd: mfd-core: Honour Device Tree's request to
 disable a child-device
Message-ID: <20191107130644.GF6159@sirena.co.uk>
References: <20191107111950.1189-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <20191107111950.1189-1-lee.jones@linaro.org>
X-Cookie: I've read SEVEN MILLION books!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 07, 2019 at 11:19:50AM +0000, Lee Jones wrote:
> Until now, MFD has assumed all child devices passed to it (via
> mfd_cells) are to be registered. It does not take into account
> requests from Device Tree and the like to disable child devices
> on a per-platform basis.

Reviewed-by: Mark Brown <broonie@kernel.org>

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3EFuMACgkQJNaLcl1U
h9DOfgf1EfrL7iW8jYtk5Biqjwei6g5GDnp8DyidE4DXUkMjga1au5u+4zBxmuwG
fwKP2lcJOi5mFF71oN83bftFA2tQatKTqhQJH9sbd79xKpqknQNknos/38eZiikc
3mmCJ/lZZuX2HkL3Yyk8IN8JFCO8KayOp07AfBM/6jMpBXxJfuM+DOi5Xjajdf0r
VrOhwOp937yMePl8MwIB3l9F1xYB5Sf1CJkAOa85ir+reKIeQlwFOfN7bpkl6N3P
nGdvkRcaT1bcDTKmyuLrU9eLb9sPxD1lz9etFroyg3Cyjz8qU8cWXlBPpGuu39pi
D+SXLyMrkGYOUaWgEYmrzC2dH2vg
=n1Zs
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
