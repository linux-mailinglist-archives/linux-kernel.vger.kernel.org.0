Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2611185C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgCOLVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 07:21:23 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:59921 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgCOLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 07:21:23 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 85FC22800B1B3;
        Sun, 15 Mar 2020 12:21:21 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 522C71CDF33; Sun, 15 Mar 2020 12:21:21 +0100 (CET)
Date:   Sun, 15 Mar 2020 12:21:21 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip fixes for 5.6, take #2
Message-ID: <20200315112121.n5mucfsibs2eeudg@wunner.de>
References: <20200314103000.2413-1-maz@kernel.org>
 <20200315084846.h222n5pf4jvpojec@wunner.de>
 <76dcc2d8532f8e3a87bf03469b9c2c19@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76dcc2d8532f8e3a87bf03469b9c2c19@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 10:13:38AM +0000, Marc Zyngier wrote:
> On 2020-03-15 08:48, Lukas Wunner wrote:
> > Hm, I was hoping to see the BCM2835 irqchip fix in this pull:
> > 
> > https://lore.kernel.org/lkml/f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de/
> 
> Whilst I don't dispute that this patch addresses a serious issue,
> it is in no way an urgent fix -- the issue is already 7.5 year old,
> so a couple of week delay isn't going to change the world. Also,
> the system does work without this fix, so I'm quite confident
> leaving it for 5.7.
> 
> But thanks for this email anyway, as it reminded me that although
> I had picked that patch for 5.7, I didn't apply it just yet. This
> is now fixed, and the patch should be picked up by -next shortly.

Sure, fair enough, thanks.

Bonne fin de week-end,

Lukas
