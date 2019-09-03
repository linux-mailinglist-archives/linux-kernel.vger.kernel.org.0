Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E427AA5F87
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 05:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICDIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Sep 2019 23:08:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39245 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbfICDIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 23:08:18 -0400
X-UUID: 5512fba9b63b4a1a9c449cfd92584e64-20190903
X-UUID: 5512fba9b63b4a1a9c449cfd92584e64-20190903
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1278790854; Tue, 03 Sep 2019 11:08:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Sep 2019 11:08:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Sep 2019 11:08:07 +0800
Message-ID: <1567480086.22890.21.camel@mtksdaap41>
Subject: Re: [RFC v1] clk: core: support clocks that need to be enabled
 during re-parent
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Biao Huang <biao.huang@mediatek.com>
Date:   Tue, 3 Sep 2019 11:08:06 +0800
In-Reply-To: <20190626035246.4591A20659@mail.kernel.org>
References: <1560138293-4163-1-git-send-email-weiyi.lu@mediatek.com>
         <20190625221415.B0DC22086D@mail.kernel.org>
         <1561511122.24282.10.camel@mtksdaap41>
         <20190626035246.4591A20659@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 20:52 -0700, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-06-25 18:05:22)
> > On Tue, 2019-06-25 at 15:14 -0700, Stephen Boyd wrote:
> > > Quoting Weiyi Lu (2019-06-09 20:44:53)
> > > > When using property assigned-clock-parents to assign parent clocks,
> > > > core clocks might still be disabled during re-parent.
> > > > Add flag 'CLK_OPS_CORE_ENABLE' for those clocks must be enabled
> > > > during re-parent.
> > > > 
> > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > 
> > > Can you further describe the scenario where this is a problem? Is it
> > > some sort of clk that is enabled by default out of the bootloader and is
> > > then configured to have an 'assigned-clock-parents' property to change
> > > the parent, but that clk needs to be "enabled" so that the framework
> > > turns on the parents for the parent switch?
> > 
> > When driver is built as module(.ko) and install at runtime after the
> > whole initialization stage. Clk might already be turned off before
> > configuring by assigned-clock-parents. For such clock design that need
> > to have clock enabled during re-parent, the configuration of
> > assigned-clock-parents might be failed. That's the problem we have now.
> 
> Great. Please put this sort of information in the commit text.
> 

OK, I'll do when sending next version.

> > Do you have any suggestion for such usage of clocks? Many thanks.
> > 
> 
> Ok, and in this case somehow CLK_OPS_PARENT_ENABLE flag doesn't work? Is
> that because the clk itself doesn't do anything unless it's enabled?  I
> seem to recall that we usually work around this by caching the state of
> the clk parents or frequencies and then when the clk prepare or enable
> op is called we actually write the hardware to change the state. There
> are some qcom clks like this and we basically just use the hardware
> itself to cache the state of the clk while it hasn't actually changed to
> be at that rate, because the clk is not enabled yet.
> 

Hi Stephen,

Will you recommend if we cache the state in the platform driver instead
of the hardware itself and then change the state when clk enable op is
called if we don't have such hardware design on MTK clocks?

> The main concern is that we're having to turn on clks to make things
> work, when it would be best to not turn on clks just so that register
> writes actually make a difference to what the hardware does.
> 

In my view, it's a safe operation to enable clock shortly to make things
work when its child clock is still disabled. What do you think?

