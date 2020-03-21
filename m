Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CAC18DD47
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Mar 2020 02:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgCUBZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 21:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgCUBZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE54720753;
        Sat, 21 Mar 2020 01:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753916;
        bh=BjgNFx/jHBTjbfaTgwgZ3HKVdTTBkT+YDjJ9WqUEwj4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xBNWC30zUZIpuqimbrDNF30fDGCbH3710Aa1RwJ/uktESAFXxozXoyELvGKhXZODy
         3lmW+nEDuF1uIwRhj1hgC83dHE4ocT2I2u7uTaziKGPeSagjy6P3y2YSVHogv8iBGA
         3l/KG/Qyq5nX84BhX4cyqHTdVuS3AvtPo9gnTKRQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-13-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-13-lkundrak@v3.sk>
Subject: Re: [PATCH v2 12/17] clk: mmp2: add the GPU clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:15 -0700
Message-ID: <158475391524.125146.12009749470566711850@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:49)
> MMP2 has a single GC860 core while MMP3 has a GC2000 and a GC300.
> On both platforms there's an AXI bus interface clock that's common for
> all GPUs and each GPU core has a separate clock.
>=20
> Meaning of the relevant APMU_GPU bits were gotten from James Cameron's
> message and [1], the OLPC OS kernel source [2] and Marvell's MMP3 tree.
>=20
> [1] http://lists.laptop.org/pipermail/devel/2019-April/039053.html
> [2] http://dev.laptop.org/git/olpc-kernel/commit/arch/arm/mach-mmp/mmp2.c=
?h=3Darm-3.0-wip&id=3D8ce9f6122
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
