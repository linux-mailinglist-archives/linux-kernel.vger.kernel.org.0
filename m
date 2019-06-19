Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A44B4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 11:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbfFSJTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jun 2019 05:19:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731350AbfFSJTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:19:22 -0400
Received: from oasis.local.home (rrcs-50-75-126-20.nys.biz.rr.com [50.75.126.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD22320B1F;
        Wed, 19 Jun 2019 09:19:19 +0000 (UTC)
Date:   Wed, 19 Jun 2019 05:19:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 10/21] tracing/probe: Split trace_event related data
 from trace_probe
Message-ID: <20190619051915.091cdae5@oasis.local.home>
In-Reply-To: <20190619112822.60db3d69a09e0288f9168421@kernel.org>
References: <155931578555.28323.16360245959211149678.stgit@devnote2>
        <155931589667.28323.6107724588059072406.stgit@devnote2>
        <20190617215643.05a33541@oasis.local.home>
        <20190619011409.1a459906c14b8c851a5eb518@kernel.org>
        <20190618122322.6875b643@gandalf.local.home>
        <20190618171115.2c58fde6@gandalf.local.home>
        <20190619112822.60db3d69a09e0288f9168421@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 11:28:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > BTW,
> > 
> > I pulled in patches 1-9 and I'm starting to test them now.  
> 
> Thanks! Should I send 10-21 patches in v2?

Yes please.

The tests have passed, and I will be pushing them to linux-next soon.
But as I'm currently traveling, I can't give an exact time I will do that.

-- Steve
