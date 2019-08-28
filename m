Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A707A0946
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 20:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfH1SKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 14:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1SKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:10:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8B72053B;
        Wed, 28 Aug 2019 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567015816;
        bh=gXK2jcNaEyEw4/N7rUk7XObALuHMQXmTYjxCZjSWc8c=;
        h=In-Reply-To:References:Cc:Subject:To:From:Date:From;
        b=N4+0vvt9M73EmHLGWuB0IBckXMtvlLRqf55GOmQfBga8D+EzB1RqBl8ELJm2ELlau
         M3ovBKw3fgeGTn0Bq8FkO3tEoIKGbH9w/1F0FyBrk7dphjfCxd2EGD/fY9f1wDXEad
         41FHQjMGabajoZlHCmY70sT9IDKt/G+d6u6MhWyU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201908271848.zrwFj4Pk%lkp@intel.com>
References: <20190826234311.138147-1-sboyd@kernel.org> <201908271848.zrwFj4Pk%lkp@intel.com>
Cc:     kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] clk: Evict unregistered clks from parent caches
To:     kbuild test robot <lkp@intel.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 28 Aug 2019 11:10:15 -0700
Message-Id: <20190828181016.3F8B72053B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting kbuild test robot (2019-08-27 03:28:35)
> Hi Stephen,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3-rc6 next-20190827]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/clk-Evict-u=
nregistered-clks-from-parent-caches/20190827-165138
> config: mips-allnoconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Dmips=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/clk/clk.c: In function 'clk_core_evict_parent_cache':
> >> drivers/clk/clk.c:3785:15: error: 'all_lists' undeclared (first use in=
 this function); did you mean 'lists'?
>      for (lists =3D all_lists; *lists; lists++)
>                   ^~~~~~~~~
>                   lists
>    drivers/clk/clk.c:3785:15: note: each undeclared identifier is reporte=
d only once for each function it appears in

Aha, thanks. all_lists is for debugfs it seems.

