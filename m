Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD7216D59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2019 23:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEGV7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 May 2019 17:59:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGV7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 17:59:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hO87S-0005DA-7l; Tue, 07 May 2019 23:59:26 +0200
Date:   Tue, 7 May 2019 23:59:26 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, Rik van Riel <riel@surriel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86 FPU changes for 5.2
Message-ID: <20190507215925.3wfs7mia5aesedr2@linutronix.de>
References: <20190507132632.GB26655@zn.tnic>
 <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4Cjb1qDj_VRW9W4d4n9WLksgMKF-roG8eCk_O0ZaEEg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-07 10:35:25 [-0700], Linus Torvalds wrote:
> Has this gone through lots of testing, particularly with things like
> FP signal handling and old machines that don't necessarily have
> anything but the most basic FP state (ie Pentium class etc)?

I tried it in qemu with incremental FPU capabilities so it went through
all the possible load/restore variants during signal handling. I had a
testcase which did SHA1 computation and a received a SIGALRM every
second. This caught some bugs, most of them were xsave/xsaves related
once the SHA1 result did not match. I tried something similar one the
8087 FPU.
I had the series in the v5.0-RT tree which resulted in the most recent
patch in that branch.

>                Linus

Sebastian
