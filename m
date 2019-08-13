Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0C68C091
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfHMSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 14:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfHMSaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:30:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC13020665;
        Tue, 13 Aug 2019 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565721006;
        bh=AAcWpHX1c7OqZ19H2TdUwNCGoFLrr2xzn4NIMWe0y44=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZD4kJjWF9zQida/HMKAddKmuo9zEQdOPO37S8s5/sUd1LWthRKkIajhZ66u8bpanS
         RTZrj8U5otptn0n9ai1fr0Hd/2lw8MGUsKmeZE5ThRjJxWxvRvNlbiNnrfw55zMPKO
         SK5TtOJgU/kjcV+OlTJRCpEGozqo1BaX4DZt6nWI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190812100216.34459-1-wen.he_1@nxp.com>
References: <20190812100216.34459-1-wen.he_1@nxp.com>
Subject: Re: [v1 2/3] dt/bindings: clk: Add DT bindings for LS1028A Display output interface
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     leoyang.li@nxp.com, liviu.dudau@arm.com, Wen He <wen.he_1@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Tue, 13 Aug 2019 11:30:05 -0700
Message-Id: <20190813183005.EC13020665@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-08-12 03:02:16)
> diff --git a/Documentation/devicetree/bindings/clock/fsl,plldig.txt b/Doc=
umentation/devicetree/bindings/clock/fsl,plldig.txt
> new file mode 100644
> index 000000000000..29c5a6117809
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fsl,plldig.txt
> @@ -0,0 +1,26 @@
> +NXP QorIQ Layerscape LS1028A Display output interface Clock
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can you convert this to YAML?

> +
> +Required properties:
> +    - compatible: shall contain "fsl,ls1028a-plldig"
> +    - reg: Physical base address and size of the block registers
> +    - #clock-cells: shall contain 1.

As I said in the previous patch, this should probably be 0. Also, please
order this before the driver in the patch series and thread your
messages please. If you use git-send-email this is done for you pretty
easily.

> +    - clocks: a phandle + clock-specifier pairs, here should be
> +    specify the reference clock of the system
> +
> +
