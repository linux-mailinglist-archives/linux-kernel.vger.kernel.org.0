Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B951A105A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 20:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKUT1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 14:27:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUT1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:27:39 -0500
Received: from oasis.local.home (unknown [66.170.99.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61B22068F;
        Thu, 21 Nov 2019 19:27:38 +0000 (UTC)
Date:   Thu, 21 Nov 2019 14:27:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@suse.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: KASAN_INLINE && patchable-function-entry
Message-ID: <20191121142737.69978ef9@oasis.local.home>
In-Reply-To: <20191121183630.GA3668@lakrids.cambridge.arm.com>
References: <20191121183630.GA3668@lakrids.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 18:36:32 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> As a heads-up to the ftrace folk, I think it's possible to work around
> this specific issue in the kernel by allowing the arch code to filter
> out call sites at init time (probably in ftrace_init_nop()), but I
> haven't put that together yet.

If you need to make some code invisible to ftrace at init time, it can
be possible by setting the dyn_ftrace rec flag to DISABLED, but this
can be cleared, which we would need a way to keep it from being
cleared, which shouldn't be too hard.

Is that what you would be looking for?

-- Steve
