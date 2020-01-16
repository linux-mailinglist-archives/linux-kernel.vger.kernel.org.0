Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 010BA13D133
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 01:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgAPAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 19:38:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49697 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729012AbgAPAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:38:56 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irtBR-0004Vs-3c; Thu, 16 Jan 2020 01:38:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 922B510121C; Thu, 16 Jan 2020 01:38:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mukesh Ojha <mojha@codeaurora.org>, mingo@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH] irq_work: Fix comment for irq_work_run()
In-Reply-To: <0101016eeb1507c9-0db4e0b6-011c-4754-a34c-9ef0b078b23b-000000@us-west-2.amazonses.com>
References: <0101016eeb1507c9-0db4e0b6-011c-4754-a34c-9ef0b078b23b-000000@us-west-2.amazonses.com>
Date:   Thu, 16 Jan 2020 01:38:48 +0100
Message-ID: <87zheow7zb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mukesh Ojha <mojha@codeaurora.org> writes:

> hotplug_cfd() does not exist anymore, update the
> comment for irq_work_run() with smpcfd_dying_cpu().

That's only half of the truth. Just check the output of:

git grep irq_work_run

So even if the s/hotplug_cfd/smpcfd_dying_cpu/ change is correct, this
comment is actively misleading.

Thanks,

        tglx
