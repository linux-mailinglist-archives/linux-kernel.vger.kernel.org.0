Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86810CFAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbfJHM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 08:57:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:57969 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730944AbfJHM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:57:32 -0400
Received: from localhost (91.red-2-139-156.staticip.rima-tde.net [2.139.156.91])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A0E1D240004;
        Tue,  8 Oct 2019 12:57:28 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: marvell: add ESPRESSObin variants
In-Reply-To: <87a7abtn0y.fsf@FE-laptop>
References: <20190603155354.3902-1-tmn505@gmail.com> <87a7abtn0y.fsf@FE-laptop>
Date:   Tue, 08 Oct 2019 14:57:27 +0200
Message-ID: <877e5ftmx4.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Tomasz Maciej Nowak,
>
>> This commit adds dts for different variants of ESPRESSObin board:
>>
>> ESPRESSObin with soldered eMMC,
>>
>> ESPRESSObin V7, compared to prior versions some passive elements changed
>> and ethernet ports labels positions have been reversed,
>>
>> ESPRESSObin V7 with soldered eMMC.
>>
>> Since most of elements are the same, one common dtsi is created and
>> referenced in each dts of particular variant.
>>
>> Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
>
>
> Applied on mvebu/dt

I meant mvebu/dt64

>
> Sorry for the delay.
>
> Thanks,
>
> Gregory
-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
