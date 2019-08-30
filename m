Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C65A3EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfH3UOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 16:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbfH3UOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 16:14:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970F823427;
        Fri, 30 Aug 2019 20:14:44 +0000 (UTC)
Date:   Fri, 30 Aug 2019 16:14:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] ftrace: two fixes with func_probes handling
Message-ID: <20190830161442.5bae24da@gandalf.local.home>
In-Reply-To: <1565277255.xyq4vg2zkj.naveen@linux.ibm.com>
References: <cover.1562249521.git.naveen.n.rao@linux.vnet.ibm.com>
        <1565277255.xyq4vg2zkj.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Aug 2019 20:45:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Naveen N. Rao wrote:
> > Two patches addressing bugs in ftrace function probe handling. The first 
> > patch addresses a NULL pointer dereference reported by LTP tests, while 
> > the second one is a trivial patch to address a missing check for return 
> > value, found by code inspection.  
> 
> Steven,
> Can you please take a look at these patches?
>

Sorry for the late reply, I've been traveling a lot lately. I'm looking
at these now. I'm trying to see how they triggered a bug.

-- Steve
