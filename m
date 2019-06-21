Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250F74E39B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFUJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 05:33:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40477 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:33:07 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id E0B1160007;
        Fri, 21 Jun 2019 09:33:03 +0000 (UTC)
Date:   Fri, 21 Jun 2019 11:33:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        Nicolas.Ferre@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        claudiu.beznea@gmail.com
Subject: Re: [PATCH 0/7] clk: at91: sckc: improve error path
Message-ID: <20190621093302.GJ23549@piout.net>
References: <1560440205-4604-1-git-send-email-claudiu.beznea@microchip.com>
 <20190618095521.GE23549@piout.net>
 <929ac20b-db1d-3f7a-b37c-0dfb253156d5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929ac20b-db1d-3f7a-b37c-0dfb253156d5@microchip.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2019 10:30:42+0000, Claudiu.Beznea@microchip.com wrote:
> Hi,
> 
> On 18.06.2019 12:55, Alexandre Belloni wrote:
> > On 13/06/2019 15:37:06+0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> Hi,
> >>
> >> This series tries to improve error path for slow clock registrations
> >> by adding functions to free resources and using them on failures.
> >>
> > 
> > Does the platform even boot when the slow clock is not available? 
> > 
> > The TCB clocksource would fail at:
> > 
> >         tc.slow_clk = of_clk_get_by_name(node->parent, "slow_clk");
> >         if (IS_ERR(tc.slow_clk))
> >                 return PTR_ERR(tc.slow_clk);
> > 
> 
> In case of using TC as clocksource, yes, the platform wouldn't boot if slow
> clock is not available, because, anyway the TC needs it. PIT may work
> without it (if slow clock is not used to drive the PIT).
> 
> For sure there are other IPs (which may be or are driven by slow clock)
> which may not work if slow clock is driven them.
> 
> Anyway, please let me know if you feel this series has no meaning.
> 

Well, I'm not sure it is worth it but at the same time, it is not adding
many lines and you already developed it...


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
