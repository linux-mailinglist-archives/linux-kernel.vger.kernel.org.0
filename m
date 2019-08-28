Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267E6A007D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfH1LLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 07:11:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46726 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfH1LLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:11:43 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i2vrZ-0001WD-AR; Wed, 28 Aug 2019 13:11:41 +0200
Date:   Wed, 28 Aug 2019 13:11:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+654f89dafed9092dac4d@syzkaller.appspotmail.com>
cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in posix_cpu_timer_del
In-Reply-To: <000000000000a64c4a05911db6fe@google.com>
Message-ID: <alpine.DEB.2.21.1908281309400.1869@nanos.tec.linutronix.de>
References: <000000000000a64c4a05911db6fe@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019, syzbot wrote:
> HEAD commit:    ed858b88 Add linux-next specific files for 20190826
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=130c2eca600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8373cd9733e305
> dashboard link: https://syzkaller.appspot.com/bug?extid=654f89dafed9092dac4d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133cbeb6600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e931ca600000
> 
> Bisection is inconclusive: the first bad commit could be any of:

It's this one:

> ce709abd posix-cpu-timers: Utilize timerqueue for storage

The issue got already spotted by review. The fix is folded back and the
cleaned up result will be in next as of tomorrow.

Thanks,

	tglx
