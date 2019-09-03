Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E74A7669
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 23:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfICVmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 17:42:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35521 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICVmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:42:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so11677736qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pl0EFO8E1nfGtt6lAyaMFxbDT0oySOj2vcl1/yE6fuc=;
        b=O1AJjw9H+q73tzV8SB4rLexieHhdXCpsG0KlCAt7kOVuqXmwHubQrJbyjHWSKgI+wD
         dpXLwWNGmdiAixAuxOZWkUIC/v1edpjmLJS33gaWveupe3ifXG0+Hz/8Lg8t2xH2395Q
         KG3gUrFgoBti/TFwbEDjB8B1SLpMCWD0Gl7MnDjnUc+8narW/tU/cDNATM480b+1qIr4
         /99TzaSZxKMKlVN1DFVVd3OPQZGc6CzY8ECuZNiMpHJMP0+vX3LZJQkYSBvm5Ls/KB5L
         /eDn1+QA1h5z7oG2w62KhZNsucEoIVbp9U5l+/4HSXAF6lBe/XdMUCioAP2LM1wQOmDU
         kz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pl0EFO8E1nfGtt6lAyaMFxbDT0oySOj2vcl1/yE6fuc=;
        b=OkrtCRzXikmcOnAhNSRFwgZ8+U30hnShMIA1dTkFNr9+B9Si17K6fkAiAYrYGF+i4A
         6j2RnkDNrJQbTT15RdxS+zlJIBa3TAkbG2Q7mnURY3o1qNFOZjSe44dS+xNm28/CEar5
         FR/I8SGeX2NhAQNOETjrFiKb0NWns6NH3umjL5Utsz2yrjD8wMU+NuexrXmIx5JHcgPV
         FNvwVarqNXlewvNqAClhK9Lalw7zo5waOHdB1F77SATIH2mYVn18Q8x90Mj2vz02oUKt
         VJ4rOPWUkogY31ESXMIO9ALIIFdxPwRsoOtuTtEGT0bjajxQV7omEPxEdN/axn/fdtHF
         GwcQ==
X-Gm-Message-State: APjAAAWyegdANnfaFRNMitA45Znv7ygJizJ167gmr3E+iMoUkkzCxzeH
        hR8Qiqp+ZdmO/SCnOBxntP/42A==
X-Google-Smtp-Source: APXvYqxiY0uxaPcETg9MrwEvJU+9N/SUjCvN24j9vnpNDyM0XRV86hk6cR3lDrnZPxruLaXF6CMRTg==
X-Received: by 2002:ac8:53d6:: with SMTP id c22mr11155371qtq.381.1567546950696;
        Tue, 03 Sep 2019 14:42:30 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o9sm8933907qtr.71.2019.09.03.14.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 14:42:29 -0700 (PDT)
Message-ID: <1567546948.5576.68.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 17:42:28 -0400
In-Reply-To: <20190903185305.GA14028@dhcp22.suse.cz>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
         <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
         <1567178728.5576.32.camel@lca.pw>
         <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
         <20190903132231.GC18939@dhcp22.suse.cz> <1567525342.5576.60.camel@lca.pw>
         <20190903185305.GA14028@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 20:53 +0200, Michal Hocko wrote:
> On Tue 03-09-19 11:42:22, Qian Cai wrote:
> > On Tue, 2019-09-03 at 15:22 +0200, Michal Hocko wrote:
> > > On Fri 30-08-19 18:15:22, Eric Dumazet wrote:
> > > > If there is a risk of flooding the syslog, we should fix this
> > > > generically
> > > > in mm layer, not adding hundred of __GFP_NOWARN all over the places.
> > > 
> > > We do already ratelimit in warn_alloc. If it isn't sufficient then we
> > > can think of a different parameters. Or maybe it is the ratelimiting
> > > which doesn't work here. Hard to tell and something to explore.
> > 
> > The time-based ratelimit won't work for skb_build() as when a system under
> > memory pressure, and the CPU is fast and IO is so slow, it could take a long
> > time to swap and trigger OOM.
> 
> I really do not understand what does OOM and swapping have to do with
> the ratelimiting here. The sole purpose of the ratelimit is to reduce
> the amount of warnings to be printed. Slow IO might have an effect on
> when the OOM killer is invoked but atomic allocations are not directly
> dependent on IO.

When there is a heavy memory pressure, the system is trying hard to reclaim
memory to fill up the watermark. However, the IO is slow to page out, but the
memory pressure keep draining atomic reservoir, and some of those skb_build()
will fail eventually.

Only if there is a fast IO, it will finish swapping sooner and then invoke the
OOM to end the memory pressure.

> 
> > I suppose what happens is those skb_build() allocations are from softirq,
> > and
> > once one of them failed, it calls printk() which generates more interrupts.
> > Hence, the infinite loop.
> 
> Please elaborate more.
> 

If you look at the original report, the failed allocation dump_stack() is,

 <IRQ>
 warn_alloc.cold.43+0x8a/0x148
 __alloc_pages_nodemask+0x1a5c/0x1bb0
 alloc_pages_current+0x9c/0x110
 allocate_slab+0x34a/0x11f0
 new_slab+0x46/0x70
 ___slab_alloc+0x604/0x950
 __slab_alloc+0x12/0x20
 kmem_cache_alloc+0x32a/0x400
 __build_skb+0x23/0x60
 build_skb+0x1a/0xb0
 igb_clean_rx_irq+0xafc/0x1010 [igb]
 igb_poll+0x4bb/0xe30 [igb]
 net_rx_action+0x244/0x7a0
 __do_softirq+0x1a0/0x60a
 irq_exit+0xb5/0xd0
 do_IRQ+0x81/0x170
 common_interrupt+0xf/0xf
 </IRQ>

Since it has no __GFP_NOWARN to begin with, it will call,

printk
  vprintk_default
    vprintk_emit
      wake_up_klogd
        irq_work_queue
          __irq_work_queue_local
            arch_irq_work_raise
              apic->send_IPI_self(IRQ_WORK_VECTOR)
                smp_irq_work_interrupt
                  exiting_irq
                    irq_exit

and end up processing pending net_rx_action softirqs again which are plenty due
to connected via ssh etc.
