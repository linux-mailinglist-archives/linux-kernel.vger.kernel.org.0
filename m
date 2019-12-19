Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32AF7125F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfLSKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 05:42:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37663 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:42:37 -0500
Received: from [79.140.121.60] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihtGD-0001Mo-2y; Thu, 19 Dec 2019 10:42:25 +0000
Date:   Thu, 19 Dec 2019 11:42:24 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     qiwuchen55@gmail.com
Cc:     peterz@infradead.org, mingo@kernel.org, oleg@redhat.com,
        prsood@codeaurora.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, chenqiwu@xiaomi.com
Subject: Re: [PATCH v3] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191219104223.xvk6ppfogoxrgmw6@wittgenstein>
References: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1576736993-10121-1-git-send-email-qiwuchen55@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:29:53PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> When global init task get a chance to be killed, panic will happen in
> later calling steps by do_exit()->exit_notify()->forget_original_parent()
> ->find_child_reaper() if all init threads have exited.
> 
> However, it's hard to extract the coredump of init task from a kernel
> crashdump, since exit_mm() has released its mm before panic. In order
> to get the backtrace of init task in userspace, it's better to do panic
> earlier at the beginning of exitting route.
> 
> It's worth noting that we must take case of a multi-threaded init exitting
> issue. We need the test for is_global_init() && group_dead to ensure that
> it is all threads exiting and not just the current thread.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
