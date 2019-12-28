Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1E12BDB9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Dec 2019 15:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfL1ODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Dec 2019 09:03:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:49520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1ODf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:03:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0112B193;
        Sat, 28 Dec 2019 14:03:33 +0000 (UTC)
Subject: Re: [PATCH v4 0/8] ARM: Initial RTD1195 and MeLE X1000 & Horseradish
 support
To:     linux-realtek-soc@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>, James Tai <james.tai@realtek.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20191123203759.20708-1-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <0b8a87e8-057a-27ff-ff10-d1c09d55a585@suse.de>
Date:   Sat, 28 Dec 2019 15:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.11.19 um 21:37 schrieb Andreas Färber:
> Andreas Färber (8):
>    dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
>    ARM: Prepare Realtek RTD1195
>    ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
>    ARM: dts: rtd1195: Exclude boot ROM from memory ranges
>    ARM: dts: rtd1195: Introduce r-bus
>    dt-bindings: arm: realtek: Add Realtek Horseradish EVB
>    ARM: dts: rtd1195: Add Realtek Horseradish EVB

Applied these to linux-realtek.git:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.6/dt
https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.6/soc

>    ARM: realtek: Enable RTD1195 arch timer

Holding this one back still.

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
