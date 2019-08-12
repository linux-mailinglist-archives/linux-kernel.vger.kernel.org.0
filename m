Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28B58A7D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfHLUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 16:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbfHLUFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:05:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9BF2085A;
        Mon, 12 Aug 2019 20:05:09 +0000 (UTC)
Date:   Mon, 12 Aug 2019 16:05:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] driver/core: Fix build error when SRCU and lockdep
 disabled
Message-ID: <20190812160507.61d60224@gandalf.local.home>
In-Reply-To: <20190812200125.GA161786@google.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
        <20190811221111.99401-3-joel@joelfernandes.org>
        <20190812050256.GC5834@kroah.com>
        <20190812130310.GA27552@google.com>
        <20190812141119.6ec00a34@gandalf.local.home>
        <20190812200125.GA161786@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 16:01:25 -0400
Joel Fernandes <joel@joelfernandes.org> wrote:

> > some/header/file.h:
> > 
> > #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > # define CHECK_DEVICE_LINKS_READ_LOCK_HELD() WARN_ON_ONCE(!defice_links_read_lock_held())
> > #else
> > # define CHECK_DEVICE_LINKS_READ_LOCK_HELD() do { } while (0)
> > #endif
> > 
> > And just use CHECK_DEVICE_LINK_READ_LOCK_HELD() in those places. I
> > agree with Greg. "device_links_read_lock_heald()" should *never*
> > blindly return 1. It's confusing.  
> 
> Ok, then I will update the patch to do:
> 
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
> int device_links_read_lock_held(void)
> {
> 	return lock_is_held(&device_links_lock);
> }
> #endif  
> 
> That will also solve the build error. And callers can follow the above pattern you shared.

Sounds good!

-- Steve
