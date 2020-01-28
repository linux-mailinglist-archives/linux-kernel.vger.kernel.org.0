Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9426B14B11E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgA1IvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 03:51:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:40980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgA1IvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:51:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8745BAEC1;
        Tue, 28 Jan 2020 08:51:09 +0000 (UTC)
Date:   Tue, 28 Jan 2020 09:51:07 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: SLUB: purpose of sysfs events on cache creation/removal
Message-ID: <20200128085107.GF17425@blackbody.suse.cz>
References: <alpine.DEB.2.21.1912041652410.29709@www.lameter.com>
 <20191204173224.GN25242@dhcp22.suse.cz>
 <20200106115733.GH12699@dhcp22.suse.cz>
 <alpine.DEB.2.21.2001061550270.23163@www.lameter.com>
 <20200109145236.GS4951@dhcp22.suse.cz>
 <20200109114415.cf01bd3ad30c5c4aec981653@linux-foundation.org>
 <20200117171331.GA17179@blackbody.suse.cz>
 <20200118161528.94dc18c074aeaa384200486b@linux-foundation.org>
 <20200127173336.GB17425@blackbody.suse.cz>
 <alpine.DEB.2.21.2001272304080.25307@www.lameter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001272304080.25307@www.lameter.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2020 at 11:04:53PM +0000, Christopher Lameter <cl@linux.com> wrote:
> The patch exposes details of cgroup caches? Which patch are we talking
> about?
Sorry, that's misunderstanding. I mean the current state (sending
uevents) exposes the internals (creation of caches per cgroup). The
patch [1] removing uevent notifications is rectifying it.

Michal

[1] https://lore.kernel.org/lkml/alpine.DEB.2.21.1912041652410.29709@www.lameter.com/


--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4v9fsACgkQia1+riC5
qShawg/+LW2OYgM6w1QE6LO/MoUzffOfLBRZVBJlt7R5ZMG7bgHB4ApxugB2S3U8
KD3fzUb8J2fOT6xxPrF2A927JjkFlwIGfldD6Z1FsoKvtmcWpHiCOPDRuNAd5fKq
3r54hXzXgnIHIOOIGEvQpztRfRR0kKAdXPNFX5isLmbB4K7n+J8Pc3oRsxmjBehZ
fSzUTU5PjVyYtHkopFB80q+3pcPsfl45TBvZD3azU2p3/KMxuuNI6inGM477WJhl
UlY8p/bnA9p4wV6Cw6g0LPNGBmyw7WFl2WxAu4fIsHnR8RXu4A4qxKh22d+N6QuM
cVDERVcVS6FiqqzXlQcGLR6X1KOBIhS7aG8kKj5ewYvUuBApTonhjDfdlwbfJdnr
lzyAXMlzV3sEuyxOtPxH71oLPYGfPThADjtohnnaJGUg0We7881zsi1evUIG7mYB
BJFnJsKYZPJqq8H/c28vbUR2Mztgaz3o9RqXyS4OTZEfp51Q3R6MOaQxsrkP46cs
yD0MdyWFHnveoJRUWGz+u8HwxSvG7Jrvjhd0ob2s5imBsc6HxpTuVfuvVfJGGB3t
bKBj2lTjS44iKi2tNLMC0I2OVoF60kA6kDW7JECj7sK++7LF37AIC996uzQ/mODZ
naZ/G/dZMUvAl0mt5MYZrK0WYURLbEn5IXgldMhtzc7s9a7cDl8=
=/YoQ
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
