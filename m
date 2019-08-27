Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4B9F333
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 21:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfH0TTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 15:19:15 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:4025 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0TTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:19:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 732364059E;
        Tue, 27 Aug 2019 21:19:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=EPvQRxv7;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-2.099 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zu0RvCVW-pqz; Tue, 27 Aug 2019 21:19:06 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 388B1405F0;
        Tue, 27 Aug 2019 21:19:04 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id B95A436014E;
        Tue, 27 Aug 2019 21:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1566933544; bh=U6aBWjUWM6fEeaY29MHDvEVPT7WoNvsf/aWbWHi01ms=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EPvQRxv7iMa6p0KoJfJihtF4Sht/v2H+qZfzTy34GNGVopgtL3/IFt8HblxG3zp1q
         Fnan90CcmCkhp7sdmfZ0zhAF4WE7nFt08wClQSv6GF4wlza3yzpqEvK1nQSjL4cOS/
         mv2HG2mM6pTGgKhLtkmm81FVvWLc9mkyirVb/PAE=
Subject: Re: [PATCH v2 2/4] x86/vmware: Add a header file for hypercall
 definitions
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-3-thomas_os@shipmail.org>
 <20190827154422.GG29752@zn.tnic>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <b82e190e-6887-b95a-a99a-176f22c57b7b@shipmail.org>
Date:   Tue, 27 Aug 2019 21:19:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190827154422.GG29752@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/19 5:44 PM, Borislav Petkov wrote:
> On Fri, Aug 23, 2019 at 10:13:14AM +0200, Thomas Hellström (VMware) wrote:
>> +/*
>> + * The high bandwidth out call. The low word of edx is presumed to have the
>> + * HB and OUT bits set.
>> + */
>> +#define VMWARE_HYPERCALL_HB_OUT						\
>> +	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
> Hmm, that looks fishy:
>
> This call in vmw_port_hb_out(), for example, gets converted to the asm
> below (I've left in the asm touching only rDX).
>
> # drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:160:              VMW_PORT_HB_OUT(
> #NO_APP
>          movzwl  0(%rbp), %edx   # channel_20(D)->channel_id, channel_20(D)->channel_id
>
> 	...
>
>          sall    $16, %edx       #, tmp172
>          orl     $3, %edx        #, tmp173
>
> this is adding channel_id and flags:
>
>                          VMWARE_HYPERVISOR_HB | (channel->channel_id << 16) |
>                          VMWARE_HYPERVISOR_OUT,
>
> the $3 being (VMWARE_HYPERVISOR_HB | VMWARE_HYPERVISOR_OUT).
>
>          movslq  %edx, %rdx      # tmp173, tmp174
>
> Here it is sign-extending it.
>
> #APP
> # 160 "drivers/gpu/drm/vmwgfx/vmwgfx_msg.c" 1
>          push %rbp;mov %r8, %rbp;# ALT: oldinstr2        # bp
> 661:
>          movw $0x5659, %dx; rep outsb
>
> And now here you're overwriting the low word of %edx. And now it
> contains:
>
> 0x[channel_id]5659
>
> and the low word doesn't contain the 3, i.e., (VMWARE_HYPERVISOR_HB |
> VMWARE_HYPERVISOR_OUT) anymore. And that's before you do the hypercall
> so I'm guessing that cannot be right.
>
> Or?
>
It should be correct. The flags VMWARE_HYPERVISOR_HB and 
VMWARE_HYPERVISOR_OUT are only valid for the vmcall / vmmcall versions.

For the legacy version, the direction is toggled by the instruction (in 
vs out) and LB vs HB is toggled by the port number (0x5658 vs 0x5659)

So in essence the low word definition of %edx is different in the two 
versions. I've chosen to use the new vmcall/vmmcall definition in the 
driver code.

/Thomas

