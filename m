Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB88DA237
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438313AbfJPXdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:33:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6412021848;
        Wed, 16 Oct 2019 23:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268784;
        bh=yKZA28VupFXGJGczBrHMfsO5Qz+1b9EGWTi5JKgy5OI=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=gF4CxFs/YB1FdPLWmk8bjHqmeiuu+bFSHOg/aVaSF+XhFt3yuePlTCMN6mCuggo54
         5maUYv3LAJRfTukWboxjp8bxFRWd0w7l67IQQmWNcyHQEiDd7aXpCzuclqMcZM8/cq
         kmJPObeDdcTH4XAKqvZbRjEskSZ9U5heCss/Weds=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015112644.19816-1-yuehaibing@huawei.com>
References: <20191015112644.19816-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     allison@lohutok.net, kstewart@linuxfoundation.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        tglx@linutronix.de, weiyi.lu@mediatek.com, yuehaibing@huawei.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH -next] clk: mediatek: mt2712: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:33:03 -0700
Message-Id: <20191016233304.6412021848@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 04:26:44)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

