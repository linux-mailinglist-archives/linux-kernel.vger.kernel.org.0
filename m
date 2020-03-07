Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3B17CDCA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Mar 2020 12:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGL17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Mar 2020 06:27:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55439 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgCGL17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:27:59 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jAXcV-0005PB-7a; Sat, 07 Mar 2020 12:27:51 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 98600104088; Sat,  7 Mar 2020 12:27:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: Is this code chunk in init_apic_mappings() superfluous?
In-Reply-To: <978293b9-8e9f-55f6-6ec4-e2d66c4db0de@cn.fujitsu.com>
References: <978293b9-8e9f-55f6-6ec4-e2d66c4db0de@cn.fujitsu.com>
Date:   Sat, 07 Mar 2020 12:27:50 +0100
Message-ID: <87imjg9zgp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cao jin <caoj.fnst@cn.fujitsu.com> writes:
> Hi,
>
> I am trying to figure the following code chunk out:
>
> 	if (x2apic_mode) {
> 		boot_cpu_physical_apicid = read_apic_id();
> 		return;
> 	}
>
> As my understanding, even in x2APIC mode, boot_cpu_physical_apicid is
> also got via early_acpi_process_madt --> ... --> register_lapic_address,
> so, is it for any corner case I am not aware?

The case when there are neither ACPI nor valid mptables. Unlikely, but
possible in theory.

Thanks,

        tglx
