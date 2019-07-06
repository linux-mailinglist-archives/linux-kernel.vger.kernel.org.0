Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570BF610B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2019 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfGFMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jul 2019 08:44:07 -0400
Received: from mailoutvs28.siol.net ([185.57.226.219]:58288 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726177AbfGFMoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 08:44:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 6DACA5214EA;
        Sat,  6 Jul 2019 14:44:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Prsy93oeYZ8N; Sat,  6 Jul 2019 14:44:04 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 28DBE521500;
        Sat,  6 Jul 2019 14:44:04 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id DF9C55214EA;
        Sat,  6 Jul 2019 14:44:03 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     wens@csie.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: axp20x: fix DCDCA and DCDCD for AXP806
Date:   Sat, 06 Jul 2019 14:44:03 +0200
Message-ID: <24416869.PQYcAB5yxk@jernej-laptop>
In-Reply-To: <20190706112144.GH20625@sirena.org.uk>
References: <20190706100545.22759-1-jernej.skrabec@siol.net> <20190706100545.22759-2-jernej.skrabec@siol.net> <20190706112144.GH20625@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 06. julij 2019 ob 13:21:44 CEST je Mark Brown napisal(a):
> On Sat, Jul 06, 2019 at 12:05:44PM +0200, Jernej Skrabec wrote:
> > Refactoring of the driver introduced few bugs in AXP806's DCDCA and
> > DCDCD regulator definitions.
> 
> This is not a great changelog - what are the bugs and how does
> this patch fix them?

In case of DCDCA, number of steps for second range should be 20 (0x14), but it 
was set to 14. So I guess patch author missed "0x".  Currently, math doesn't 
work, because sum of both number of steps plus 2 must be equal to number of 
voltages macro.

Same error is present in AXP803 DCDC6 regulator.

In case of DCDCD, array of ranges (axp806_dcdcd_ranges) contains two ranges, 
which use same start and end macros. By checking datasheet or just checking 
macros at the top of the source file, it's obvious that "1" is missing in 
second range macro names (1600 instead of 600). 

And I think I found another bug, AXP803_DCDC5_NUM_VOLTAGES should be 69 and 
not 68. However, this bug was present before refactoring, refactoring just 
carried it over.

Best regards,
Jernej


