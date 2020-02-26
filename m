Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6493170CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 00:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBZXuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Feb 2020 18:50:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32799 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 18:50:52 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j76Ro-0000V9-4Q; Thu, 27 Feb 2020 00:50:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 99253100EA1; Thu, 27 Feb 2020 00:50:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <JGross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
In-Reply-To: <0BF722CE-26CF-43AC-A2E4-5C4639794159@amacapital.net>
References: <87k149p0na.fsf@nanos.tec.linutronix.de> <0BF722CE-26CF-43AC-A2E4-5C4639794159@amacapital.net>
Date:   Thu, 27 Feb 2020 00:50:35 +0100
Message-ID: <878skooqlw.fsf@nanos.tec.linutronix.de>
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

Andy Lutomirski <luto@amacapital.net> writes:
>> On Feb 26, 2020, at 12:13 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> ﻿Brian Gerst <brgerst@gmail.com> writes:
>> Now the question is whether we care about the packed stubs or just make
>> them larger by using alignment to get rid of this silly +0x80 and
>> ~vector fixup later on. The straight forward thing clearly has its charm
>> and I doubt it matters in measurable ways.
>
> I agree it probably doesn’t matter. That being said, I have a distinct
> memory of fixing that asm so it would fail the build if the alignment
> was off.

Hrm. Doesn't look like. Gah, and I love the hardcoded  * 8 in the IDT
code. Let me add something to catch such things in the future.

Thanks,

        tglx

