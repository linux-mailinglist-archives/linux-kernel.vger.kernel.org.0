Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1B51322AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jan 2020 10:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgAGJkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jan 2020 04:40:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45758 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgAGJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:40:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so53080593wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxP1CIfvaIesWXzyg7PNCDmPXdQ++BEJZih1OlkgT3U=;
        b=ZOVlIFa3JnmWxNCkjntBBFNr53FtLCWDaRMwhIpLfRBJs/g+6R8pLh2s8Iu0wab9V9
         c0kC92BIeTpXGobrqEeHPLQkcrEaSsjq5hQDh+Qg+Ic1IZ3UuIf+Ir3g1jjRlJn/UmuP
         lfyvw7rrtxib9c4i03gF7aGAbxGgU0nbtTnAqyI+JFULP8ULd9HUK2ZscUXHJpx+n3Sm
         8QHD9v0VD5hO2I+CEld/mg1rwtaCXDl8ZIAcfOzgpnquQlyTUS0JetwBJlScIHiad+AT
         8t64QWM1HNZ2TkrArbMukLTtwN1B5m6TigLGfFPxtbhjlj0LiRX+IQLL6xBNGrKYRg7R
         u0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxP1CIfvaIesWXzyg7PNCDmPXdQ++BEJZih1OlkgT3U=;
        b=geSeBLlmP8RUvSYDkfvAWJRmIuL0QCt/STgM7mk/uDfM6EI2H/9ihTDvhRT9sG04Y5
         mzdCco/rTIypbyyXf7+RmUGpdtsMukURIuVl0A4rFnuLx7mE/A8MhL3XNaNq/ZsFWb7G
         9iep8FNKqoOXsfshUYi6TYH4yM1bANEuZGCpuPefN7dirl81vI2u/Hc+zGQHom9iU1JL
         sVIHcAQU3fk9fSQ5ztJ5ZBofa8gZ+wx4MpVeDnA9KJURsp0MySKBK9rUg/Xap72rnxZu
         e7p+8g0Gq96WvExM7g7aqOWqI2pJZhWftumyWPg6DWKi5Zsbp5FyXJ2XTrkFeeOLJrx5
         OHxg==
X-Gm-Message-State: APjAAAXog0ctDfOddfLtDioPcw7IaXfHge/y1TkCAihNeJhPh1UxWa6/
        24AcuTuA9WGN8SH8kudAtGs=
X-Google-Smtp-Source: APXvYqwXNPvgLzkgar2pDgkr1t6+3H3cW27VHe0neAduCU+OXso4v6jqKdUwWfmtxdHl3s3tqD0bRw==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr108461433wrq.305.1578390035937;
        Tue, 07 Jan 2020 01:40:35 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id t81sm26701607wmg.6.2020.01.07.01.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 01:40:34 -0800 (PST)
Date:   Tue, 7 Jan 2020 10:40:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] coccinnelle: Remove ptr_ret script
Message-ID: <20200107094033.GA1964183@ulmo>
References: <20200107073629.325249-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20200107073629.325249-1-maxime@cerno.tech>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 08:36:29AM +0100, Maxime Ripard wrote:
> The ptr_ret script script addresses a number of situations where we end up
> testing an error pointer, and if it's an error returning it, or return 0
> otherwise to transform it into a PTR_ERR_OR_ZERO call.
>=20
> So it will convert a block like this:
>=20
> if (IS_ERR(err))
>     return PTR_ERR(err);
>=20
> return 0;
>=20
> into
>=20
> return PTR_ERR_OR_ZERO(err);
>=20
> While this is technically correct, it has a number of drawbacks. First, it
> merges the error and success path, which will make it harder for a review=
er
> or reader to grasp.
>=20
> It's also more difficult to extend if we were to add some code between the
> error check and the function return, making the author essentially revert
> that patch before adding new lines, while it would have been a trivial
> addition otherwise for the rewiever.
>=20
> Therefore, since that script is only about cosmetic in the first place,
> let's remove it since it's not worth it.
>=20
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
>  1 file changed, 97 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci

Acked-by: Thierry Reding <treding@nvidia.com>

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4UUg4ACgkQ3SOs138+
s6EekA/9HAPffRsd3afUYPbgxxX1reZMTCSGN2KVhyrHkCUEAOk2H1ZTec12OZ8F
yvs+PWDcT7j75QTHUSgEMswx9il6rjN3VcT2OUq3EazQUOLJ/ezPHpFXarmMv/pb
05zEsNtmegA+ZeuP6+Xms5br35z7Q9mwBC1on9LuSwEzYzDiYORxD1JM9C4oOCtn
pq/4/CXq0oDaHCq3H+g0/wPjyX68fCwDUiJaJJMyAu56qUCZKsghsVZZVHa6BJGA
hvnHixOoK9tBWKXDoqEcp5GZuZaRKQ6N8MrSjZYfsozqPB+oNCMk3+072ggZzXgB
TMw5QHOe388eA7afYvAosBU2FrJ1Q6ldWWtMHXlGxFoOSwGv1yhx45ImY8HmUktj
uciuPrcYzfXdNMmwRA/AwQQiy1XHn3l+Ys+b3nKfp5xtKSvANwHhdEgAYUufYNS4
LdlKvISonOLFcdPWXBhGzFyqHU9Kwrr839FBW3p6txpPD/wisWh1Hjgk0sa9o8Kg
2O7fVtiF9YnZDOkeFRjJncLsI/U6papicwsk1JTkGmgz6wtevxB47cmxaDLiuadC
9oAVv5yTl9aM4aXEoaNGTP8SlKciSTX8+X2DoBsFJrnr1aumBGXb5bOYZWOpJ/Li
21pSPMQkRBfwTtmR03ytQP+ddM2SuKvCHFrXX7PDjSqL8iPrUMs=
=pKJF
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
