Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213EFDA24F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438939AbfJPXeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:34:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EA32168B;
        Wed, 16 Oct 2019 23:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268851;
        bh=L+x36Hr7mn62wktApT7ZWsmNPWQ59k80ebb+ftQV7LU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=csThAAc9MVoj9pVTWHJZpOpYOd3XIEFrGD5dH/zdjecOxNODOE9PWZOOWaumrciBN
         0jEpI2yWfHn92rot7f1D1pSKX8Ir0nxahAkNplaBHGNo3rg+RuS4jKM5c2+2JhUw6p
         +bLKzZDWJON1vHgdizpRZNSbjwJdK1Q3BRDxGRw8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015142259.17216-1-yuehaibing@huawei.com>
References: <20191015142259.17216-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Eugeniy.Paltsev@synopsys.com, YueHaibing <yuehaibing@huawei.com>,
        mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: axs10x: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:34:10 -0700
Message-Id: <20191016233411.32EA32168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 07:22:59)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

