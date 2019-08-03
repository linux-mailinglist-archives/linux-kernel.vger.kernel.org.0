Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4A68038C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2019 02:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392805AbfHCAmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 20:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389781AbfHCAmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:42:19 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A5D62087E;
        Sat,  3 Aug 2019 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564792938;
        bh=QWMlU6tOGtjY+ZagXZH1w3wsUBJYvnKFyDdlJoUwrMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FdkFbFImrxSMA7WuTTE8waU77hFzeBhQncdmd7TzT6uv28lW7gmw61NgG7Gitpin4
         ghKynQ0n3IKocbFlMIVqsmL9VBLnAypRfs08hDXpXgZkx4hIKW+HzoqUmc/KNMQe6c
         59pw8hP+2vngTdwzejM58B+M/d1dVvB3+XLZzXnk=
Date:   Sat, 3 Aug 2019 09:42:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the arm64-fixes tree
Message-Id: <20190803094212.3ff4b1ba33c50c63173c8d31@kernel.org>
In-Reply-To: <20190802074813.73b82a14@canb.auug.org.au>
References: <20190802074813.73b82a14@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 07:48:13 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> In commit
> 
>   72de4a283cb1 ("arm64: kprobes: Recover pstate.D in single-step exception handler")
> 
> Fixes tag
> 
>   Fixes: commit 7419333fa15e ("arm64: kprobe: Always clear pstate.D in breakpoint exception handler")
> 
> has these problem(s):
> 
>   - leading word 'commit' unexpected

Oops, sorry. It was my mistake to add "commit", it should be removed.
Will, should I remove it? or could you modify on your tree?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
