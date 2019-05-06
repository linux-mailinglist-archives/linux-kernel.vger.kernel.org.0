Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E57531540C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfEFSzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 14:55:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfEFSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 14:55:13 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hNilb-0000fn-9q; Mon, 06 May 2019 20:55:11 +0200
Date:   Mon, 6 May 2019 20:55:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Kernel License cleanup
Message-ID: <alpine.DEB.2.21.1905062040530.3334@nanos.tec.linutronix.de>
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

Folks,

after the initial SPDX sweep of the kernel, people have slowly started to
fixup the licensing mess. The current approach has some issues:

1) With the current rate of changes we are going to be finished in about
   10+ years from now

2) The error rate with these cleanups is frightening high. It got even
   higher since the 'run a script and fix random bits' folks have decided
   that this is a new playground. It's not because it really needs a lot of
   dilligence.

We've had a discussion at the Legal and Licensing Workshop in Barcelona and
came to the conclusion that this needs to be tackled in a larger scale
effort with massive tooling support.

I've looked into automating a lot of these conversions and there is a
halfways workable way to get at least up to 90-95% coverage without
spending insane amounts of time. The remaining 5-10% of horrors are special
cases which need a lot of thoughts anyway.

As we need help from lawyers with this, we decided to set up a dedicated
mailing list to spare those people the wonderful experience of the daily
LKML mail flooding.

The list address is: linux-spdx@vger.kernel.org

It's open and archived at: https://lore.kernel.org/linux-spdx/

If you're interested to help, please subscribe. We'll start to work there
as of tomorrow.

Thanks,

	Thomas

