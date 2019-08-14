Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C748D80A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfHNQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:26:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55626 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:26:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::202])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C5767154B4BAA;
        Wed, 14 Aug 2019 09:26:21 -0700 (PDT)
Date:   Wed, 14 Aug 2019 12:26:18 -0400 (EDT)
Message-Id: <20190814.122618.1414289033357500978.davem@davemloft.net>
To:     mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        akpm@linux-foundation.org, bigeasy@linutronix.de, bp@suse.de,
        catalin.marinas@arm.com, hch@lst.de, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
        will@kernel.org
Subject: Re: [PATCH 6/9] sparc/perf: correctly check for kthreads
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190814104131.20190-7-mark.rutland@arm.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
        <20190814104131.20190-7-mark.rutland@arm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 14 Aug 2019 09:26:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 14 Aug 2019 11:41:28 +0100

> The sparc perf_callchain_user() functions looks at current->mm,
> apparently to determine whether the thread is a kthread without any
> valid user context.
> 
> In general, a non-NULL current->mm doesn't imply that current is a
> kthread, as kthreads can install an mm via use_mm(), and so it's
> preferable to use is_kthread() to determine whether a thread is a
> kthread.
> 
> For consistency, let's use is_kthread() here.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
