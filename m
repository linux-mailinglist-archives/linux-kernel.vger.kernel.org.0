Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E31CC40
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2019 17:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfENPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 11:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfENPt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:49:59 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534ED2086A;
        Tue, 14 May 2019 15:49:58 +0000 (UTC)
Date:   Tue, 14 May 2019 11:49:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 01/27] tools lib traceevent: Remove hard coded install
 paths from pkg-config file
Message-ID: <20190514114957.663454b0@oasis.local.home>
In-Reply-To: <20190514150524.GA1756@kernel.org>
References: <20190510195606.537643615@goodmis.org>
        <20190510200105.966709757@goodmis.org>
        <20190510161150.20be7f1e@gandalf.local.home>
        <BDB00110-43B1-4766-BB21-D7BF6FDD5EC7@kernel.org>
        <20190514150524.GA1756@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 12:05:24 -0300
Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> > >Arnaldo,
> > >
> > >I believe you already applied patch 1 (otherwise I would not have your
> > >SOB on it), please ignore. But patch 2 on are new to be applied.  
> > 
> > 
> > Ok, I'll be back at work early next week and will peixes this,  
> 
> Done.

Thanks Arnaldo!

-- Steve
