Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3F6B59E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2019 06:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfGQEqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jul 2019 00:46:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49436 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfGQEqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:46:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA049ACD8;
        Wed, 17 Jul 2019 04:46:15 +0000 (UTC)
Subject: Re: [Xen-devel][PATCH v3] xen/pv: Fix a boot up hang revealed by int3
 self test
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, Andrew Cooper <andrew.cooper3@citrix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, sstabellini@kernel.org,
        x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, mingo@redhat.com
References: <1563095732-16700-1-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <26a6f7a0-3c3a-c333-ff9f-6669fa1101e4@suse.com>
Date:   Wed, 17 Jul 2019 06:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563095732-16700-1-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.07.19 11:15, Zhenzhong Duan wrote:
> Commit 7457c0da024b ("x86/alternatives: Add int3_emulate_call()
> selftest") is used to ensure there is a gap setup in int3 exception stack
> which could be used for inserting call return address.
> 
> This gap is missed in XEN PV int3 exception entry path, then below panic
> triggered:
> 
> [    0.772876] general protection fault: 0000 [#1] SMP NOPTI
> [    0.772886] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0+ #11
> [    0.772893] RIP: e030:int3_magic+0x0/0x7
> [    0.772905] RSP: 3507:ffffffff82203e98 EFLAGS: 00000246
> [    0.773334] Call Trace:
> [    0.773334]  alternative_instructions+0x3d/0x12e
> [    0.773334]  check_bugs+0x7c9/0x887
> [    0.773334]  ? __get_locked_pte+0x178/0x1f0
> [    0.773334]  start_kernel+0x4ff/0x535
> [    0.773334]  ? set_init_arg+0x55/0x55
> [    0.773334]  xen_start_kernel+0x571/0x57a
> 
> For 64bit PV guests, Xen's ABI enters the kernel with using SYSRET, with
> %rcx/%r11 on the stack. To convert back to "normal" looking exceptions,
> the xen thunks do 'xen_*: pop %rcx; pop %r11; jmp *'.
> 
> E.g. Extracting 'xen_pv_trap xenint3' we have:
> xen_xenint3:
>   pop %rcx;
>   pop %r11;
>   jmp xenint3
> 
> As xenint3 and int3 entry code are same except xenint3 doesn't generate
> a gap, we can fix it by using int3 and drop useless xenint3.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
