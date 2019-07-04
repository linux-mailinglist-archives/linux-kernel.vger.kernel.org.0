Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177205F987
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 16:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGDOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 10:00:38 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:37011
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727199AbfGDOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:00:37 -0400
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 6F50421580;
        Thu,  4 Jul 2019 14:00:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Jul 2019 16:00:35 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
In-Reply-To: <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
Message-ID: <e2c50449b498c796de8258fac0b0aba6@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.1.5
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

thanks for feedback

>> This patchset adds the following changes to this pcengines-apuv2
>> platform device.
>> 
> 
> Before doing anything to this driver, what is the plan for previously
> upstreamed:
> 
> drivers/leds/leds-apu.c

I think we can remove the related APU2/APU3 code stuff from this driver.
The recently added pcengines-apuv2 driver does *not* support the APU1.
So I think we need the related APU1 stuff if we still want to support 
this board.

> arch/x86/platform/geode/alix.c

I think this is not related because this is a different platform driver.
Maybe we should move them to drivers/platform/x86?

Regards

Florian


