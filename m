Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F7292464
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfHSNKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:10:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C0720843;
        Mon, 19 Aug 2019 13:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566220233;
        bh=PJHIGkjFrjMv2g1mzBGACXVcW/F4cLU5JiDCgRCUXCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UkQSMChYpShwjEp4bEaTD1kbTW5hoXNhrQj46VtSTrE5YdDfAGS3Km6LZy/tDZ5B1
         jRBpK6HghPF9YU0BlKsLvr7a3SNfeKNsGQuQB6GNzQsvivc7NmifG3PIcTPmJKgHFe
         7xsR0jUALLR9fLOBFycO7K9i5zn5dFCsGiclYMZg=
Date:   Mon, 19 Aug 2019 22:10:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] arm64: KPROBES_ON_FTRACE
Message-Id: <20190819221027.80cb13a596c5c21fdbee79ff@kernel.org>
In-Reply-To: <20190819192422.5ed79702@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Mon, 19 Aug 2019 11:35:27 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Implement KPROBES_ON_FTRACE for arm64.
> 
> Applied after FTRACE_WITH_REGS:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2019-August/674404.html

Looks interesting! thanks for working on it.
I'll check it.

Thanks,

> 
> Jisheng Zhang (4):
>   kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
>   kprobes/x86: use instruction_pointer and instruction_pointer_set
>   kprobes: move kprobe_ftrace_handler() from x86 and make it weak
>   arm64: implement KPROBES_ON_FTRACE
> 
>  arch/arm64/Kconfig                |  1 +
>  arch/arm64/kernel/probes/Makefile |  1 +
>  arch/arm64/kernel/probes/ftrace.c | 16 +++++++++++
>  arch/x86/kernel/kprobes/ftrace.c  | 43 ----------------------------
>  kernel/kprobes.c                  | 47 +++++++++++++++++++++++++++++++
>  5 files changed, 65 insertions(+), 43 deletions(-)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> 
> -- 
> 2.23.0.rc1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
