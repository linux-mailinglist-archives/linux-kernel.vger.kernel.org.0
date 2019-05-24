Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F342629A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404103AbfEXOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 10:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404039AbfEXOdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:33:55 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5586D2133D;
        Fri, 24 May 2019 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558708435;
        bh=gZetN5B3ywzeQ7Qs5a+pWguj+B6DKPIfnehnVziFYMc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aw1FIC57J9GZmg1xCAVTytzdxhIu5ydjXn8d/GgzsVQKCB2WOrjZEHBDQMFdqZq2a
         Uo3CLauNxVU7oS1m+fp7jgh0kkdLLFyjlmLHlvzs9UtUY4B2qv4x3NDGelhxMANfUS
         9lGjM78D5IjY63bna6w4N5yiXFW6PNOgaFJdO4I8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190524072745.27398-1-amergnat@baylibre.com>
References: <20190524072745.27398-1-amergnat@baylibre.com>
Subject: Re: [PATCH] clk: fix clock global name usage.
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Alexandre Mergnat <amergnat@baylibre.com>, mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Fri, 24 May 2019 07:33:54 -0700
Message-Id: <20190524143355.5586D2133D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Mergnat (2019-05-24 00:27:45)
> A recent patch allows the clock framework to specify the parent
> relationship with either the clk_hw pointer, the global name or through
> Device Tree name.

You could point to the commit instead of saying "a recent patch". Would
provide more clarity.

>=20
> But the global name isn't handled by the clk framework because the DT name
> is considered valid even if it's NULL, so of_clk_get_hw() returns an
> unexpected clock (the first clock specified in DT).

Yes, the DT name can be NULL and then we would use the index.

>=20
> This can be fixed by calling of_clk_get_hw() only when DT name is not NUL=
L.
>=20
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string n=
ames")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index bdb077ba59b9..9624a75e5a8d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -368,7 +368,7 @@ static struct clk_core *clk_core_get(struct clk_core =
*core, u8 p_index)
>         const char *dev_id =3D dev ? dev_name(dev) : NULL;
>         struct device_node *np =3D core->of_node;
> =20
> -       if (np && index >=3D 0)
> +       if (name && np && index >=3D 0)

Do you set the index to 0 in this clk's parent_data? We purposefully set
the index to -1 in clk_core_populate_parent_map() so that the fw_name
can be NULL but the index can be something >=3D 0 and then we'll use that
to lookup the clk from DT. We need to support that combination.

	fw_name   |   index |  DT lookup?
	----------+---------+------------
	NULL      |    >=3D 0 |     Y
	NULL      |    -1   |     N
	non-NULL  |    -1   |     ?
	non-NULL  |    >=3D 0 |     Y

Maybe we should support the ? case, because right now it will fail to do
the DT lookup when the index is -1.

So this patch instead?

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b34e84bb8167..a554cb9316a5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -368,7 +368,7 @@ static struct clk_core *clk_core_get(struct clk_core *c=
ore, u8 p_index)
 	const char *dev_id =3D dev ? dev_name(dev) : NULL;
 	struct device_node *np =3D core->of_node;
=20
-	if (np && index >=3D 0)
+	if (np && (index >=3D 0 || name))
 		hw =3D of_clk_get_hw(np, index, name);
=20
 	/*
