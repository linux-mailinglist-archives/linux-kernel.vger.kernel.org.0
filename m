Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E99CF75F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbfJHKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 06:44:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32954 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHKoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZBkOkJMJF/M7sprDHTMPR2iBVCnUlOhXrzvuGJ8/S9w=; b=kAUuxpOYJRxPfnroMtCcMKb7W
        g9kGQhiCNBRmn5j+2ZOgPx/GIoViyI6pr4PCQK/h57VFKFiABtvMGXMMSrBrlViI+8mmKMM2Zbi6a
        NXmq4aqJD6oETQO7b/1bTqxz1CLOflIScmWwKgtF9spMU+DKH04NCSCgJAVc0iVc42MrI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHmyP-00081t-Fe; Tue, 08 Oct 2019 10:44:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E8F372742998; Tue,  8 Oct 2019 11:44:07 +0100 (BST)
Date:   Tue, 8 Oct 2019 11:44:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND][PATCH 2/2] regulator: da9062: Simplify
 da9062_buck_set_mode for BUCK_MODE_MANUAL case
Message-ID: <20191008104407.GA4382@sirena.co.uk>
References: <20191007115009.25672-1-axel.lin@ingics.com>
 <20191007115009.25672-2-axel.lin@ingics.com>
 <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <CAFRkauCW5-+u6npP2fpAaNL5kPdKXQ_wWrZ_7qZkJr=uMP1BsA@mail.gmail.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 06:41:21PM +0800, Axel Lin wrote:

> I'm wondering if any issue with this patch?
> Note, this patch is for da9062 (not for da9063 which is already applied).

It doesn't seem to apply against current code.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2caHQACgkQJNaLcl1U
h9AUjAf/RtfVrfSrydLAqDkd0l0IPWJkHUyEvKhI/lng6paSEHSEDNBLcyqqejRr
1pC95GEi22m6365VOQFanHJ8BMXIdLB+xjWKscT2N1uLmTO2xKBIpWrVlRIayGBc
N534zfRzayJxtumbioEOKDLamq8d+8RpqgcZU+lueS6/GGyN0nmBBnnxCM4jq5+v
eXbI9+E6N1bhIwaIyoZL2T1bmlXdDn3eHy+PHdDHYM+0XLbB4Sep02WieZZnB4uW
n/5Kajw9vSiKCNrlzkvi17uOanaZgl6A98w/N6dRSn6HSAAxDhYm7auDPJxPX+Po
VulueeE/zkwblbLudYWvaA5BPm3b5w==
=7/MO
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
