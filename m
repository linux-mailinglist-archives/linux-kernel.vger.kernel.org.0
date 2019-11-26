Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E5C10A557
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 21:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKZUUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 15:20:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42815 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:20:34 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZhJy-0005IH-Ri; Tue, 26 Nov 2019 21:20:26 +0100
Date:   Tue, 26 Nov 2019 21:20:26 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Barret Rhoden <brho@google.com>
Cc:     "Rik van Riel\"" <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: AVX register corruption from signal delivery
Message-ID: <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-26 14:49:55 [-0500], Barret Rhoden wrote:
> Hi -
Hi,

> The bug requires the kernel to be built with GCC 9 to trigger.  In
> particular, arch/x86/kernel/fpu/signal.c needs to be built with GCC 9.

I've been pinged already, I will look into this. Please send me a
.config just to be sure. From browsing over the bug CONFIG_PREEMPTION
was required.

> Thanks,
> 
> Barret

Sebastian
