Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6A57E56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfF0IhI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Jun 2019 04:37:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60222 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0IhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:37:08 -0400
Received: from wf0413.dip.tu-dresden.de ([141.76.181.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hgPtv-0006sM-WD; Thu, 27 Jun 2019 10:37:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 01/15] dt-bindings: display: rockchip-lvds: Remove panel references
Date:   Thu, 27 Jun 2019 10:37:03 +0200
Message-ID: <2294598.EvZ579e8H0@phil>
In-Reply-To: <20190624215649.8939-2-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-2-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 24. Juni 2019, 23:56:35 CEST schrieb Rob Herring:
> The panel bindings are outside the scope of the Rockchip LVDS interface
> binding. The references are about to change too, so rather than update
> them just drop the section on the panel bindings.
> 
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St�bner" <heiko@sntech.de>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

applied to drm-misc-next

Thanks
Heiko


