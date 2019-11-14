Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 249BCFBC18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 00:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKMXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 18:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfKMXAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 18:00:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6731F206E3;
        Wed, 13 Nov 2019 23:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573686010;
        bh=2AmqOHyJ6omnuRzB5myDDOYWpOkM5LXqNgKm+BcO0DM=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=U1OmHvn7yTe0q9tomleg7XpTyaB1EQTLSdnzts5zIBElzVfeyiW+/o/qhv4pW0fkc
         NnFu6UYR1dbfJ+fcXe6QuRRHfjxPuOcqhYm64O/BP68yIoGBcbu7Maq0YsI8jxMqJI
         I8lE+eA4bbW2BC0nzBURe2C42Adq3gUOO+YiLgpc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
References: <1995139bee5248ff3e9d46dc715968f212cfc4cc.1570520268.git.baolin.wang@linaro.org>
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Baolin Wang <baolin.wang@linaro.org>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
User-Agent: alot/0.8.1
Date:   Wed, 13 Nov 2019 15:00:08 -0800
Message-Id: <20191113230010.6731F206E3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Baolin Wang (2019-10-08 00:41:38)
> The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
> IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().
>=20
> Fixes: d41f59fd92f2 ("clk: sprd: Add common infrastructure")
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---

Applied to clk-next

