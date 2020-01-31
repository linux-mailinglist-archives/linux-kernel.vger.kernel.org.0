Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4E14E8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 07:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgAaGnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 01:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgAaGny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:43:54 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EC02082E;
        Fri, 31 Jan 2020 06:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580453034;
        bh=q97/U5on2lXCtm8KVUoshh+lvbqdJOc+eBhqIiovquE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTk1r0KJvplTnYt4Q8z2Oxpp8vxWqxWHGxDFBQcCvy8PXKmn4numomDxHs2VGG3KR
         6dLR136ThsGyRXvBH9SkFejodw7aDRZQ4Mt63601DyRQIX4j0Kc/ch/2Zt+5SkLgzY
         vgsGHaUVWdI47Rv/bArl5vBe6qqlqKnVjnrrknX4=
Date:   Fri, 31 Jan 2020 15:43:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V3 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20200131154349.5ff9436bd53633dad6270f83@kernel.org>
In-Reply-To: <157905963533.2268.4672153983131918123.stgit@devnote2>
References: <157905963533.2268.4672153983131918123.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you pick these patches for fixing RCU warnings by
CONFIG_PROVE_RCU_LIST?

Thank you,

On Wed, 15 Jan 2020 12:40:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is v3 patches which fix suspicious RCU usage warnings
> in kprobes. In this version I just updated the series on top
> of the latest -tip and add Joel's reviewed-by tag.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       kprobes: Suppress the suspicious RCU warning on kprobes
>       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
> 
> 
>  kernel/kprobes.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
