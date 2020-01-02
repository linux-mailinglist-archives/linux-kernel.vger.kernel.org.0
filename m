Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C41412F1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jan 2020 00:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgABXwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jan 2020 18:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727142AbgABXwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:52:07 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77E9921655;
        Thu,  2 Jan 2020 23:52:06 +0000 (UTC)
Date:   Thu, 2 Jan 2020 18:52:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/x86/include/asm/string_32.h:182:25: warning: 'val' may be
 used uninitialized in this function
Message-ID: <20200102185205.3af73c99@gandalf.local.home>
In-Reply-To: <202001020358.wAyfZGvV%lkp@intel.com>
References: <202001020358.wAyfZGvV%lkp@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2020 03:51:46 +0800
kbuild test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   738d2902773e30939a982c8df7a7f94293659810
> commit: 6c3edaf9fd6a3be7fb5bc6931897c24cd3848f84 tracing: Introduce trace event injection
> date:   4 weeks ago
> config: i386-randconfig-a003-20200102 (attached as .config)
> compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> reproduce:
>         git checkout 6c3edaf9fd6a3be7fb5bc6931897c24cd3848f84
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

It is a false positive, but it's complex and subtle enough to just set
val to zero and remove the warning.

-- Steve


