Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 442EA50627
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 11:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfFXJv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 05:51:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfFXJv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:51:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F3562B;
        Mon, 24 Jun 2019 02:51:27 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B192C3F71E;
        Mon, 24 Jun 2019 02:51:25 -0700 (PDT)
Date:   Mon, 24 Jun 2019 10:51:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        ard.biesheuvel@linaro.org, broonie@kernel.org,
        mark.rutland@arm.com, Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
Message-ID: <20190624095122.GA29120@arrakis.emea.arm.com>
References: <20190620003244.261595-1-ndesaulniers@google.com>
 <20190620074640.GA27228@brain-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620074640.GA27228@brain-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 08:46:58AM +0100, Will Deacon wrote:
> On Wed, Jun 19, 2019 at 05:32:42PM -0700, Nick Desaulniers wrote:
> > Generated via:
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
> > <enable CONFIG_RANDOMIZE_BASE aka KASLR>
> > $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make savedefconfig
> > $ mv defconfig arch/arm64/configs/defconfig
[...]
> Irrespective of the above, I know Catalin was running into issues with his
> automated tests where the kernel would die silently during early boot with
> some seeds.  That's a bit rubbish if it's still the case -- Catalin?

I stopped seeing these failures about 1-2 months ago, not sure exactly
what changed. I'm ok to enable KASLR in defconfig.

-- 
Catalin
