Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67A8E8C02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbfJ2Plk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 11:41:40 -0400
Received: from foss.arm.com ([217.140.110.172]:53556 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390107AbfJ2Plk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:41:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD2A01F1;
        Tue, 29 Oct 2019 08:41:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E49683F71F;
        Tue, 29 Oct 2019 08:41:38 -0700 (PDT)
Date:   Tue, 29 Oct 2019 15:41:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] arm64: print additional fault message when executing
 non-exec memory
Message-ID: <20191029154135.GD11440@arrakis.emea.arm.com>
References: <20191029124131.32028-1-zhengxiang9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029124131.32028-1-zhengxiang9@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:41:31PM +0800, Xiang Zheng wrote:
> When attempting to executing non-executable memory, the fault message
> shows:
> 
>   Unable to handle kernel read from unreadable memory at virtual address
>   ffff802dac469000
> 
> This may confuse someone, so add a new fault message for instruction
> abort.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Queued for 5.5. Thanks.

-- 
Catalin
