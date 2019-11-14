Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4357FCBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKNRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 12:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfKNRUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:20:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E26F2070E;
        Thu, 14 Nov 2019 17:20:35 +0000 (UTC)
Date:   Thu, 14 Nov 2019 12:20:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ioannis Ilkos <ilkos@google.com>,
        minchan@google.com, primiano@google.com, fmayer@google.com,
        hjd@google.com, joaodias@google.com, lalitm@google.com,
        rslawik@google.com, sspatil@google.com, timmurray@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] rss_stat: Add support to detect RSS updates of external
 mm
Message-ID: <20191114122034.4adeb78d@gandalf.local.home>
In-Reply-To: <20191114164622.GC233237@google.com>
References: <20191106024452.81923-1-joel@joelfernandes.org>
        <20191113153816.14b95acd@gandalf.local.home>
        <20191114164622.GC233237@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019 11:46:22 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > Can we make a __ptr_to_hashval() static inline, and have
> > ptr_to_hashval() call that, but use the static inline here, where the
> > static_branch gets called directly here?  
> 
> Sure, like this?

Yep.

-- Steve
