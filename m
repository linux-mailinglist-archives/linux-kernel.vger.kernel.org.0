Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B815C137A44
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 00:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgAJXfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 18:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgAJXfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:35:12 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDE3206ED;
        Fri, 10 Jan 2020 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578699311;
        bh=S6iFDCkFbQ19HKKXZUx+teh9fgyvoWfOoUF6jaPo1Aw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0P08jO7isuDezkc+9jiOHL9YWpG3bU2S3yJdL0/aZkEMjy9V1ND96KTuU0XD7Hr/+
         zQBwan0ZRYcaAc+jeSWkOkWpeXJwVsmmBa6k82VMqKWpeddp8Q1Hj7cFlu5s3kl83c
         TYfbI6VFBGpsIbIVJ7JI3Tt0BamjBIhdlk9A9pzE=
Date:   Sat, 11 Jan 2020 08:35:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20200111083507.c32b85b1d47aa69928de530b@kernel.org>
In-Reply-To: <20200110211438.GE128013@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
        <20191221035541.69fc05613351b8dabd6e1a44@kernel.org>
        <20200107211535.233e7ff396f867ee1348178b@kernel.org>
        <20200110211438.GE128013@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel and Paul,

On Fri, 10 Jan 2020 16:14:38 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Tue, Jan 07, 2020 at 09:15:35PM +0900, Masami Hiramatsu wrote:
> > Hello,
> > 
> > Anyone have any comment on this series?
> > Without this series, I still see the suspicious RCU warning for kprobe on -tip tree.
> 
> +Paul since RCU.
> 
> Hi Masami,
> 
> I believe I had commented before that I don't agree with this patch:
> https://lore.kernel.org/lkml/157535318870.16485.6366477974356032624.stgit@devnote2/
> 
> The rationale you used is to replace RCU-api with non-RCU api just to avoid
> warnings. I think a better approach is to use RCU api and pass the optional
> expression to silence the false-positive warnings by informing the RCU API
> about the fact that locks are held (similar to what we do for
> rcu_dereference_protected()). The RCU API will do additional checking
> (such as making sure preemption is disabled for safe RCU usage etc) as well.

Yes, that is what I did in [1/2] for get_kprobe().
Let me clarify the RCU list usage in [2/2].

With the careful check, other list traversals never be done in non-sleepable
context, those are always runs with kprobe_mutex held.
If I correctly understand the Documentation/RCU/listRCU.rst, we should/can use
non-RCU api for those cases, or do I miss something?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
