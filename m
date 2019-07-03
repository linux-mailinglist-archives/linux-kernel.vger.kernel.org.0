Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BF5ECF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 21:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfGCTpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 15:45:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfGCTpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:45:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF25387620;
        Wed,  3 Jul 2019 19:45:33 +0000 (UTC)
Received: from treble (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF0F86013C;
        Wed,  3 Jul 2019 19:45:30 +0000 (UTC)
Date:   Wed, 3 Jul 2019 14:45:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jul 2 (objtool)
Message-ID: <20190703194528.7kk7v44whdp7ol5a@treble>
References: <20190702195158.79aa5517@canb.auug.org.au>
 <b0238309-72b4-1a5c-77ff-89c7e432e2ba@infradead.org>
 <20190703164458.imjawnoczygb2vvd@treble>
 <a3135000-c12d-9800-f58d-eabbfcfa1d3f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3135000-c12d-9800-f58d-eabbfcfa1d3f@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 19:45:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:23:21AM -0700, Randy Dunlap wrote:
> On 7/3/19 9:44 AM, Josh Poimboeuf wrote:
> > On Tue, Jul 02, 2019 at 11:47:02AM -0700, Randy Dunlap wrote:
> >> On 7/2/19 2:51 AM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20190701:
> >>>
> >>
> >> on x86_64:
> >>
> >> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x22: can't find switch jump table
> > 
> > I don't see it on current linux-next/master.  Can you share the config
> > and .o?
> > 
> 
> This warning happened in 6 of 10 builds for 20190702.
> 
> Today (20190703) I don't see it at all, but I see this instead:
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0xa3: sibling call from callable instruction with modified stack frame
> 
> Kernel (rand)config file and .o file for 20190702 are attached.

Thanks, I'm able to recreate the sibling call warning with a randconfig
on today's linux-next.

GCC is doing some funky stuff.  With my randconfig, ___bpf_prog_run()
has 166 indirect calls to its jump table.  Seems (a bit!) excessive.

I'll need to look into it.

-- 
Josh
