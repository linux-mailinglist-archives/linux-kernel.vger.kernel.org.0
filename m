Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E543F12461A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 12:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLRLtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 06:49:19 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:41229 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfLRLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 06:49:19 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ihXpI-0007MK-JJ; Wed, 18 Dec 2019 12:49:12 +0100
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings/irq: add binding for NXP INTMUX  interrupt multiplexer
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Dec 2019 11:49:12 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, "S.j. Wang" <shengjiu.wang@nxp.com>,
        <kernel@pengutronix.de>, <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andy Duan <fugang.duan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
In-Reply-To: <DB7PR04MB4618957D7423FFBAECD1EC7EE6530@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1576653615-27954-1-git-send-email-qiangqing.zhang@nxp.com>
 <1576653615-27954-2-git-send-email-qiangqing.zhang@nxp.com>
 <254925e345493019c3e1e558b37e46f2@www.loen.fr>
 <DB7PR04MB4618048D025D094618C6F99FE6530@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <DB7PR04MB4618957D7423FFBAECD1EC7EE6530@DB7PR04MB4618.eurprd04.prod.outlook.com>
Message-ID: <796eb027cbecbdc9dbc01b417d196a44@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, shengjiu.wang@nxp.com, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, fugang.duan@nxp.com, aisheng.dong@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-18 11:34, Joakim Zhang wrote:
>> -----Original Message-----
>> From: Joakim Zhang <qiangqing.zhang@nxp.com>
>> Sent: 2019年12月18日 18:22
>> To: Marc Zyngier <maz@kernel.org>
>> Cc: tglx@linutronix.de; jason@lakedaemon.net; robh+dt@kernel.org;
>> mark.rutland@arm.com; shawnguo@kernel.org; s.hauer@pengutronix.de; 
>> S.j.
>> Wang <shengjiu.wang@nxp.com>; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
>> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; Andy Duan 
>> <fugang.duan@nxp.com>;
>> Aisheng Dong <aisheng.dong@nxp.com>
>> Subject: RE: [PATCH 1/3] dt-bindings/irq: add binding for NXP INTMUX 
>> interrupt
>> multiplexer

[...]

>> > What I don't understand is how the interrupt descriptor can 
>> indicate
>> > which channel it is multiplexed on. The driver doesn't makes this
>> > clear either, and I strongly suspect that it was never tested with 
>> more than a
>> single channel...
>>
>> Yes, to be frank, I tested with a signle channel, I will take this 
>> into
>> consideration. Thanks.
> Hi Marc,
>
> I tested channels from 1 to 8, and no issue found.
>
> We register irq handler with irq_set_chained_handler_and_data(), so
> the interrupt descriptor could find the controller's private data, 
> and
> channel index is one part of private data.
> I think this can explain the interrupt descriptor how to indicate
> which channel it is multiplexed.

But that doesn't explain how the driver can find which channel a given
interrupts is wired to. Nothing in your binding shows how you can 
extract
the channel number from the interrupt descriptor. Nothing in the driver
even *computes* a channel number.

As far as I can see, you register a bunch of domains, all with the same
OF node, so all your interrupts end-up with the same domain. Is it 
really
what you expect?

This driver looks terribly wrong.

         M.
-- 
Jazz is not dead. It just smells funny...
