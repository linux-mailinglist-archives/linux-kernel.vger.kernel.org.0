Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E31D8122
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbfJOUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 16:34:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39658 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbfJOUeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:34:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0F56515099D86;
        Tue, 15 Oct 2019 13:34:15 -0700 (PDT)
Date:   Tue, 15 Oct 2019 13:34:14 -0700 (PDT)
Message-Id: <20191015.133414.946929614650400310.davem@davemloft.net>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 19/34] sparc: Use CONFIG_PREEMPTION
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191015191821.11479-20-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
        <20191015191821.11479-20-bigeasy@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 13:34:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 15 Oct 2019 21:18:06 +0200

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the trap code over to use CONFIG_PREEMPTION.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +Kconfig]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
