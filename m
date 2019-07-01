Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831A537C32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2019 20:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfFFSZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jun 2019 14:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbfFFSZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 14:25:09 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807E420872;
        Thu,  6 Jun 2019 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559845508;
        bh=eZv3NhXyzehlZXb+F3mzuI1EXr1xshxZrr8mXEuyy5w=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=a0IyxaGh9BRcF16GjgQkcHlnX5Hs92cOufnM8ug+6Fx6tE6szktnjNydTilwF/nHw
         Kb4nH6X+g/6yLvYdMUymG4TVCrRy4uIH2EY1xOxNY3OnkzytzfaRPhiffBiVp6JQPr
         8ebXvNWk6xXe6AFUTWCd57XgTm30yAD+Ka/WJj7g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190525142535.15040-1-yuehaibing@huawei.com>
References: <20190525142535.15040-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH -next] clk: mmp: frac: Remove set but not used variable 'prev_rate'
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
User-Agent: alot/0.8.1
Date:   Thu, 06 Jun 2019 11:25:07 -0700
Message-Id: <20190606182508.807E420872@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-05-25 07:25:35)
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/clk/mmp/clk-frac.c: In function clk_factor_set_rate:
> drivers/clk/mmp/clk-frac.c:81:16: warning: variable prev_rate set but not=
 used [-Wunused-but-set-variable]
>=20
> It's never used and can be removed.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

