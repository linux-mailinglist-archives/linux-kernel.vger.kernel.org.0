Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B39D9AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfJPUFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 16:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfJPUFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:05:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B77D20663;
        Wed, 16 Oct 2019 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571256337;
        bh=FN+ZamWTUnc6HSPt9j58oZCw6bGnwKkYgoL4iYSplAU=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=0rA7ffKhnxt/EjgJ1fY00YU6PumarD5o7xVJ+qTmu1gba9obggVGW+z0Ake7rhKJD
         gzBhI1OrniSpJ9flX5spS2eNgGldu4R36k9xcUblhpvWVF8fla9lux7bFIT0R2rcuA
         31h3XrrzIBwVpJYP4l0IL2ZvYA7i6fyC9DBiFMKU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015115117.23504-1-yuehaibing@huawei.com>
References: <20191015115117.23504-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, mturquette@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: ast2600: remove unused variable 'eclk_parent_names'
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:05:36 -0700
Message-Id: <20191016200537.6B77D20663@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 04:51:17)
> drivers/clk/clk-ast2600.c:119:27: warning:
>  eclk_parent_names defined but not used [-Wunused-const-variable=3D]
>=20
> It is never used, so can be removed.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

