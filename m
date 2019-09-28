Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6FBFC1081
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2019 11:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfI1J4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Sep 2019 05:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfI1J4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 05:56:52 -0400
Received: from devnote2 (unknown [12.206.46.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21992082F;
        Sat, 28 Sep 2019 09:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569664612;
        bh=k3c+yijjz2fQ5jMz83Yu7Ha3TjCsJI3tc6a4Ehlejjs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iJVMwYlcJzatVGLbvII8zt30M/EvC/LaMAvVcpl9/kFa8zmOuVUOPzR402kUGB+oS
         mZDp1KOpmWdJ+OLwPZK0OrAoo/IcMvGERHP5/upSF0rC6z9zg5As0EduwawfXDhUjI
         1HK8k/+SR+PTIFsdMfHXyXDv/cxg+Y8w/e/edmqw=
Date:   Sat, 28 Sep 2019 02:56:51 -0700
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tracing/probe: Test nr_args match in looking for same
 probe events
Message-Id: <20190928025651.2735f7a306bfda881a318b12@kernel.org>
In-Reply-To: <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
References: <20190927055035.4c3abae9@oasis.local.home>
        <20190927131458.GA19008@linux.vnet.ibm.com>
        <20190928011748.599255f6ffc9a4831e1efd2c@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2019 01:17:48 -0700
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> If we found that 2 probes have different number of argument should not be
> folded at all.
> Also, we have to adjust error log position. Attached patch will fix those
> errors correctly as bellow.

Oops, missed the fixed tag. Anyway I'll send it as a patch mail.

Thank you,


> 
> /sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx >> kprobe_events
> /sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx >> kprobe_events
> sh: write error: File exists
> /sys/kernel/debug/tracing # echo p:myevent kernel_read %ax >> kprobe_events
> sh: write error: File exists
> /sys/kernel/debug/tracing # echo p:myevent kernel_read %ax %bx %cx >> kprobe_eve
> nts
> sh: write error: File exists
> /sys/kernel/debug/tracing # cat error_log 
> [   15.917727] trace_kprobe: error: There is already the exact same probe event
>   Command: p:myevent kernel_read %ax %bx
>            ^
> [   24.890638] trace_kprobe: error: Argument type or name is different from existing probe
>   Command: p:myevent kernel_read %ax
>                                      ^
> [   31.480521] trace_kprobe: error: Argument type or name is different from existing probe
>   Command: p:myevent kernel_read %ax %bx %cx
>                                          ^
> 
> Thank you,
> 
> -- 
> Masami Hiramatsu


-- 
Masami Hiramatsu <mhiramat@kernel.org>
