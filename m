Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD71259BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 03:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLSC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 21:58:23 -0500
Received: from shelob.surriel.com ([96.67.55.147]:39546 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 21:58:22 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <riel@shelob.surriel.com>)
        id 1ihm0p-0007dX-AP; Wed, 18 Dec 2019 21:58:03 -0500
Message-ID: <37ec5587dbb4035b883e5a69b56da4cc67f0e5ff.camel@surriel.com>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains
From:   Rik van Riel <riel@surriel.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, pauld@redhat.com,
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        quentin.perret@arm.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, hdanton@sina.com, parth@linux.ibm.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Dec 2019 21:58:01 -0500
In-Reply-To: <20191218154402.GF3178@techsingularity.net>
References: <20191218154402.GF3178@techsingularity.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-4rPGTmvcJU+DU3UvKApY"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4rPGTmvcJU+DU3UvKApY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-18 at 15:44 +0000, Mel Gorman wrote:

> +			/*
> +			 * Ignore imbalance unless busiest sd is close
> to 50%
> +			 * utilisation. At that point balancing for
> memory
> +			 * bandwidth and potentially avoiding
> unnecessary use
> +			 * of HT siblings is as relevant as memory
> locality.
> +			 */
> +			imbalance_max =3D (busiest->group_weight >> 1) -
> imbalance_adj;
> +			if (env->imbalance <=3D imbalance_adj &&
> +			    busiest->sum_nr_running < imbalance_max) {
> +				env->imbalance =3D 0;
> +			}
> +		}
>  		return;
>  	}

I can see how the 50% point is often great for HT,
but I wonder if that is also the case for SMT4 and
SMT8 systems...

--=20
All Rights Reversed.

--=-4rPGTmvcJU+DU3UvKApY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl365zkACgkQznnekoTE
3oM92wgAsI4/q4OHfp1ABuRwhg8iu8LPAi4JOZC/AldUOdNwRZfcWw7kAGBKpeBP
WRY8Boxo4Mig3D8W3qHTAWKrW+hxjuQsOBq6oGpqE9GG/TWjtV0kkeUH32ikLFxC
TxUSVEMlPR5DLUe5nhksZlfnBWvhpUrPMqFPQeZDsU1EnboPajCczuOJw/j7UeI5
9uspMvvZSPgBW5YFympWXbOmkG4QdPFq/UWLrrRsrkaJFBMTfF4dDlklBCjn5wBx
xckJW3w2CQVqROt514APCN8/xd9ATidIdZ/ZhqRGu+NfVbYDdIk++zkSJuVvYVYk
E/QvmfLwgSPPlcTWOwnWoDyV4iHvdQ==
=FMp3
-----END PGP SIGNATURE-----

--=-4rPGTmvcJU+DU3UvKApY--

