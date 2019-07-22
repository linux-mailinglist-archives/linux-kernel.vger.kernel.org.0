Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA655704D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfGVQBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 12:01:37 -0400
Received: from foss.arm.com ([217.140.110.172]:41180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVQBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:01:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E401596;
        Mon, 22 Jul 2019 09:01:36 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 994693F694;
        Mon, 22 Jul 2019 09:01:35 -0700 (PDT)
Date:   Mon, 22 Jul 2019 17:01:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190722160133.GI60625@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
 <20190702165008.GC34718@lakrids.cambridge.arm.com>
 <20190703100205.0b58f3bf@gandalf.local.home>
 <20190703140832.GD48312@arrakis.emea.arm.com>
 <20190709111520.5f098b22@gandalf.local.home>
 <20190722124202.GF60625@arrakis.emea.arm.com>
 <20190722110010.7db27b06@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722110010.7db27b06@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:00:10AM -0400, Steven Rostedt wrote:
> On Mon, 22 Jul 2019 13:42:02 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > > I agree with Masami, that the selftest actually caught a bug here. I
> > > think the arch code may need to change as the purpose of Masami's
> > > changes was to enable kprobes earlier in boot. The selftest failing
> > > means that an early kprobe will fail too.  
> > 
> > I just got back from holiday and catching up with emails. Do I still
> > need to merge the arm64 fix making the debug initialisation a
> > core_initcall()?
> > 
> > Can we actually get kprobes invoked before init_kprobes() has been
> > called?
> 
> Bah, I can't remember everything that we discussed. I thought there was
> some more patches that obsoleted my work around. Everything has been
> pushed to Linus, can you see if the upstream still has issues for you?

Upstream is fine since you reverted the postcore_initcall(init_kprobes)
change and used subsys_initcall() instead. So I don't think we need any
arch changes.

-- 
Catalin
