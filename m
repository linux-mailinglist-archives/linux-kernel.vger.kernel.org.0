Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5957F2FB23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2019 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfE3LvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 May 2019 07:51:15 -0400
Received: from foss.arm.com ([217.140.101.70]:34882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfE3LvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:51:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E85B9374;
        Thu, 30 May 2019 04:51:13 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A814B3F5AF;
        Thu, 30 May 2019 04:51:09 -0700 (PDT)
Date:   Thu, 30 May 2019 12:51:03 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/7] Documentation: DT: arm: add support for sockets
 defining package boundaries
Message-ID: <20190530115103.GA10919@e105550-lin.cambridge.arm.com>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-2-atish.patra@wdc.com>
 <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f41e62-5354-a674-d95f-5f63851a0ca6@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:39:17PM -0400, Andrew F. Davis wrote:
> On 5/29/19 5:13 PM, Atish Patra wrote:
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >
> >The current ARM DT topology description provides the operating system
> >with a topological view of the system that is based on leaf nodes
> >representing either cores or threads (in an SMT system) and a
> >hierarchical set of cluster nodes that creates a hierarchical topology
> >view of how those cores and threads are grouped.
> >
> >However this hierarchical representation of clusters does not allow to
> >describe what topology level actually represents the physical package or
> >the socket boundary, which is a key piece of information to be used by
> >an operating system to optimize resource allocation and scheduling.
> >
> 
> Are physical package descriptions really needed? What does "socket" imply
> that a higher layer "cluster" node grouping does not? It doesn't imply a
> different NUMA distance and the definition of "socket" is already not well
> defined, is a dual chiplet processor not just a fancy dual "socket" or are
> dual "sockets" on a server board "slotket" card, will we need new names for
> those too..

Socket (or package) just implies what you suggest, a grouping of CPUs
based on the physical socket (or package). Some resources might be
associated with packages and more importantly socket information is
exposed to user-space. At the moment clusters are being exposed to
user-space as sockets which is less than ideal for some topologies.

At the moment user-space is only told about hw threads, cores, and
sockets. In the very near future it is going to be told about dies too
(look for Len Brown's multi-die patch set).

I don't see how we can provide correct information to user-space based
on the current information in DT. I'm not convinced it was a good idea
to expose this information to user-space to begin with but that is
another discussion.

Morten
