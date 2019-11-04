Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3CEEE2B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 15:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbfKDOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 09:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:39:17 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEF721D7D;
        Mon,  4 Nov 2019 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572878356;
        bh=rBD591jAd5nuzaGDk6Z/gE1VUXjG7vny3xKcPb3R5hQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zK/5Iy8EzzxsdwVFYIqQjFAqf3sny0M+yC08xIROTlZfFllRHCWvvN7lnEHp7oksa
         +BH0PLqkrNhRGd9XAsrdhe8OErtjUReXs3uKIh7M1vz+wSfwSeM5eCkB16iH2O8jZE
         vcRCrd6vx1ykwc/p1gsdG4Lco/WVnG/zpMN0wIdo=
Date:   Mon, 4 Nov 2019 22:38:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] Add support for more Kontron i.MX6UL/ULL SoMs and
 boards
Message-ID: <20191104143844.GZ24620@dragon>
References: <20191104115352.8728-1-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104115352.8728-1-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 11:53:56AM +0000, Schrempf Frieder wrote:
> Frieder Schrempf (9):
>   ARM: dts: imx6ul-kontron-n6310: Move common SoM nodes to a separate
>     file
>   ARM: dts: Add support for two more Kontron SoMs N6311 and N6411
>   ARM: dts: imx6ul-kontron-n6310-s: Disable the snvs-poweroff driver
>   ARM: dts: imx6ul-kontron-n6310-s: Move common nodes to a separate file
>   ARM: dts: Add support for two more Kontron evalkit boards 'N6311 S'
>     and 'N6411 S'
>   ARM: dts: imx6ul-kontron-n6x1x: Add 'chosen' node with 'stdout-path'
>   ARM: dts: imx6ul-kontron-n6x1x-s: Add vbus-supply and overcurrent
>     polarity to usb nodes
>   ARM: dts: imx6ul-kontron-n6x1x-s: Remove an obsolete comment and fix
>     indentation
>   dt-bindings: arm: fsl: Add more Kontron i.MX6UL/ULL compatibles

Applied all, thanks.
