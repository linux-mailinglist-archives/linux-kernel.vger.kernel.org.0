Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 777A1ABEBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2019 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406098AbfIFR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 13:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbfIFR1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:27:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A470208C3;
        Fri,  6 Sep 2019 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567790825;
        bh=aubeTZP7Q68QWdQFaswbWSPkumhppd1BvCsUyJL7Bqc=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=BqGVWnxa5q6JXWl+hZmLqre0AEx4QV4TFtVU1HDRdQyVYCN9trRGYTACiF+0A09QJ
         MHkpqBWLU/+kT1XR/1D153IDxDur74ViZ7aKR8xWncVlqA9zQ3pJe1FkJFsslEfB/8
         OjAIYrccjj5IGpg6sBqqnvqAWkNcsO1Qu1Q7zYxQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816135523.73520-1-yuehaibing@huawei.com>
References: <20190816135523.73520-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, allison@lohutok.net,
        gregkh@linuxfoundation.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: st: clkgen-pll: remove unused variable 'st_pll3200c32_407_a0'
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 10:27:04 -0700
Message-Id: <20190906172705.2A470208C3@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 06:55:23)
> drivers/clk/st/clkgen-pll.c:64:37: warning:
>  st_pll3200c32_407_a0 defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so can be removed.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

