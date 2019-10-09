Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E7D0834
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2019 09:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfJIHXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Oct 2019 03:23:55 -0400
Received: from mail.thorsis.com ([92.198.35.195]:57054 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIHXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:23:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id E36591D96;
        Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WXhAdvPmirQB; Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id C44664755; Wed,  9 Oct 2019 09:24:22 +0200 (CEST)
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable autolearn_force=no version=3.4.2
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Gene Heskett <gheskett@shentel.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.72-rt25
Date:   Wed, 09 Oct 2019 09:23:49 +0200
Message-ID: <74795460.9uHKpU0Xat@ada>
In-Reply-To: <201910071516.04269.gheskett@shentel.net>
References: <20190916173921.6368cd62@gandalf.local.home> <201910071510.05101.gheskett@shentel.net> <201910071516.04269.gheskett@shentel.net>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gene,

Am Montag, 7. Oktober 2019, 15:16:04 CEST schrieb Gene Heskett:
> On Monday 07 October 2019 15:10:05 Gene Heskett wrote:
> > Unfortunately, this does not work for the pi3-4 family. When its all
> > pulled in and patched, there is no arch/arm/configs bcm2709_defconfig
> > or bcm2711_defconfig for either a pi3b or the new pi4b.
> > 
> > I'll go find the 5.2.14 announce and see if its any more complete.
> 
> Its disappeared.

Not quite. Those were never (?) there. ;-)

You'll find those files in the raspberrypi tree [1], but not in mainline. 

It is possible to run a vanilla kernel on RPi 1 to 3, I guess the 
'multi_v7_defconfig' is a good start for 2 and 3. (This works, I have a 
running RPi 3 with unpatched mainline kernel on my desk, without RT however.)

IIRC from linux-arm-kernel list, basic support for RPi 4 is still under review 
and not yet present in mainline?

So you could try a RPi 2 or 3 with mainline + RT or you try to apply the RT 
patches to the vendor/raspberry tree, but I would not count on anyone 
supporting the latter.

HTH & Greets
Alex

[1] https://github.com/raspberrypi/linux

