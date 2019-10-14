Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4ECD6A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 21:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbfJNTYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 15:24:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388391AbfJNTYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:24:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171AE20673;
        Mon, 14 Oct 2019 19:24:23 +0000 (UTC)
Date:   Mon, 14 Oct 2019 15:24:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        amakhalov@vmware.com, akaher@vmware.com, anishs@vmware.com,
        bordoloih@vmware.com, srivatsab@vmware.com
Subject: Re: [PATCH 3/3] tracing/hwlat: Fix a few trivial nits
Message-ID: <20191014152421.112bfa96@gandalf.local.home>
In-Reply-To: <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
References: <157073343544.17189.13911783866738671133.stgit@srivatsa-ubuntu>
        <157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 11:51:17 -0700
"Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:

> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> Update the source file name in the comments, and fix a grammatical
> error.

Patch 1 and 2 have already been applied to Linus's tree.

I've queued this one up for the next merge window.

Thanks!

-- Steve

