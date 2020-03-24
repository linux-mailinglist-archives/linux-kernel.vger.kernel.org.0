Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB591916AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Mar 2020 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCXQmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Mar 2020 12:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgCXQmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:42:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D092076E;
        Tue, 24 Mar 2020 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585068144;
        bh=WOfzGud1g5SN2D09FFr6f5D5bZvLHXqD/f6Nk08nwls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4jhsJsVjdPyAsPy/iIj6xIx/J0LV3zIHJD+Yg2Uer/lEPe/gi9mzNs0qKAlfbC2T
         B0pVYRteT5o3wW6brlOqYF33cJPOemzgjgE40onIm3hNo2uP563EqI34H7uPQVCXYT
         /PFli2Y3mvImQbJnrLZcDKkukYZ6qzmQBXV9jsZc=
Date:   Tue, 24 Mar 2020 17:42:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 10/21] kernel-hacking: Make
 DEBUG_{LIST,PLIST,SG,NOTIFIERS} non-debug options
Message-ID: <20200324164220.GC2518746@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-11-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-11-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:32PM +0000, Will Deacon wrote:
> The CONFIG_DEBUG_{LIST,PLIST,SG,NOTIFIERS} options can provide useful
> security hardening properties outside of debug scenarios. For example,
> CVE-2019-2215 and CVE-2019-2025 are mitigated with negligible runtime
> overhead by enabling CONFIG_DEBUG_LIST, and this option is already
> enabled by default on many distributions:
> 
> https://googleprojectzero.blogspot.com/2019/11/bad-binder-android-in-wild-exploit.html
> 
> Rename these options across the tree so that the naming better reflects
> their operation and remove the dependency on DEBUG_KERNEL.
> 
> Cc: Maddie Stone <maddiestone@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
