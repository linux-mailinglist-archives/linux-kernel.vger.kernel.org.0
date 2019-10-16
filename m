Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAABCDA248
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438920AbfJPXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 19:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbfJPXd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:33:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B432F2168B;
        Wed, 16 Oct 2019 23:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571268836;
        bh=InOtPuMwiDZaEIQcAgB+1nPKHT1N2rj7QjJXTKKNC7o=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=wFLQPg6puYmgL1mNCYTIdQjVOcutLNGiGXr20LKi8d/LhVpjgirZGdQUgYOCZCZLg
         QfD+sg3FQ541+atvLXZPgU+tosf/rqyQx5TVGPr+QHS/+nVSYPd5jmQ5w34FzyxNmr
         82FCxM4sy5L5BwqM5Wjftd8FDx6fdC64h4rQ4W8Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191015124728.25072-1-yuehaibing@huawei.com>
References: <20191015124728.25072-1-yuehaibing@huawei.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, gregkh@linuxfoundation.org,
        jasu@njomotys.info, kstewart@linuxfoundation.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com, tglx@linutronix.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: mediatek: mt6797: use devm_platform_ioremap_resource() to simplify code
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:33:56 -0700
Message-Id: <20191016233356.B432F2168B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-10-15 05:47:28)
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Applied to clk-next

