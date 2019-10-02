Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD7C8AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2019 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfJBONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Oct 2019 10:13:45 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:38424 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726200AbfJBONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:13:44 -0400
Received: (qmail 1758 invoked by uid 2102); 2 Oct 2019 10:13:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Oct 2019 10:13:43 -0400
Date:   Wed, 2 Oct 2019 10:13:43 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Joel Fernandes <joel@joelfernandes.org>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tools/memory-model/Documentation: Fix typos in
 explanation.txt
In-Reply-To: <20191001210123.GA41667@google.com>
Message-ID: <Pine.LNX.4.44L0.1910021012541.1552-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2019, Joel Fernandes wrote:

> On Tue, Oct 01, 2019 at 01:39:47PM -0400, Alan Stern wrote:
> > This patch fixes a few minor typos and improves word usage in a few
> > places in the Linux Kernel Memory Model's explanation.txt file.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Joel, if you're sufficiently interested in all this stuff, would you 
like to add yourself as a maintainer for the LKMM?

Alan

