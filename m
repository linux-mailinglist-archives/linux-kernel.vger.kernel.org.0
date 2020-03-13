Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0218522D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Mar 2020 00:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCMXSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 19:18:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48224 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:18:17 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCtZ0-0004YE-JN; Sat, 14 Mar 2020 00:17:59 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0451E101115; Sat, 14 Mar 2020 00:17:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 07/13] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <20200313151618.GB32144@lenoir>
References: <20200308222359.370649591@linutronix.de> <20200308222609.621492144@linutronix.de> <20200313151618.GB32144@lenoir>
Date:   Sat, 14 Mar 2020 00:17:57 +0100
Message-ID: <87zhcjdeu2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:

> On Sun, Mar 08, 2020 at 11:24:06PM +0100, Thomas Gleixner wrote:
>> Now that the C entry points are safe, move the irq flags tracing code into
>> the entry helper.
>>
>
> The consolidation is most welcome but the changelog is still a bit
> misleading. The fact that the C entry points are now safe doesn't
> make irq flags tracing safe itself.

Yes, that comes in a later patch. Bah. And of course I'm reworking this
ATM with the new section magic and analyzing the fallout with help of
the objtool extension Peter did for this.

Still writing changelogs and trying to make sense of things we find that
way.

Thanks,

        tglx
