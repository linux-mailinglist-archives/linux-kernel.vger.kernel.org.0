Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74898167005
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 08:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgBUHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 02:07:35 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34436 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUHH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:07:27 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 7A7292006FB;
        Fri, 21 Feb 2020 07:07:25 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 493CF20AA1; Fri, 21 Feb 2020 07:07:56 +0100 (CET)
Date:   Fri, 21 Feb 2020 07:07:56 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/5] Enable pt_regs based syscalls for x86-32 native
Message-ID: <20200221060756.GA3368@light.dominikbrodowski.net>
References: <20200221050934.719152-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221050934.719152-1-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian,

On Fri, Feb 21, 2020 at 12:09:29AM -0500, Brian Gerst wrote:
> This patch series cleans up the x86 syscall wrapper code and converts
> the 32-bit native kernel over to pt_regs based syscalls.

thanks for your patchset. Could you explain a bit more what the rationale
is. Due to asmlinkage, it doesn't leak "random user-provided register
content down the call chain" (as was the case for x86-64). But it may be
cleaner, and you mention in patch 5/5 that the new way is "a bit more
efficient" -- do you have numbers?

Thanks,
	Dominik
