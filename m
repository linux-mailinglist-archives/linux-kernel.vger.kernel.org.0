Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC515B4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 00:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgBLXaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 18:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLXaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:30:22 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 732C220848;
        Wed, 12 Feb 2020 23:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550221;
        bh=DgeEtztmH8rUblkjsfH84edNl1u66hTKoubiNZqo7/Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=adOv6Bv3u1mR3c/TB6Qf4iPFqEhq1uuf4vVr66P//lXF+mXvvakVmYekn1u0CG8gi
         9Brhu/2KLvuHsOz537/lzZ/qxRbEC8OBMiAzB3kwo8FBCreRXIL96GVda+YbbMeKni
         /bMVwVoMIo5aK/A8IoQvZDm0Z7MKGIrR1ZgkET+A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200131115816.12483-1-codrin.ciubotariu@microchip.com>
References: <20200131115816.12483-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v2] clk: at91: sam9x60: Don't use audio PLL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, eugen.hristev@microchip.com,
        Claudiu.Beznea@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 15:30:20 -0800
Message-ID: <158155022061.184098.2526430305237294211@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2020-01-31 03:58:16)
> On sam9x60, there is not audio PLL and so I2S and classD have to use one
> of the best matching parents for their generated clock.
>=20
> Fixes: 01e2113de9a5 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-next
