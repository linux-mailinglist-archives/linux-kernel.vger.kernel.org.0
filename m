Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6CC67DE57
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbfHAPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:00:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40862 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbfHAPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KsWgLD+afQ98tFuvnGCOkxA8hwl5IDMAgcL9FOQ28wc=; b=aDjOzVkoZj1XbiBBOR3fuFgtH
        HB/tZXM1A4Ut3zgyt6D7YovYtzBTgd9Co0Sr3poshWWoardFcxraDTx2h6nImYuUYR29c9TWMsR6V
        1X/P4Jv9waDP5/NcVYisYBV/doBmylgAU8ZhCXoaAbBnhVUxadCrNLsfoYiVtIb0PvT/g=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htCYp-00050A-EI; Thu, 01 Aug 2019 15:00:07 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A92CD2742C48; Thu,  1 Aug 2019 16:00:05 +0100 (BST)
Date:   Thu, 1 Aug 2019 16:00:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 sound-asoc-fixes tree
Message-ID: <20190801150005.GE5488@sirena.org.uk>
References: <20190801235926.4b973d01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20190801235926.4b973d01@canb.auug.org.au>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 11:59:26PM +1000, Stephen Rothwell wrote:

> Commit

>   66b25f247e90 ("ASoC: amd: use dma_ops of parent device for acp3x dma driver")

> is missing a Signed-off-by from its author.

Ugh, yes - misparsed that as being a variant on the same name.
Dropped, please fix and resend.

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1C/nQACgkQJNaLcl1U
h9A8vwf/bAu9uXS8crNLVmxdYGmYj24whOqrBolRSi/RBou6tA6Oo7QwyvkS+oK+
CZmNDGmyR56gyLAhxkxrvSV+0rw8N6dvOQ0wwav0VVZO8J0PhpsB0ev5lKKKo5hx
wLO4MzRRbvC0VEWTCyvcQRJ3hnRAMbCcyTp/c4fFFbJ8bDAPX0MvrCbI7FsWDJVF
mvZR8FpKAFJ5NfCRmoxJ6zjPSxeMdkul7OBlJBPIXkgXqcXhrWal2kapTH1gO/Vf
Pp5jACOftTdJEv/UwwJgIkjOfxrSJuEcb2XChHVNEBtPE61S3/6L1aRWV5/j70U0
oqBINW7umaCh4a/KKuAATNGmFzypvw==
=wF0e
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
