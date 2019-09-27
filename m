Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB166C0BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 20:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfI0Spv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 14:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfI0Sps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:45:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312AA20872;
        Fri, 27 Sep 2019 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569609948;
        bh=2abY4RvzDrV7ZdSCeY547gsiUtUpdWNapfjq46d9c7Q=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=Og+/hr+fuIIOHhez7V7VPkBCoxZr4ITEX2BxG9MRmuniM2cx3yEsZsqBLv5Dhz6zE
         46WzEkQRmPRYcDeFhLvYNDluemYdAfSlpVGU8Wt3b0qSvENOf3AFyj8hixS13h7We8
         6m6I1ZlfILLt5xs6LB9Soh7Bj0Etq1lOJfpPdXE0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
References: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Baolin Wang <baolin.wang@linaro.org>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
User-Agent: alot/0.8.1
Date:   Fri, 27 Sep 2019 11:45:47 -0700
Message-Id: <20190927184548.312AA20872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baolin Wang (2019-09-26 20:50:53)
> The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
> IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/clk/sprd/common.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes tag?

