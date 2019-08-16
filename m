Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDB906FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfHPRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfHPRex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:34:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF5F2086C;
        Fri, 16 Aug 2019 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976892;
        bh=1oe6NzSGm38zRqgP0VASJ7S94TJ/KghmSj5jyFDjQZ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ilypoaSHeev0JULBweVkw4UbrW45Oq3D1fZWgFZmejx9ITCG5XKNOPdGp2jO2mTGh
         fTpYNJ0zHYCclKfzJOjAEIJz67C44Ct17ORgLRzmbp39eIX8rpAeUlNRr43KeTOL+V
         ZLk2zLzDD3dgnLP6wsPgiu2wdcLmfqKzRMwbJ310=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816140200.55040-1-yuehaibing@huawei.com>
References: <20190816140200.55040-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: armada-xp: remove unused code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, gregory.clement@bootlin.com,
        mturquette@baylibre.com
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:34:51 -0700
Message-Id: <20190816173452.7EF5F2086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 07:02:00)
> drivers/clk/mvebu/armada-xp.c:171:38: warning:
>  mv98dx3236_coreclks defined but not used [-Wunused-const-variable=3D]
> drivers/clk/mvebu/armada-xp.c:213:41: warning:
>  mv98dx3236_gating_desc defined but not used [-Wunused-const-variable=3D]
>=20
> They are never used, so can be remove. Also remove
> the related functions.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

I'll wait for Gregory to review.

