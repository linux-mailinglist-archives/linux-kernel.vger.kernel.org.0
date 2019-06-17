Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1D0483C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 15:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfFQNVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 09:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFQNVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:21:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3ED1A3004582;
        Mon, 17 Jun 2019 13:21:36 +0000 (UTC)
Received: from localhost (holly.tpb.lab.eng.brq.redhat.com [10.43.134.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE7CB7EA20;
        Mon, 17 Jun 2019 13:21:34 +0000 (UTC)
Date:   Mon, 17 Jun 2019 15:21:33 +0200
From:   Miroslav Lichvar <mlichvar@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?utf-8?B?57u05bq355+z?= <swkhack@gmail.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, swkhack@qq.com
Subject: Re: [PATCH] time: fix a assignment error in ntp module
Message-ID: <20190617132133.GA7851@localhost>
References: <20190422093421.47896-1-swkhack@gmail.com>
 <alpine.DEB.2.21.1906170814590.1760@nanos.tec.linutronix.de>
 <CAObeVcdBDbSiyQCX7C_G3p6TpB9yjRyrWwsvPgh11V8v+BNaqQ@mail.gmail.com>
 <alpine.DEB.2.21.1906171409250.1854@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1906171409250.1854@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 17 Jun 2019 13:21:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 02:14:57PM +0200, Thomas Gleixner wrote:
> On Mon, 17 Jun 2019, 维康石 wrote:
> > Yes,the  >UINT_MAX value can be passed by
> > syscall adjtimex->do_adjtimex->__do_adjtimex->process_adjtimex_modes by the
> > proper arugments.
> 
> So there is clearly some sanity check missing, but surely not that
> type cast.

As the offset is saved in an int (and returned via adjtimex() in the
tai field), should be the maximum INT_MAX?

We probably also want to avoid overflow in the offset on a leap second
and the CLOCK_TAI clock itself, so maybe it would make sense to
specify a much smaller maximum like 1000000?

Even 1000 should be good enough for near future. Negative values are
not allowed anyway. If the Earth's rotation changed significantly
(e.g. hitting a very large asteroid), there probably wouldn't be
anyone left to care about TAI. 

-- 
Miroslav Lichvar
