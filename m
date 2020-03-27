Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 244671961E6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Mar 2020 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC0X3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 19:29:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgC0X3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:29:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB852071B;
        Fri, 27 Mar 2020 23:22:10 +0000 (UTC)
Date:   Fri, 27 Mar 2020 19:22:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tiejun Chen <tiejunc@vmware.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>
Subject: Re: [ANNOUNCE] 4.19.106-rt45
Message-ID: <20200327192208.30bd16e5@gandalf.local.home>
In-Reply-To: <BYAPR05MB587828CEA4A259906BAD3AA5C5CC0@BYAPR05MB5878.namprd05.prod.outlook.com>
References: <20200310133154.6656b339@gandalf.local.home>
        <BYAPR05MB587828CEA4A259906BAD3AA5C5CC0@BYAPR05MB5878.namprd05.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 23:16:51 +0000
Tiejun Chen <tiejunc@vmware.com> wrote:

> Steven,
> 
> We cannot build this release (maybe all 4.19-rt) with CONFIG_UBSAN=y

Thanks for the report. I'll take a look at this on Monday.

-- Steve

> ----
> lib/ubsan.c: In function '__ubsan_handle_vla_bound_not_positive':
> lib/ubsan.c:348:2: error: too many arguments to function 'ubsan_prologue'
>   ubsan_prologue(&data->location, &flags);
>   ^~~~~~~~~~~~~~
> lib/ubsan.c:146:13: note: declared here
>  static void ubsan_prologue(struct source_location *location)
>              ^~~~~~~~~~~~~~
> lib/ubsan.c:353:2: error: too many arguments to function 'ubsan_epilogue'
>   ubsan_epilogue(&flags);
>   ^~~~~~~~~~~~~~
> lib/ubsan.c:155:13: note: declared here
>  static void ubsan_epilogue(void)
>              ^~~~~~~~~~~~~~
> 
> I think you have to squash the following into patches/0309-lib-ubsan-Don-t-seralize-UBSAN-report.patch In your release.
> 
>     rebase onto [PATCH 309/326] lib/ubsan: Don't seralize UBSAN report
>     
>     Signed-off-by: Tiejun Chen <tiejunc@vmware.com>
>
