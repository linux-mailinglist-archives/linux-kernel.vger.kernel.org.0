Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D99CFFA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfJHRRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 13:17:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfJHRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4mqdZlErqq2Bt7M06GBMpHKMhqkoX4+sfbP0n/X4pVc=; b=lMSAEjrfE63qh0t7WHODraAOr
        IaUbiWQQMtVkWgxiAV8md1o/YI4HF2g49/9vWuPNyrng5cMit0q3SxXzCglbIPY7cOlDDVGXnWrdZ
        6RkMEVOJYuQjNwj6arZ/pO9KhsYxaK9MPDzXWo75qlo3gy+VPfITfGFtgn8jvfZhyfNq8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHt7L-0000d7-Vs; Tue, 08 Oct 2019 17:17:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 34C8A2740D4A; Tue,  8 Oct 2019 18:17:47 +0100 (BST)
Date:   Tue, 8 Oct 2019 18:17:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008171747.GS4382@sirena.co.uk>
References: <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRtLtq+kfJNLc57H"
Content-Disposition: inline
In-Reply-To: <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRtLtq+kfJNLc57H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 08:05:03PM +0300, Dmitry Osipenko wrote:
> 08.10.2019 19:15, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > That sounds like it might just postpone the inevitable - if you set the
> > wrong voltage first it might decide to drop down some voltage that
> > wasn't expected.  There's a bit of a bootstrapping issue.  I think it
> > would be safer to just say that anything that is within spec won't get
> > changed any time we balance, we'd only change things if needed to bring
> > them back into spec.

> Yes, the case of changing voltage before regulator is enabled seems
> won't work as expected.

> Maybe it won't hurt to disallow a non always-on regulators to be coupled
> until there will be a real user for that case.

I thought that coupling with the CPU core and main SoC power regulators
was one of the main use cases for this feature?

--QRtLtq+kfJNLc57H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cxLoACgkQJNaLcl1U
h9DjLgf9Gvem9ox+y3vOfD+4C0f4CIR0bUNT/g2GkBLpFmcExWG9djaEFeIaXmKh
FBRYi092ZOLmSGhxNxpqAG3+FjYmhj8k+9jlUxfJVLKwehNy89kG9tCT7tQzJRLO
35ZV/rK+GIfgyqWq4B64zzkXJRClUxJviej0Gxgp+pFPakvcbk28iTxUeLoGL5lE
fXBh4nSGvvgMyiN72ZJQG43hcWx5X5wBHQEmyIjCFspqI69SQTFmkz52I/C5h0Tk
ABSznYUeftAKn70ca1kHF2XYogz+5HILCc+IkF4V5LaZhzIQgGe4F7QX3WWIvHtn
zPsltgmkpnhWYap9ItVsU0j5xOu9Ww==
=XoKN
-----END PGP SIGNATURE-----

--QRtLtq+kfJNLc57H--
