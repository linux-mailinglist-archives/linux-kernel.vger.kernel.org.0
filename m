Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A1D40AC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfJKNLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Oct 2019 09:11:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfJKNLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 09:11:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF4E28;
        Fri, 11 Oct 2019 06:11:05 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F2A93F6C4;
        Fri, 11 Oct 2019 06:11:04 -0700 (PDT)
Date:   Fri, 11 Oct 2019 14:10:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: ARM Juno r1 + CONFIG_PROVE_LOCKING=y => boot failure
Message-ID: <20191011131058.GA26061@bogus>
References: <CGME20191011092604eucas1p1ca11ab9c4c7508776914b0eb4f35e69b@eucas1p1.samsung.com>
 <33a83dce-e9f0-7814-923b-763d33e70257@samsung.com>
 <20191011100521.GA5122@bogus>
 <7655fb41-cd13-0bc4-e656-040e0875bab8@arm.com>
 <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bf88cd2-9c4f-11dc-4b70-f717de891cff@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:02:42PM +0200, Marek Szyprowski wrote:
> Hi James,
>
> On 11.10.2019 12:38, James Morse wrote:
> > Hi guys,
> >
> > On 11/10/2019 11:05, Sudeep Holla wrote:
> >> On Fri, Oct 11, 2019 at 11:26:04AM +0200, Marek Szyprowski wrote:
> >>> Recently I've got access to ARM Juno R1 board and did some tests with
> >>> current mainline kernel on it. I'm a bit surprised that enabling
> >>> CONFIG_PROVE_LOCKING causes a boot failure on this board. After enabling
> >>> this Kconfig option, I get no single message from the kernel, although I
> >>> have earlycon enabled.
> >> I don't have Juno R1 but I tried defconfig + CONFIG_PROVE_LOCKING and
> >> it boots fine.
> > I just tried this on my r1, v5.4-rc1 with this configuration worked just fine.
> >
> > My cmdline is:
> > | root=/dev/sda6 loglevel=9 earlycon=pl011,0x7ff80000 hugepagesz=2M hugepages=512
> > | crashkernel=1G console=ttyAMA0 resume=/dev/sda2 no_console_suspend efi=debug
> >
> That is a bit strange. Here is a boot log from v5.4-rc1 with pure
> defconfig: https://paste.debian.net/1105851/
>

I see from the boot log that both Image.gz and dtb being loaded at the
same address 0x82000000, will u-boot uncompress it elsewhere after loading
it ? Just for my understanding.

--
Regards,
Sudeep
