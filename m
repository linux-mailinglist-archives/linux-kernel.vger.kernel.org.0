Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD26DC023A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2019 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfI0JY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Sep 2019 05:24:58 -0400
Received: from foss.arm.com ([217.140.110.172]:46778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0JY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:24:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51BBC28;
        Fri, 27 Sep 2019 02:24:57 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DFCB3F534;
        Fri, 27 Sep 2019 02:24:56 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:24:54 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        will@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v3 1/5] arm64: vdso32: Introduce COMPAT_CC_IS_GCC
Message-ID: <20190927092453.GA20642@arrakis.emea.arm.com>
References: <20190926214342.34608-1-vincenzo.frascino@arm.com>
 <20190926214342.34608-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926214342.34608-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:43:38PM +0100, Vincenzo Frascino wrote:
> Address the problem removing CONFIG_CROSS_COMPILE_COMPAT_VDSO and moving

And this config does need to go in a subsequent patch.

> the detection of the correct compiler into Kconfig via COMPAT_CC_IS_GCC.

Nitpick: it's COMPATCC_IS_ARM_GCC now.

> As a consequence of this it is not possible anymore to set the compat
> cross compiler from menuconfig but it requires to be exported via
> command line.
> 
> E.g.:
> 
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> CROSS_COMPILE_COMPAT=arm-linux-gnueabihf

Another nitpick, add a '-' at the end of 'gnueabihf'.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
