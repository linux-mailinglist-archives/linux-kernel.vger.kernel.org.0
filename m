Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0CD11E18F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLMKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:04:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:60914 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfLMKEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:04:21 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ifhny-0000yI-M1; Fri, 13 Dec 2019 11:04:14 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: Remove always-on properties from regulator nodes on rk3399-roc-pc.
Date:   Fri, 13 Dec 2019 11:04:14 +0100
Message-ID: <6226306.W37etdpfGF@phil>
In-Reply-To: <f985665c-86c0-1657-14f8-f77e2ce5a3f7@fivetechno.de>
References: <f985665c-86c0-1657-14f8-f77e2ce5a3f7@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Am Dienstag, 10. Dezember 2019, 13:44:38 CET schrieb Markus Reichl:
> Some regulators don't need the always-on property, remove it.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.6, but please check your mail client as "git am" was quite
unhappy about it, which I fixed up in the patch itself.
Maybe just switch to "git send-email" instead of using Thunderbird.

Heiko



