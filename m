Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13E34952
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2019 15:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfFDNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:07 -0400
Received: from foss.arm.com ([217.140.101.70]:44428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbfFDNtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46D20341;
        Tue,  4 Jun 2019 06:49:06 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 790F53F690;
        Tue,  4 Jun 2019 06:49:04 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:49:01 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        rostedt@goodmis.org, bigeasy@linutronix.de, suzuki.poulose@arm.com,
        will.deacon@arm.com, dave.martin@arm.com
Subject: Re: [PATCH] arm64/cpufeature: Convert hook_lock to raw_spin_lock_t
 in cpu_enable_ssbs()
Message-ID: <20190604134901.GE6610@arrakis.emea.arm.com>
References: <20190530113058.1988-1-julien.grall@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530113058.1988-1-julien.grall@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 12:30:58PM +0100, Julien Grall wrote:
> cpu_enable_ssbs() is called via stop_machine() as part of the cpu_enable
> callback. A spin lock is used to ensure the hook is registered before
> the rest of the callback is executed.
> 
> On -RT spin_lock() may sleep. However, all the callees in stop_machine()
> are expected to not sleep. Therefore a raw_spin_lock() is required here.
> 
> Given this is already done under stop_machine() and the work done under
> the lock is quite small, the latency should not increase too much.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>

Queued for 5.3. Thanks.

-- 
Catalin
