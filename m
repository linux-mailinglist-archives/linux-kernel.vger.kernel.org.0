Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A331136230
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgAIVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 16:03:11 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:33572 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:03:11 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E97671C25CE; Thu,  9 Jan 2020 22:03:07 +0100 (CET)
Date:   Thu, 9 Jan 2020 22:03:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109210307.GA1553@duo.ucw.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20200109115633.GR4951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > Hi!
> >=20
> > I updated my userspace to x86-64, and now chromium likes to eat all
> > the memory and bring the system to standstill.
> >=20
> > Unfortunately, OOM killer does not react:
> >=20
> > I'm now running "ps aux", and it prints one line every 20 seconds or
> > more. Do we agree that is "unusable" system? I attempted to do kill
> > from other session.
>=20
> Does sysrq+f help?

May try that next time.

> > Do we agree that OOM killer should have reacted way sooner?
>=20
> This is impossible to answer without knowing what was going on at the
> time. Was the system threshing over page cache/swap? In other words, is
> the system completely out of memory or refaulting the working set all
> the time because it doesn't fit into memory?

Swap was full, so "completely out of memory", I guess. Chromium does
that fairly often :-(.

> > Is there something I can tweak to make it behave more reasonably?
>=20
> PSI based early OOM killing might help. See https://github.com/facebookin=
cubator/oomd

Um. Before doing that... is there some knob somewhere saying "hey
oomkiller, one hour to recover machine is a bit too much, can you
please react sooner"? PSI is completely different system, but I guess
I should attempt to tweak the existing one first...

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXheVCwAKCRAw5/Bqldv6
8jrTAJ9SOcPY4NOLGrJdYUYmDZU8C4lEWgCdGX9JQcRf8oSwH2dqDYw5xIx8L+o=
=ZCiY
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
