Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD3136225
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 22:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAIVAW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Jan 2020 16:00:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55701 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgAIVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:00:21 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipeuU-0008IA-0O; Thu, 09 Jan 2020 22:00:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 730CF105BCE; Thu,  9 Jan 2020 22:00:05 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] x86/boot/KASLR: Fix unused variable warning
In-Reply-To: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
References: <20200103033929.4956-1-zhenzhong.duan@gmail.com>
Date:   Thu, 09 Jan 2020 22:00:05 +0100
Message-ID: <874kx4bb1m.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhenzhong Duan <zhenzhong.duan@gmail.com> writes:

> Local variable 'i' is referenced only when CONFIG_MEMORY_HOTREMOVE and
> CONFIG_ACPI are defined, but definition of variable 'i' is out of guard.
> If any of the two macros is undefined, below warning triggers during
> build, fix it by moving 'i' in the guard.
>
> arch/x86/boot/compressed/kaslr.c:698:6: warning: unused variable ‘i’ [-Wunused-variable]
>
> Also use true/false instead of 1/0 for boolean return.

No. This is not the scope of the unused variable issue. This want's to
be a separate patch.

Thanks,

        tglx
