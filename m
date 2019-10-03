Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAB8C980B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfJCFwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 01:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfJCFwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 01:52:36 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBDAD21D81;
        Thu,  3 Oct 2019 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570081955;
        bh=PMscm+0DA539pxL/O1xC58O5vmGdw+fjyf0hSC501JA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/g7tnZel4tqLj0Fvhp44zo//DejCr9pc+aN5RlVl1GEc8HmPxnbxdEwtTyGEmdMx
         9Gt5n+KUpDs9XNEnnBT+uBNfh4PNrukZ49LLkStS0okjmYFVdQWlZKAB3sUh1fZ4+G
         N1HzrzsoLSdU48rnWApHoVPvID4oegB2EADzJCyc=
Date:   Thu, 3 Oct 2019 14:52:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-Id: <20191003145230.fe8314d8575c2f88b16322e8@kernel.org>
In-Reply-To: <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
References: <20190827180622.159326993@infradead.org>
        <20190827181147.166658077@infradead.org>
        <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2019 18:35:26 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> ftrace was already batching the updates, for instance, causing 3 IPIs to enable
> all functions. The text_poke() batching also works. But because of the limited
> buffer [ see the reply to the patch 2/3 ], it is flushing the buffer during the
> operation, causing more IPIs than the previous code. Using the 5.4-rc1 in a VM,
> when enabling the function tracer, I see 250+ intermediate text_poke_finish()
> because of a full buffer...

Would you have any performance numbers of the previous code and applying this?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
