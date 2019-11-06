Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DDF0D28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfKFDl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 22:41:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42846 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfKFDlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:41:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5BE8E151226D2;
        Tue,  5 Nov 2019 19:33:30 -0800 (PST)
Date:   Tue, 05 Nov 2019 19:33:27 -0800 (PST)
Message-Id: <20191105.193327.1393649190609263166.davem@davemloft.net>
To:     dima@arista.com
Cc:     linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, jslaby@suse.com, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        penguin-kernel@I-love.SAKURA.ne.jp, sparclinux@vger.kernel.org
Subject: Re: [PATCH 34/50] sparc: Add show_stack_loglvl()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191106030542.868541-35-dima@arista.com>
References: <20191106030542.868541-1-dima@arista.com>
        <20191106030542.868541-35-dima@arista.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 Nov 2019 19:33:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Safonov <dima@arista.com>
Date: Wed,  6 Nov 2019 03:05:25 +0000

> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Acked-by: David S. Miller <davem@davemloft.net>
