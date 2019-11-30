Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AFF10DF69
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfK3Vb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 16:31:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfK3Vb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:31:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AAF7CB225;
        Sat, 30 Nov 2019 21:31:56 +0000 (UTC)
Date:   Sat, 30 Nov 2019 13:27:29 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Mariusz Ceier <mceier@gmail.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [x86/mm/pat] 8d04a5f97a: phoronix-test-suite.glmark2.0.score
 -23.7% regression
Message-ID: <20191130212729.ykxstm5kj2p5ir6q@linux-p48b>
References: <20191127005312.GD20422@shao2-debian>
 <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2019, Mariusz Ceier wrote:

>I can also confirm this - just bisected framebuffer rendering
>performance regression on amdgpu and
>8d04a5f97a5fa9d7afdf46eda3a5ceaa973a1bcc is the first bad commit
>(leading to drop from around 260-300fps to about 60fps in CS:GO on
>Fury X).

This is a third report now. Could you please provide the contents
of the following file, before and after the offending commit.

	/sys/kernel/debug/x86/pat_memtype_list

This will show any attribute differences in the tree, which is likely
the culprit.

Thanks,
Davidlohr
