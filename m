Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E4B55D34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2019 03:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfFZBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 21:05:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46290 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbfFZBF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 21:05:27 -0400
X-UUID: 6130bc13c6334e4485ec934b11c452d9-20190626
X-UUID: 6130bc13c6334e4485ec934b11c452d9-20190626
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 87491432; Wed, 26 Jun 2019 09:05:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Jun 2019 09:05:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Jun 2019 09:05:22 +0800
Message-ID: <1561511122.24282.10.camel@mtksdaap41>
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
Date:   Wed, 26 Jun 2019 09:05:22 +0800
In-Reply-To: <20190625221415.B0DC22086D@mail.kernel.org>
References: <1560138293-4163-1-git-send-email-weiyi.lu@mediatek.com>
         <20190625221415.B0DC22086D@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-25 at 15:14 -0700, Stephen Boyd wrote:
> Quoting Weiyi Lu (2019-06-09 20:44:53)
> > When using property assigned-clock-parents to assign parent clocks,
> > core clocks might still be disabled during re-parent.
> > Add flag 'CLK_OPS_CORE_ENABLE' for those clocks must be enabled
> > during re-parent.
> > 
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Can you further describe the scenario where this is a problem? Is it
> some sort of clk that is enabled by default out of the bootloader and is
> then configured to have an 'assigned-clock-parents' property to change
> the parent, but that clk needs to be "enabled" so that the framework
> turns on the parents for the parent switch?

When driver is built as module(.ko) and install at runtime after the
whole initialization stage. Clk might already be turned off before
configuring by assigned-clock-parents. For such clock design that need
to have clock enabled during re-parent, the configuration of
assigned-clock-parents might be failed. That's the problem we have now.
Do you have any suggestion for such usage of clocks? Many thanks.

> 


