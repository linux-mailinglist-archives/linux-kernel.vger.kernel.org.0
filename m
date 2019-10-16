Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3DD8FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbfJPLqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Oct 2019 07:46:15 -0400
Received: from foss.arm.com ([217.140.110.172]:37602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbfJPLqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:46:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B591B28;
        Wed, 16 Oct 2019 04:46:14 -0700 (PDT)
Received: from [10.1.31.184] (e121487-lin.cambridge.arm.com [10.1.31.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E0043F6C4;
        Wed, 16 Oct 2019 04:46:12 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: add JFFS FS support in defconfig
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Tan Ley Foon <ley.foon.tan@intel.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1571218528-12126-1-git-send-email-joyce.ooi@intel.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <8869edbc-e7b4-dfb3-1567-740132820133@arm.com>
Date:   Wed, 16 Oct 2019 12:46:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1571218528-12126-1-git-send-email-joyce.ooi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/19 10:35 AM, Ooi, Joyce wrote:
> This patch adds JFFS2 FS support and remove QSPI Sector 4K size force in
> the default defconfig
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9adae4..6080c6e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -860,3 +860,5 @@ CONFIG_DEBUG_KERNEL=y
>  # CONFIG_DEBUG_PREEMPT is not set
>  # CONFIG_FTRACE is not set
>  CONFIG_MEMTEST=y
> +CONFIG_JFFS2_FS=y
> +CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=n
                                   ^^^^
This is incorrect syntax for disabling config option. Correct one is

# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set

However, it looks to me you want to remove it from defconfig rather than
force it to be unset.

Cheers
Vladimir
