Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACC550C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 15:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfFYNvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 09:51:41 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44836 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFYNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:51:41 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hflr8-0002pG-NB; Tue, 25 Jun 2019 09:51:30 -0400
Message-ID: <ab58d07361198e555e4b8278a4264c8dafa54b93.camel@surriel.com>
Subject: Re: [PATCH 8/8] sched,fair: flatten hierarchical runqueues
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, kernel-team@fb.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        Mel Gorman <mgorman@techsingularity.net>,
        vincent.guittot@linaro.org
Date:   Tue, 25 Jun 2019 09:51:30 -0400
In-Reply-To: <960c2571-7a32-f7aa-08ca-07f1136e835d@arm.com>
References: <20190612193227.993-1-riel@surriel.com>
         <20190612193227.993-9-riel@surriel.com>
         <960c2571-7a32-f7aa-08ca-07f1136e835d@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-jEQPJptt/+nICcoEG/pe"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jEQPJptt/+nICcoEG/pe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-25 at 11:50 +0200, Dietmar Eggemann wrote:
> On 6/12/19 9:32 PM, Rik van Riel wrote:
>=20
> [...]
>=20
> > @@ -410,6 +412,11 @@ static inline struct sched_entity
> > *parent_entity(struct sched_entity *se)
> >  	return se->parent;
> >  }
> > =20
> > +static inline bool task_se_in_cgroup(struct sched_entity *se)
> > +{
> > +	return parent_entity(se);
> > +}
>=20
> IMHO, s/in_cgroup/not_in_root_tg/ reads easier. "/", i.e. the root tg
> is
> still a cgroup, I guess. But you could use existing parent_entity(se)
> as
> well.

I agree my name is not the prettiest, but I am not
entirely convinced your idea is an improvement.

I'll hold out for better ideas by other reviewers :)

> > @@ -679,22 +710,16 @@ static inline u64 calc_delta_fair(u64 delta,
> > struct sched_entity *se)
> >  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity
> > *se)
> >  {
> >  	u64 slice =3D sysctl_sched_latency;
> > +	struct load_weight *load =3D &cfs_rq->load;
> > +	struct load_weight lw;
> > =20
> > -	for_each_sched_entity(se) {
> > -		struct load_weight *load;
> > -		struct load_weight lw;
> > +	if (unlikely(!se->on_rq)) {
> > +		lw =3D cfs_rq->load;
> > =20
> > -		cfs_rq =3D cfs_rq_of(se);
> > -		load =3D &cfs_rq->load;
> > -
> > -		if (unlikely(!se->on_rq)) {
> > -			lw =3D cfs_rq->load;
> > -
> > -			update_load_add(&lw, se->load.weight);
> > -			load =3D &lw;
> > -		}
> > -		slice =3D __calc_delta(slice, se->load.weight, load);
> > +		update_load_add(&lw, task_se_h_load(se));
> > +		load =3D &lw;
> >  	}
> > +	slice =3D __calc_delta(slice, task_se_h_load(se), load);
>=20
> task_se_h_load(se) and se->load.weight are off my factor of >=3D 1024
> on
> 64bit.

Oh indeed they are!

I wonder if this is the root cause of that
performance regression I have been hunting for
the past few weeks :)

Let me go test some things...

> ...
>     bash pid=3D3250: task_se_h_load(se)=3D1023 se->load.weight=3D1048576
>     sysctl_sched_latency=3D18000000 slice=3D0 old_slice=3D17999995
> ...
>=20
> [...]
>=20
--=20
All Rights Reversed.

--=-jEQPJptt/+nICcoEG/pe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl0SJuIACgkQznnekoTE
3oORUwf+J5EmnXYqW7g3ia99vi++1MD4CQ65yYCZro+9pKI5sXmRJXttRCQ29Sig
rk3gdC+YIbSHeTKqpgXqeKi/DLjNfdKXF74ys1F6IN+6dI27hNz/BG2oJZZmyBmw
8Nby6RBcGuk1Uk77Ld8Wu7A287h1DF1jpQOptYE6CWZsIkrSYCF/U2Wdbjngf8LV
BqZRENibhJPBlfCoxpnrYYKo54/MkMOhryS8k5Iptq4U8WTE5kOHg4spyZdFfRwQ
ppM+HfAXI4kSXtsMoDCTNhqYiyhWy+MSYQFMIP4egktFM+sfnKVBw4QdnNpE+REA
1brGx+qBdgD2xOp+1wGkUgIKdcQ1hQ==
=vETm
-----END PGP SIGNATURE-----

--=-jEQPJptt/+nICcoEG/pe--

