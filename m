Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42BBD3D88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 12:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJKKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 06:38:21 -0400
Received: from foss.arm.com ([217.140.110.172]:56024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbfJKKiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:38:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68AA228;
        Fri, 11 Oct 2019 03:38:20 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 288213F703;
        Fri, 11 Oct 2019 03:38:19 -0700 (PDT)
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
 <20191011100521.GA5122@bogus>
From:   James Morse <james.morse@arm.com>
Message-ID: <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
Date:   Fri, 11 Oct 2019 11:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011100521.GA5122@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 11/10/2019 11:05, Sudeep Holla wrote:
> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
>> Recently I've got access to ARM Juno R1 board and did some tests with
>> current mainline kernel on it. I'm a bit surprised that enabling
>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
>> this Kconfig option, I get no single message from the kernel, although I
>> have earlycon enabled.

> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
> it boots fine.

I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.

My cmdline is:
| root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
| crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug


>> I've did my test with default defconfig and current linux-next,
>> v5.4-rc1, v5.3 and v4.19. In all cases the result is the same. I'm
>> booting kernel using a precompiled uboot from Linaro release and TFTP
>> download.

> OK, I use UEFI+GRUB but I don't think that should cause any issue.

... same ... this uboot binary looks like the main difference.
Is it using u-boots UEFI support? Is it possible to turn that off?

It may that lockdep is just perturbing the size of the binary. It adds an extra 4MB for me.


Thanks,

James
