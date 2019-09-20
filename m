Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059ECB8EB4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 12:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438128AbfITKzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 06:55:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438081AbfITKzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8p0tY0f9xgBLFACe9M44AaAuW3o+Zlx8X15TpbGjey0=; b=Zl9hMBg/roqkXI+Pn3oamK2TD
        eBKwtp2d9cnX2CLxqgZ6D0L0SCUNEZJ6Clvk5wUvYeFLDCHTeMjaL78DKbyBZdlrXLTiyOztoMBsR
        v5WWKy4w2sIxj/7BIYREs9VBeudFUHgH7HmvHeCbJIuKDPwadEUyA7NRPpO+555K2D/CE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iBGZf-0001aG-Di; Fri, 20 Sep 2019 10:55:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D8D01274293C; Fri, 20 Sep 2019 11:55:38 +0100 (BST)
Date:   Fri, 20 Sep 2019 11:55:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     lgirdwood@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] fixed-regulator: dt-bindings: Fixed building error for
 compatible property
Message-ID: <20190920105538.GB3822@sirena.co.uk>
References: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <1568875145-2864-1-git-send-email-pragnesh.patel@sifive.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2019 at 12:09:04PM +0530, Pragnesh Patel wrote:
> Compatible property is not of type 'string', so remove const:
> from it.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.  There's no
need to resubmit to fix this alone.

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2EsCkACgkQJNaLcl1U
h9CKhwf+O7GegnloAg4l4BjReZMOu45L2Pdn4/Ua9uM40hSO+MKWFBZlFYJWz/Pe
+b3y1K+kLxQY+z+OnkT23Rr/j4h4FXeKgKdWwjek7va80C+1EPzOYM28VfF8PF86
rMnymJPk0vbq6Xm05nZX++dApXDPLHMJHVpLh3lZUoNz4b++K9nWUhNpGsRWLNFY
TyjGqyyGS08YbjCAUp+pJqGmVUSqW2JJBE1HrR/ru5h8RqL7+mBbAmR0GdnSwNIp
rUQazY+9heCGRjz/Qjamgkp4HPozARGTFgcYjhSVpAOcaFlQdFfPTTwyUANM3woC
5Thuz1bWC8uJiLZvwTuXPmdYODDusA==
=hxy2
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
