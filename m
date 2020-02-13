Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 811E715BA64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 09:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgBMIAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 03:00:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgBMIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oVk3qHIezoee3VNj7y2gOdnxt1SZIrS+8EECMrNmYPY=; b=jvGbZmNt3AWUyT5h3RwO+SHXBI
        H762LlG2hl6zpPpe2VU4Yxb8kOpKouAxHkZ1LzUvbcM2iit0928vYbPcqnasbAm2mO0nGS/wYGcL5
        De6qnTWtsoX+NS2Tl2dB6mCuorFFCOPkiF2ANaWEslm4vg2nmXtNZlm0GI6vJsQxd/zrRAm+tMsg3
        +bVRkiNQ1rO+iXtXuNdl+9pWS5TpM/U0Omdbu5CWF2wiiOfyOrt+RmJWd3JShO/3/+UFo9eoHz+aP
        oUxiRdnz80MpBBRTVRPNR1DvUBnpdQ6e97aHQjugaAsBIk3CbRniZoXC7kM0p0FlHCttrbs6SJmZb
        HVRp2xoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j29QV-0002VU-5b; Thu, 13 Feb 2020 08:00:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7BABE30066E;
        Thu, 13 Feb 2020 08:58:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0141520206D65; Thu, 13 Feb 2020 09:00:43 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:00:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        arnd@arndb.de, Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6/7] microblaze: Implement architecture spinlock
Message-ID: <20200213080043.GF14897@hirez.programming.kicks-ass.net>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ed53474e9ca6736353afd10ebe7ea98e4c6c459e.1581522136.git.michal.simek@xilinx.com>
 <20200212154756.GY14897@hirez.programming.kicks-ass.net>
 <5315513c-2492-6bb7-2961-b249851b2051@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5315513c-2492-6bb7-2961-b249851b2051@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 08:51:38AM +0100, Michal Simek wrote:
> On 12. 02. 20 16:47, Peter Zijlstra wrote:

> > 
> > That's a test-and-set spinlock if I read it correctly. Why? that's the
> > worst possible spinlock implementation possible.
> 
> This was written by Stefan and it is aligned with recommended
> implementation. What other options do we have?

A ticket lock should be simple enough; ARM has one you can borrow from.

The problem with TaS spinlocks is that they're unfair and exhibit
horrible starvation issues.
