Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5232E15290B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Feb 2020 11:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgBEKWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Feb 2020 05:22:42 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35112 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgBEKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/rtlxdlFXFw6Im6mj5PCy/VNag7UxeRqSrkOJffVA38=; b=P27fPpAO6EuAqKJkVen6Iqg0M
        4+zR4tbt/Lpfp3hs9Krjct35yrPGoCBcojIOwYeBSX0hzfyjh3Xh1elPHcm86yY7xV3NcIB/XgejM
        XnHftV79L8ej6ObvVtWWqLUFUmBBuYuMSN2zsuTDQYiUWcmHxtdm8Wa8MRcxwGUyfi6Bs=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izHpP-0003xE-BT; Wed, 05 Feb 2020 10:22:39 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 07415D01D7F; Wed,  5 Feb 2020 10:22:39 +0000 (GMT)
Date:   Wed, 5 Feb 2020 10:22:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: wcd934x: Remove some unnecessary NULL checks
Message-ID: <20200205102238.GG3897@sirena.org.uk>
References: <20200204060143.23393-1-natechancellor@gmail.com>
 <20200204100039.GX3897@sirena.org.uk>
 <20200204193215.GA44094@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mOr7kNv8EL30+EI+"
Content-Disposition: inline
In-Reply-To: <20200204193215.GA44094@ubuntu-x2-xlarge-x86>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mOr7kNv8EL30+EI+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2020 at 12:32:15PM -0700, Nathan Chancellor wrote:
> On Tue, Feb 04, 2020 at 10:00:39AM +0000, Mark Brown wrote:

> > I'm not convincd this is a sensible warning, at the use site a
> > pointer to an array in a struct looks identical to an array
> > embedded in the struct so it's not such a bad idea to check and
> > refactoring of the struct could easily introduce problems.

> Other static checkers like smatch will warn about this as well (since I
> am sure that is how Dan Carpenter found the same issue in the wcd9335
> driver). Isn't an antipattern in the kernel to do things "just in
> case we do something later"? There are plenty of NULL checks removed
> from the kernel because they do not do anything now.

I'm not convinced it is an antipattern - adding the checks would
be a bit silly but with the way C works the warnings feel like
false positives.  If the compiler were able to warn about missing
NULL checks in the case where the thing in the struct is a
pointer I'd be a lot happier with this.

> I'd be fine with changing the check to something else that keeps the
> same logic but doesn't create a warning; I am not exactly sure what that
> would be because that is more of a specific driver logic thing, which I
> am not familiar with.

I've queued the change to be applied since it's shuts the
compiler up but I'm really not convinced the compiler is helping
here.

--mOr7kNv8EL30+EI+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl46l24ACgkQJNaLcl1U
h9AAXAf+MO8n4UxQtouGrNdxFiwPsOIGewJMPd4vN1NCZTVDUBP55eWyQ4naXCsN
+BfzAWdmmwJn142SlhZV1P6qThjGkZwZft+PMVDW58zVRibxqmypybMitrQXPvQM
hzX56yshLBEYtaeps5/as2Iv0SU07tYFJ7g+ir1K0s8XOkYusOBWTGViOpO4JkH2
Js8aho28jbWGq8UaK8aH2eDhtLVPTmjYpN5Xk7qfbGvy5+Pq+HOmpLW0sM56uw9Q
nYPZOJbkFU+fIKXw8ZmxuuXs/vFeZHUqIdLAqcz+vIdxj6pxNnt9lk0uA6idJ+iH
+UdbUJ0BPsFyvzLEriFJEgwNnbTN0w==
=B63k
-----END PGP SIGNATURE-----

--mOr7kNv8EL30+EI+--
