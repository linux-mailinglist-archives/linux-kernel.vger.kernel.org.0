Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5792F5A90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2019 23:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfKHWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 17:07:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbfKHWHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:07:17 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150422084D;
        Fri,  8 Nov 2019 22:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573250837;
        bh=F9598YJ7umblSSscgKD6bsQHkgKqFEeeQhpYqMVujj0=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=qmmxDqIczTRF6/bWq+R0BzxMQqujVYIpWuBVIn4pclepcyJjht82PY/zGNpM0nanz
         5aTU5BjMKzw1wakefOXN5VOhuvdNk+hHjnUMq6g6sYWZPfVEoq0pxJ5aK6ccWo4sGr
         R0J5rqpNkhSakh/X8E9tTnOwlwYQPaYhRN1B6tp0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191027162328.1177402-2-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com> <20191027162328.1177402-2-martin.blumenstingl@googlemail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jbrunet@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: clock: add the Amlogic Meson8 DDR clock controller binding
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 14:07:16 -0800
Message-Id: <20191108220717.150422084D@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Martin Blumenstingl (2019-10-27 09:23:24)
> Amlogic Meson8, Meson8b and Meson8m2 SoCs have a DDR clock controller in
> the MMCBUS registers. There is no public documentation on this, but the
> GPL u-boot sources from the Amlogic BSP show that:
> - it uses the same XTAL input as the main clock controller
> - it contains a PLL which seems to be implemented just like the other
>   PLLs in this SoC
> - there is a power-of-two PLL post-divider
>=20
> Add the documentation and header file for this DDR clock controller.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

