Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADA9136A48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbgAJJws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 04:52:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33866 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbgAJJwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 04:52:47 -0500
Received: from zn.tnic (p200300EC2F0ACA0024F85FB92EE88C9E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:24f8:5fb9:2ee8:8c9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53CDB1EC0CAD;
        Fri, 10 Jan 2020 10:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578649966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5epvbT5Q+4YBNi/Ruaz9zmEaYwVUahV3ncN16fuSWvw=;
        b=iZW6arOxsEahhXS7L0+rc1bHejr5o7mneglg4DIhJUw0XHb+j+g6lJ+5mIfqzY0YQFdWJQ
        lFaXS2LMFTfqJg6dvxIgDlJOonwWTOZF6wubQ7nkabAZ7sJfN6JjIaTCm5wLJYGZ186yI3
        j7L5VU3qdJYEzCSTc0xocL+LX+jmI+U=
Date:   Fri, 10 Jan 2020 10:52:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] x86/boot/KASLR: Fix unused variable warning
Message-ID: <20200110095243.GE19453@zn.tnic>
References: <20200110094304.446-1-zhenzhong.duan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110094304.446-1-zhenzhong.duan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 05:43:04PM +0800, Zhenzhong Duan wrote:
> Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
> If any of the two macros is undefined, below warning triggers during
> build with 'make EXTRA_CFLAGS=-Wall binrpm-pkg', fix it by moving 'i'
> in the guard.

Maybe I wasn't clear: save this patch for when it triggers in the normal
build, without additional build flags.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
