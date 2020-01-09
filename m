Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA77413637C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 23:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgAIWsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 17:48:51 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51378 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbgAIWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:48:48 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 70FE11C25BD; Thu,  9 Jan 2020 23:48:47 +0100 (CET)
Date:   Thu, 9 Jan 2020 23:48:45 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109224845.GA1220@amd>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz>
 <20200109212516.GA23620@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20200109212516.GA23620@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Do we agree that OOM killer should have reacted way sooner?
> > >=20
> > > This is impossible to answer without knowing what was going on at the
> > > time. Was the system threshing over page cache/swap? In other words, =
is
> > > the system completely out of memory or refaulting the working set all
> > > the time because it doesn't fit into memory?
> >=20
> > Swap was full, so "completely out of memory", I guess. Chromium does
> > that fairly often :-(.
>=20
> The oom heuristic is based on the reclaim failure. If the reclaim makes
> some progress then the oom killer is not hit. Have a look at
> should_reclaim_retry for more details.

Thanks for pointer.

I guess setting MAX_RECLAIM_RETRIES to 1 is not something you'd
recommend? :-).

> > PSI is completely different system, but I guess
> > I should attempt to tweak the existing one first...
>=20
> PSI is measuring the cost of the allocation (among other things) and
> that can give you some idea on how much time is spent to get memory.
> Userspace can implement a policy based on that and act. The kernel oom
> killer is the last resort when there is really no memory to
> allocate.

So what I'm seeing is system that is unresponsive, easily for an hour.

Sometimes, I'm able to log in. When I could do that, system was
absurdly slow, like ps printing at more than 10 seconds per line.
ps on my system takes 300msec, estimate in the slow case would be 2000
seconds, that is slowdown by factor of 6000x. That would be X terminal
opening in like two hours... that's not really usable.

DRAM is in 100nsec range, disk is in 10msec range; so worst case
slowdown is somewhere in 100000x range. (Actually, in the worst case
userland will do no progress at all, since you can need at 4+ pages in
single CPU instruction, right?)

But kernel is happy; system is unusable and will stay unusable for
hour or more, and there's not much user can do. (Besides sysrq, thanks
for the hint).

Can we do better? This is equivalent of system crash, and it is _way_
too easy to trigger. Should we do better by default?

Dunno. If user moved the mouse, and cursor did not move for 10
seconds, perhaps it is time for oom kill?

Or should I add more swap? Is it terrible to place swap on SSD?

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4Xrc0ACgkQMOfwapXb+vLMPQCgmBZmHNndoxFTIC/1s3EKXFzj
wk0AmgNweQm6peBeROBvZwII5FaQJw2C
=mB1/
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
