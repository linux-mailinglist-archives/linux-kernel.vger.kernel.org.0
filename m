Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F179E2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 10:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfH0Id2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 04:33:28 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:54256 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0Id1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:33:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id E7A9A3F682;
        Tue, 27 Aug 2019 10:33:24 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=i9hoGhm0;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j98srYuiQh1g; Tue, 27 Aug 2019 10:33:23 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B6F933F532;
        Tue, 27 Aug 2019 10:33:22 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 771FF360185;
        Tue, 27 Aug 2019 10:33:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566894802; bh=zeAGklUjn9OIL0r7umNJ4mAipEito7bY6o7mUyoyTwg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i9hoGhm08kUy+j0i2BFJxe31nt4xQXmrNwDIrgFAVpOYaolLrOpI3Yg2i2iHfoALs
         dGQ1fQ3+2d4fMDSYaTgRcJaXgo3BQx3glZWh6vPJo1wQa6AlQ9g1cBdxi1YmalAksT
         Gxa/JxEygK35uUwLEZn2J202Ws3gdbnnHfrGxuPM=
Subject: Re: [PATCH v2 0/4] Add support for updated vmware hypercall
 instruction
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20190823081316.28478-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <637758e2-302f-24ca-5b18-12590c70be33@shipmail.org>
Date:   Tue, 27 Aug 2019 10:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190823081316.28478-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

On 8/23/19 10:13 AM, Thomas Hellström (VMware) wrote:
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
>
> VMware has started using "vmcall" / "vmmcall" instead of an inl instruction
> for the "backdoor" interface. This series detects support for those
> instructions.
> Outside of the platform code we use the "ALTERNATIVES" self-patching
> mechanism similarly to how this is done with KVM.
> Unfortunately we need two new x86 CPU feature flags for this, since we need
> the default instruction to be "inl". IIRC the vmmouse driver is used by
> other virtualization solutions than VMware, and those might break if
> they encounter any of the other instructions.
>
> v2:
> - Address various style review comments
> - Use mnemonics instead of bytecode in the ALTERNATIVE_2 macros
> - Use vmcall / vmmcall also for the High-Bandwidth port calls
> - Change the %edx argument to what vmcall / vmmcall expect (flags instead of
>    port number). The port number is added in the default ALTERNATIVE_2 path.
> - Ack to merge the vmmouse patch from Dmitry.
> - Drop license update for now. Will get back with a freestanding patch.
Are you OK taking the above series through the x86 tree? In addition to 
the ack from Dmitry to do this for the vmmouse patch, there's also an 
ack from Dave to do the same for vmwgfx.

Thanks,
Thomas

