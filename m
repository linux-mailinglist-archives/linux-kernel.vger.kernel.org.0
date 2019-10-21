Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14077DEAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfJULVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 07:21:53 -0400
Received: from [217.140.110.172] ([217.140.110.172]:49738 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfJULVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:21:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77069EBD;
        Mon, 21 Oct 2019 04:21:18 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F10E3F718;
        Mon, 21 Oct 2019 04:21:16 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:21:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, tglx@linutronix.de,
        David.Laight@ACULAB.COM, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hushiyuan@huawei.com, wuyun.wu@huawei.com, linfeilong@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5] arm64: psci: Reduce the waiting time for
 cpu_psci_cpu_kill()
Message-ID: <20191021112114.GC21581@bogus>
References: <710429cc-4d88-b7c3-b068-5459cf8133b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710429cc-4d88-b7c3-b068-5459cf8133b5@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:52:16PM +0800, Yunfeng Ye wrote:
> In cases like suspend-to-disk and suspend-to-ram, a large number of CPU
> cores need to be shut down. At present, the CPU hotplug operation is
> serialised, and the CPU cores can only be shut down one by one. In this
> process, if PSCI affinity_info() does not return LEVEL_OFF quickly,
> cpu_psci_cpu_kill() needs to wait for 10ms. If hundreds of CPU cores
> need to be shut down, it will take a long time.
> 
> Normally, there is no need to wait 10ms in cpu_psci_cpu_kill(). So
> change the wait interval from 10 ms to max 1 ms and use usleep_range()
> instead of msleep() for more accurate timer.
> 
> In addition, reducing the time interval will increase the messages
> output, so remove the "Retry ..." message, instead, track time and
> output to the the successful message.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
