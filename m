Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA99573427
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbfGXQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfGXQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:46:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E178E2189F;
        Wed, 24 Jul 2019 16:46:53 +0000 (UTC)
Date:   Wed, 24 Jul 2019 12:46:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190724124652.362a90d0@gandalf.local.home>
In-Reply-To: <20190710171900.gzzitftdinkdx6ra@treble>
References: <cover.1560285597.git.mhelsley@vmware.com>
        <20190710130924.16aee549@gandalf.local.home>
        <20190710171900.gzzitftdinkdx6ra@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 12:19:00 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Wed, Jul 10, 2019 at 01:09:24PM -0400, Steven Rostedt wrote:
> > 
> > Josh,
> > 
> > Can you have a look at these? I can apply them if you think they are OK.  
> 
> Sorry for the delay.  I didn't forget about it, it's just been a hectic
> month.  I plan to give it a proper review soon (in the next week or so).
> 

Friendly reminder ;-)

-- Steve
