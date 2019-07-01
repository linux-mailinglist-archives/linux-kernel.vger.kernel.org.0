Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5854EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbfFYMZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 08:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfFYMZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:25:19 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38399213F2;
        Tue, 25 Jun 2019 12:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561465518;
        bh=hkiYecr5kUtTyXgJ50ng7hcU/bW4ODzYs1BytU8y4Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUCWTtR2GCocBqt8men18ASkbGBSs2KqH4dBH4Tka9uQtBTQETaG27huuK593d+Df
         5ppgyGa90LJ6bLebFufCnSe7rQ0YUEbUR+2iyJB1MvaYi7HfbVi+iguH3fNan7V1zj
         waXpI39tlftr8ySN6kBKT4ACO3V76OP3WMRhW5OY=
Date:   Tue, 25 Jun 2019 14:25:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH] time/tick-broadcast: Fix tick_broadcast_offline()
 lockdep complaint
Message-ID: <20190625122514.GA23880@lenoir>
References: <20190621121630.GE26519@linux.ibm.com>
 <20190621122927.GV3402@hirez.programming.kicks-ass.net>
 <20190621133414.GF26519@linux.ibm.com>
 <20190621174104.GA7519@linux.ibm.com>
 <20190621175027.GA23260@linux.ibm.com>
 <20190621234602.GA16286@linux.ibm.com>
 <20190624231222.GA17497@lerouge>
 <20190624234422.GP26519@linux.ibm.com>
 <20190625004300.GB17497@lerouge>
 <20190625075139.GT3436@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625075139.GT3436@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:51:39AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 25, 2019 at 02:43:00AM +0200, Frederic Weisbecker wrote:
> > Yeah, unfortunately there is no atomic_add_not_zero_return().
> 
> There is atomic_fetch_add_unless().

Ah, that could work!
