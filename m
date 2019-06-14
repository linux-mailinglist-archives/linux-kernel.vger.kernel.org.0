Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA36F45B75
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFNLbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 07:31:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39678 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfFNLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:31:33 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbkQa-0004le-TG; Fri, 14 Jun 2019 13:31:28 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nick Xie <xieqinick@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, nick@khadas.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add support for Khadas Edge/Edge-V/Captain boards
Date:   Fri, 14 Jun 2019 13:31:28 +0200
Message-ID: <4121108.4RU3k1uWxS@phil>
In-Reply-To: <CAP4nuTU1BjmpXk5zqWTjBVyO=1ks-Rn65ryaxdQ=GiGa+VK6-A@mail.gmail.com>
References: <1559035267-1884-1-git-send-email-xieqinick@gmail.com> <2074921.iWOsiWxYGh@phil> <CAP4nuTU1BjmpXk5zqWTjBVyO=1ks-Rn65ryaxdQ=GiGa+VK6-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 10. Juni 2019, 09:19:52 CEST schrieb Nick Xie:
> Hello Heiko,
> 
> Thanks for your review.
> 
> > Both Captain and Edge-V seem to be identical from a component point
> > of view, so should likely share the same dts, or is there some major
> > difference coming later?
> 
> This is the first patch to support Khadas Edge/Edge-V/Captain board, so I
> just add basic dts nodes.
> 
> For Captain has more peripherals then Edge-V, so the dts will be different
> in the future, but it is the same now.

Sounds reasonable, thanks for the clarification.


Heiko


