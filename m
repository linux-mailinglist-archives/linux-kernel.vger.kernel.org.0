Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEAE7F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 05:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfJ2ElD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 00:41:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:43470 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728453AbfJ2ElC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 00:41:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E11CAD14;
        Tue, 29 Oct 2019 04:41:01 +0000 (UTC)
Subject: Re: [PATCH v2 8/8] arm64: dts: realtek: Add RTD1296 and Synology
 DS418
To:     linux-realtek-soc@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, info@synology.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191020040817.16882-1-afaerber@suse.de>
 <20191020040817.16882-9-afaerber@suse.de>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <8e666996-7e6f-dd25-92c7-18218106658c@suse.de>
Date:   Tue, 29 Oct 2019 05:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020040817.16882-9-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.10.19 um 06:08 schrieb Andreas Färber:
> Add Device Trees for RTD1296 SoC and Synology DiskStation DS418.
> 
> Cc: info@synology.com
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Moved SPDX-License-Identifier to top
>  * Dropped "arm,armv8" (Rob)
>  * Changed from MIT to BSD-2-Clause (Rob)
>  * Dropped accidental enable-method and cpu-release-addr
>  * Fixed DS418 to use rtd1296.dtsi
>  
>  arch/arm64/boot/dts/realtek/Makefile          |  2 +
>  arch/arm64/boot/dts/realtek/rtd1296-ds418.dts | 30 +++++++++++++
>  arch/arm64/boot/dts/realtek/rtd1296.dtsi      | 65 +++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi

Applied to linux-realtek.git v5.5/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v5.5/dt64

Regards,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
