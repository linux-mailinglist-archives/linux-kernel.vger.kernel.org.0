Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE515CC15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2019 10:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jul 2019 04:36:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44540 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfGBIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sY0UaQf2BxPnJAS0pHMdl/JmZYTYN6LHhMVkukh8JKc=; b=vSztaPJJffSldQkENZB/P6Otf
        6HhDOoClhCxdbAwH8DRTCI2f+O+oIBOEHPY3en8a04pJ4vsKmsdLqrnHRVmq9gCRj5XJTH3m7RG7J
        TnErkOXxUNaYxL0d9X7pdh/ifr9ho6LBonQlYNTfy3jy7DCsLdZBWUwQd1YQiXaaiAs/pl+zT1qjz
        iL+p9amPlFH7qCkg1RCBT6fAzoo8WPg99VK1yiu60xcKauNcTcnRIA/gEYg1XY1zJbfH3nemQXLEa
        mvXKUWVDuuczK8YvDRBJ14ZLCJ+RGHiWY/I6CkQpLH3IIq6TVReD8t7IVmeLtgpDqUw2RSi9eCcl3
        jUcmyb1Tw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiEHC-0005Zo-2Q; Tue, 02 Jul 2019 08:36:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C22FB20ADAD55; Tue,  2 Jul 2019 10:36:32 +0200 (CEST)
Date:   Tue, 2 Jul 2019 10:36:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Signed-off-by for the fix-late-interrupts patch?
Message-ID: <20190702083632.GZ3419@hirez.programming.kicks-ass.net>
References: <20190701213930.GA25736@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701213930.GA25736@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:39:31PM -0700, Paul E. McKenney wrote:
> Hello, Peter,
> 
> The patch below from your earlier email is doing fine in my testing.
> May I please add your Signed-of-by and designate you as author?

Sure, glad it worked :-)
