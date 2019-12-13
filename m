Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2911E1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLMKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:08:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:32806 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMKIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:08:35 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ifhrt-000106-VL; Fri, 13 Dec 2019 11:08:17 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc:     tom@radxa.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Akash Gajjar <akash@openedev.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        matwey.kornilov@gmail.com
Subject: Re: [PATCH] arm64: dts: rockchip: Add regulators for PCIe for Radxa Rock Pi 4 board
Date:   Fri, 13 Dec 2019 11:08:17 +0100
Message-ID: <2621713.C5CYpBeeQa@phil>
In-Reply-To: <20191120161302.5157-1-matwey@sai.msu.ru>
References: <CAFjve-AT6c-yweF0mOPea-caG3n43nZzVPcwef-qp+n35JN9ig@mail.gmail.com> <20191120161302.5157-1-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 20. November 2019, 17:12:54 CET schrieb Matwey V. Kornilov:
> Add 0.9V and 1.8V voltage regulators for Radxa Rock Pi 4 board PCIe.
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>

applied for 5.6

Thanks
Heiko


