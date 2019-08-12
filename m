Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6168A4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHLRzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 13:55:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60461 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:55:17 -0400
Received: from p200300ddd71876867e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7686:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hxEX8-0002xp-C9; Mon, 12 Aug 2019 19:55:02 +0200
Date:   Mon, 12 Aug 2019 19:54:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Hunt <joshhunt00@gmail.com>
cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
In-Reply-To: <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908121933310.7324@nanos.tec.linutronix.de>
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com> <20180223121456.GZ25201@hirez.programming.kicks-ass.net> <20180226203937.GA21543@tassilo.jf.intel.com> <CAKA=qzYOU-VtEC5p6djRNmVS0xGe=jpTd3ZgUr++1G3Jj1=PTg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019, Josh Hunt wrote:
> Was there any progress made on debugging this issue? We are still
> seeing it on 4.19.44:

I haven't seen anyone looking at this.

Can you please try the patch Ingo posted:

  https://lore.kernel.org/lkml/20150501070226.GB18957@gmail.com/

and if it fixes the issue decrease the value from 128 to the point where it
comes back, i.e. 128 -> 64 -> 32 ...

Thanks,

	tglx
