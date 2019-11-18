Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E216F1007C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfKRO6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 09:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:35556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfKRO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:58:45 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23B82084D;
        Mon, 18 Nov 2019 14:58:43 +0000 (UTC)
Date:   Mon, 18 Nov 2019 09:58:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
Message-ID: <20191118095842.546b38d8@oasis.local.home>
In-Reply-To: <20191118095104.0daebbc3@oasis.local.home>
References: <1573849732.5937.136.camel@lca.pw>
        <20191115160230.78871d8f@gandalf.local.home>
        <1573851994.5937.138.camel@lca.pw>
        <20191118095104.0daebbc3@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2019 09:51:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022    
> > 
> > # git reset --hard b83b43ffc6e4b514ca034a0fbdee01322e2f7022
> > 
> > Yes, that one is bad.  
> 
> Can you see if this patch fixes the issue for you?

Don't bother. This isn't the right fix, I know see the real issue.

New fix coming shortly.

-- Steve
