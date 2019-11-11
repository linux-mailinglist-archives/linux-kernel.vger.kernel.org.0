Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1A06F727F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 11:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKKKuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 05:50:32 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54588 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726843AbfKKKub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:50:31 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iU7HB-0008NY-Te; Mon, 11 Nov 2019 11:50:29 +0100
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] irqchip: Place =?UTF-8?Q?CONFIG=5FSIFIVE=5FPLIC=20int?=  =?UTF-8?Q?o=20the=20menu?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 11 Nov 2019 11:59:50 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
In-Reply-To: <20191002144452.10178-1-j.neuschaefer@gmx.net>
References: <20191002144452.10178-1-j.neuschaefer@gmx.net>
Message-ID: <47975c8088f558bab74db29871c78f1e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, hch@lst.de, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-02 15:54, Jonathan Neuschäfer wrote:
> Somehow CONFIG_SIFIVE_PLIC ended up outside of the "IRQ chip support"
> menu.
>
> Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied to irqchip-next.

         M.
-- 
Jazz is not dead. It just smells funny...
