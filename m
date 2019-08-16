Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80EC906F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfHPRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 13:33:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbfHPRdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:33:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 766E82086C;
        Fri, 16 Aug 2019 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565976825;
        bh=iTWDKy7i46AGTrrCkTa1IC9HRZoGPU9Ot5ficdX+Qe4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yQH2QSy2LVGYJfDgQnhKokR0BbtvYvrDV32d8I/eO7p423knqPRQmxBrtTVo5O7Ta
         RUsyrh7tBGeHnTHwn3OtWwga8a23vZ7geqX9sOLQQtXu7xn+E7S/zXMLfHrI8y8Isw
         iaBItVGnikwPApprJjYpt96Z/JSlVePWEzuSxdTA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190816141132.55060-1-yuehaibing@huawei.com>
References: <20190816141132.55060-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] clk: npcm7xx: remove unused code
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        openbmc@lists.ozlabs.org, YueHaibing <yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>, avifishman70@gmail.com,
        benjaminfair@google.com, mturquette@baylibre.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com
User-Agent: alot/0.8.1
Date:   Fri, 16 Aug 2019 10:33:44 -0700
Message-Id: <20190816173345.766E82086C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting YueHaibing (2019-08-16 07:11:32)
> drivers/clk/clk-npcm7xx.c:365:48: warning:
>  npcm7xx_divs_fx defined but not used [-Wunused-const-variable=3D]
> drivers/clk/clk-npcm7xx.c:438:43: warning:
>  npcm7xx_gates defined but not used [-Wunused-const-variable=3D]
>=20
> The two variables are never used, so remove them,
> also remove related type declarations.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Maybe we should register the gates?

