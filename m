Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC4257DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 20:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfEUS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 14:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbfEUS5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 14:57:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24632173C;
        Tue, 21 May 2019 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558465034;
        bh=J3SvV9Z6ze4KO1qrk5eCIQuEcPxibxRj+FZGbkfpocA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Oau2tag3j1+euW2LzKD4Ol6kN5wOcs5uFAMg0eHY2vMIcOpJWlnsidbUWMnNpxsf0
         NavnvkMXidxd7p7djnThZ2rM8w0fJRswbcPmfsP6SghByEXT55MkfJWjtdsDwFEB1U
         Goy91eZ2WMoo+vWsFLxaKOiV1TnudmNmxQSnXhyw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMz4kuLjOjKGXn7QtOO5Gizo-FZ7CDf2SiczTNPwDgjAKzm2pw@mail.gmail.com>
References: <20190521060952.2949-1-zhang.chunyan@linaro.org> <20190521060952.2949-2-zhang.chunyan@linaro.org> <CAMz4kuLjOjKGXn7QtOO5Gizo-FZ7CDf2SiczTNPwDgjAKzm2pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: sprd: Switch from of_iomap() to devm_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
User-Agent: alot/0.8.1
Date:   Tue, 21 May 2019 11:57:13 -0700
Message-Id: <20190521185713.E24632173C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baolin Wang (2019-05-20 23:38:03)
> On Tue, 21 May 2019 at 14:15, Chunyan Zhang <zhang.chunyan@linaro.org> wr=
ote:
> >                                                &sprdclk_regmap_config);
> > -               if (IS_ERR_OR_NULL(regmap)) {
> > +               if (IS_ERR(regmap)) {
>=20
> You did not mention this fix in your commit message, and it's better
> to move into one separate patch.
>=20

Please resend with it split out.

