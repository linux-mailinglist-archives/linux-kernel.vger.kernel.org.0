Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFC631790F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 14:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbgCDNKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 08:10:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47336 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbgCDNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 08:10:15 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9Tmf-0003gq-Ff; Wed, 04 Mar 2020 14:09:57 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E62A8101161; Wed,  4 Mar 2020 14:09:56 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 08/24] x86/entry: Convert Divide Error to IDTENTRY
In-Reply-To: <4afd832a-2a78-798a-97e0-d1e3636cc290@oracle.com>
References: <20200225221606.511535280@linutronix.de> <20200225222648.970676604@linutronix.de> <4afd832a-2a78-798a-97e0-d1e3636cc290@oracle.com>
Date:   Wed, 04 Mar 2020 14:09:56 +0100
Message-ID: <87lfogl10b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 2/25/20 11:16 PM, Thomas Gleixner wrote:
>> +/* Simple exception entries: */
>> +DECLARE_IDTENTRY(X86_TRAP_DE,		exc_divide_error);
>> +
>
> I think this macro has a tricky behavior because it will declare C functions
> when included in a C file, and define assembly idtentry when included in an
> assembly file.
>
> I see your point which is to have a single statement which provides both C
> and assembly functions, but this dual behavior is not obvious when reading
> the code. Maybe add a comment to explain this behavior?

Done.
