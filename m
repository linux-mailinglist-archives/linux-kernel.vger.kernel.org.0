Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0D155A10
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 15:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGOu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 09:50:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgBGOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 09:50:57 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j04xz-0005Xn-JC; Fri, 07 Feb 2020 15:50:47 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E6A85100F58; Fri,  7 Feb 2020 14:50:46 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: pat: Do not compile stubbed functions when X86_PAT is off
In-Reply-To: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
Date:   Fri, 07 Feb 2020 14:50:46 +0000
Message-ID: <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Those are already provided by linux/io.h as stubs.
>
> The conflict remains invisible until someone would pull {linux,asm}/io.h
> into memtype.c.

Err. memtype.c includes asm/io.h already. So it's just the PAT=n case
which is broken.

Thanks,

        tglx
