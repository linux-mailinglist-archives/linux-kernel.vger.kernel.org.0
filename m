Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2200E95D96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfHTLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 07:40:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51719 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfHTLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:40:05 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i02Uc-0003ZY-PC; Tue, 20 Aug 2019 13:40:02 +0200
Date:   Tue, 20 Aug 2019 13:40:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Kelley <mikelley@microsoft.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        kimbrownkd <kimbrownkd@gmail.com>
Subject: Re: [Patch v2 1/1] genirq: Properly pair kobject_del with
 kobject_add
In-Reply-To: <1566264330-8609-1-git-send-email-mikelley@microsoft.com>
Message-ID: <alpine.DEB.2.21.1908201337420.2223@nanos.tec.linutronix.de>
References: <1566264330-8609-1-git-send-email-mikelley@microsoft.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019, Michael Kelley wrote:

> If alloc_descs fails before irq_sysfs_init has run, free_desc in the
> cleanup path will call kobject_del even though the kobject has not
> been added with kobject_add. Fix this by adding a new irq_sysfs_del
> function (within the #ifdef CONFIG_SYSFS) that conditionally calls
> kobject_del based on whether irq_sysfs_init has run.
> 
> This problem surfaced because commit aa30f47cf666
> ("kobject: Add support for default attribute groups to kobj_type")
> makes kobject_del stricter about pairing with kobject_add. If the
> pairing is incorrrect, a WARNING and backtrace occur in
> sysfs_remove_group because there is no parent.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
> Changes in v2:
> * Fix compile error by creating a separate irq_sysfs_del function
>   to do the conditional call to kobject_del, so that all references
>   to irq_kobj_base are under the #ifdef CONFIG_SYSFS.

Too late. I already fixed that up in the same way yesterday night:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=irq/urgent&id=d0ff14fdc987303aeeb7de6f1bd72c3749ae2a9b

The tip commit bot seems not to work right now, so you didn't get a notice.

Thanks,

	tglx
