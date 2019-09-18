Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD4BB6159
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfIRKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 06:23:17 -0400
Received: from foss.arm.com ([217.140.110.172]:38712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIRKXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 06:23:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA0F337;
        Wed, 18 Sep 2019 03:23:16 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E209F3F59C;
        Wed, 18 Sep 2019 03:23:15 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: Fix GIC_LINE_NR accessor
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wanghaibin.wang@huawei.com
References: <1568789850-14080-1-git-send-email-yuzenghui@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <89645aea-70d4-8456-cb47-5a11846fa934@kernel.org>
Date:   Wed, 18 Sep 2019 11:23:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1568789850-14080-1-git-send-email-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2019 07:57, Zenghui Yu wrote:
> As per GIC spec, ITLinesNumber indicates the maximum SPI INTID that
> the GIC implementation supports. And the maximum SPI INTID an
> implementation might support is 1019 (field value 11111).
> 
> max(GICD_TYPER_SPIS(...), 1020) is not what we actually want for
> GIC_LINE_NR. Fix it to min(GICD_TYPER_SPIS(...), 1020).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> 
> Hi Marc,
> 
> I still see "GICv3: 992 SPIs implemented" on the host. I go back to
> https://patchwork.kernel.org/patch/11078623/ and it seems that we
> failed to make the GIC_LINE_NR correct at that time.

Ah, nice catch. Clearly, I didn't have my head screwed on properly when
I wrote this. I'll take this in for the next round of fixes.

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
