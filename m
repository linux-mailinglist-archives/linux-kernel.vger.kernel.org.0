Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C07B9118373
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 10:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLJJXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Dec 2019 04:23:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51668 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfLJJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 04:23:40 -0500
Received: from [79.140.114.95] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iebjS-0006yf-Jx; Tue, 10 Dec 2019 09:23:02 +0000
Date:   Tue, 10 Dec 2019 10:23:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     syzbot <syzbot+370a6b0f11867bf13515@syzkaller.appspotmail.com>,
        acme@kernel.org, akpm@linux-foundation.org, arnd@arndb.de,
        bp@alien8.de, bp@suse.de, christian@brauner.io, cyphar@cyphar.com,
        dhowells@redhat.com, dvyukov@google.com, ebiederm@xmission.com,
        frederic@kernel.org, gustavo@embeddedor.com, hpa@zytor.com,
        jannh@google.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mark.rutland@arm.com, mhiramat@kernel.org,
        mingo@kernel.org, mingo@redhat.com, mtk.manpages@gmail.com,
        namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        x86@kernel.org
Subject: Re: WARNING in arch_install_hw_breakpoint
Message-ID: <20191210092300.kigvxforfirpqitc@wittgenstein>
References: <000000000000639f6a0584d11b82@google.com>
 <0000000000007f8bf6059932fe10@google.com>
 <201912091608.1DA5B7865F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201912091608.1DA5B7865F@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 04:10:13PM -0800, Kees Cook wrote:
> On Sun, Dec 08, 2019 at 07:33:00AM -0800, syzbot wrote:
> > syzbot suspects this bug was fixed by commit:
> > 
> > commit b3e5838252665ee4cfa76b82bdf1198dca81e5be
> > Author: Christian Brauner <christian@brauner.io>
> > Date:   Wed Mar 27 12:04:15 2019 +0000
> > 
> >     clone: add CLONE_PIDFD
> 
> That seems ... unlikely? I suspect this WARN should just be pr_err or

Very much so. :)

Christian
