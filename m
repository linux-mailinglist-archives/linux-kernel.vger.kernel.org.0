Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEA4E5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 12:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFUK1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 06:27:48 -0400
Received: from foss.arm.com ([217.140.110.172]:57742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfFUK1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:27:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB399147A;
        Fri, 21 Jun 2019 03:27:47 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69C6D3F718;
        Fri, 21 Jun 2019 03:27:46 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:27:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, marc.zyngier@arm.com, yuzenghui@huawei.com,
        wanghaibin.wang@huawei.com, james.morse@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com, liwei391@huawei.com
Subject: Re: [PATCH v4 0/8] arm64: IRQ priority masking and Pseudo-NMI fixes
Message-ID: <20190621102743.GE18954@arrakis.emea.arm.com>
References: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560245893-46998-1-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:38:05AM +0100, Julien Thierry wrote:
> Julien Thierry (7):
>   arm64: Do not enable IRQs for ct_user_exit
>   arm64: irqflags: Pass flags as readonly operand to restore instruction
>   arm64: irqflags: Add condition flags to inline asm clobber list
>   arm64: Fix interrupt tracing in the presence of NMIs
>   arm64: Fix incorrect irqflag restore for priority masking
>   arm64: irqflags: Introduce explicit debugging for IRQ priorities
>   arm64: Allow selecting Pseudo-NMI again
> 
> Wei Li (1):
>   arm64: fix kernel stack overflow in kdump capture kernel

I queued these patches for 5.3 (and should appear in next soon). Thanks.

-- 
Catalin
