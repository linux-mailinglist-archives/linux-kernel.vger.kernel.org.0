Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD9794B8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbfFSMkD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jun 2019 08:40:03 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:64033 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727314AbfFSMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:40:02 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16952903-1500050 
        for multiple; Wed, 19 Jun 2019 13:39:55 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
In-Reply-To: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
Message-ID: <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
Subject: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
Date:   Wed, 19 Jun 2019 13:39:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't bisected this, but with the merge of rc5 into our CI we
started hitting an issue that resulted in a oops and the NMI watchdog
firing as we dumped the ftrace. This NMI watchdog locks up prior to the
backtraces being printed, preventing the machine from rebooting, and can
be avoided with hardlockup_all_cpu_backtrace=0. Running on arch/x86.
-Chris
