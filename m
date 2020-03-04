Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3384179093
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbgCDMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 07:46:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47291 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgCDMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:46:36 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9TPp-0003QV-Ke; Wed, 04 Mar 2020 13:46:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E2994101161; Wed,  4 Mar 2020 13:46:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 06/24] x86/idtentry: Provide macros to define/declare IDT entry points
In-Reply-To: <9382db5c-90e2-f5bc-279e-9c92e282b0b3@oracle.com>
References: <20200225221606.511535280@linutronix.de> <20200225222648.772492410@linutronix.de> <9382db5c-90e2-f5bc-279e-9c92e282b0b3@oracle.com>
Date:   Wed, 04 Mar 2020 13:46:20 +0100
Message-ID: <87o8tcl23n.fsf@nanos.tec.linutronix.de>
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
>> +#else /* !__ASSEMBLY__ */
>> +
>> +/* Defines for ASM code to construct the IDT entries */
>> +#define DECLARE_IDTENTRY(vector, func)				\
>> +	idtentry vector asm_##func func has_error_code=0
>
> Should be DEFINE_IDENTRY(), no? Like the comment says: "Defines for
> ..."

No. That's my confused brain. DECLARE_IDTENTRY is used for declarations
in C code and for emitting the ASM stubs when included from entry*.S

I'll reword the comment and add some more documentation.

Thanks,

        tglx
