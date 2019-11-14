Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0AFC910
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 15:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfKNOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 09:40:40 -0500
Received: from foss.arm.com ([217.140.110.172]:44282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfKNOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 09:40:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D181328;
        Thu, 14 Nov 2019 06:40:40 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501733F52E;
        Thu, 14 Nov 2019 06:40:39 -0800 (PST)
Date:   Thu, 14 Nov 2019 14:40:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     will@kernel.org, john.garry@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Kconfig: add a choice for endianness
Message-ID: <20191114144036.GA63366@arrakis.emea.arm.com>
References: <20191113092652.28201-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113092652.28201-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:26:52AM +0100, Anders Roxell wrote:
> When building allmodconfig KCONFIG_ALLCONFIG=$(pwd)/arch/arm64/configs/defconfig
> CONFIG_CPU_BIG_ENDIAN gets enabled. Which tends not to be what most
> people want. Another concern that has come up is that ACPI isn't built
> for an allmodconfig kernel today since that also depends on !CPU_BIG_ENDIAN.
> 
> Rework so that we introduce a 'choice' and default the choice to
> CPU_LITTLE_ENDIAN. That means that when we build an allmodconfig kernel
> it will default to CPU_LITTLE_ENDIAN that most people tends to want.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Queued for 5.5 (with the typo fixed). Thanks.

-- 
Catalin
