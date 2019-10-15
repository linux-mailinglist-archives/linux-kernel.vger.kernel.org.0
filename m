Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8555AD8115
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 22:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbfJOUck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 16:32:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39548 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfJOUcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:32:39 -0400
Received: from remote.shanghaihotelholland.com ([46.44.148.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iKTUh-00087j-Uz; Tue, 15 Oct 2019 22:32:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] include: dt-bindings: rockchip: remove RK_FUNC defines
Date:   Tue, 15 Oct 2019 22:32:30 +0200
Message-ID: <2623685.EsipSBtvXi@phil>
In-Reply-To: <29be43a3-516b-ce33-8a19-ffd8202d9c3a@gmail.com>
References: <20191015191000.2890-1-jbx6244@gmail.com> <2236841.lnJlJmhppS@phil> <29be43a3-516b-ce33-8a19-ffd8202d9c3a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Oktober 2019, 22:26:14 CEST schrieb Johan Jonker:
> Hi Heiko,
> 
> What's the plan for RK_FUNC_GPIO ? Change all to '0' or keep it?

RK_FUNC_GPIO I'd like to keep :-) .

Basic rationale is that mapping RK_FUNC_1 -> 1, RK_FUNC_2 -> 2, etc does
not provide any additional value, while telling it explicitly that we're
mapping to the gpio function does.

Heiko

> 
> On 10/15/19 10:10 PM, Heiko Stuebner wrote:
> > Hi Johan,
> > 
> > Am Dienstag, 15. Oktober 2019, 21:10:00 CEST schrieb Johan Jonker:
> >> The defines RK_FUNC_1, RK_FUNC_2, RK_FUNC_3 and RK_FUNC_4
> >> are no longer used, so remove them to prevent
> >> that someone start using them again.
> > 
> > That won't work. Devicetree provides a slightly flexible promise of
> > backwards compatibilty. So a new kernel should still work old devicetrees.
> > (not exactly sure if this means dt-binaries and sources or only binaries)
> > 
> > So while I think RK_FUNC_0-n should not be used anymore, we should
> > probably just mark them as "deprecated" in a first step.
> > 
> > 
> > Heiko
> 
> 




