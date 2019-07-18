Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC1F6D394
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 20:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390898AbfGRSRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 14:17:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58371 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:17:25 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hoAxt-000184-4o; Thu, 18 Jul 2019 20:17:13 +0200
Date:   Thu, 18 Jul 2019 20:17:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     luferry <luferry@163.com>, Rik van Riel <riel@surriel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] smp: avoid generic_exec_single cause system
 lockup
In-Reply-To: <20190718160601.GP3402@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1907182016190.1785@nanos.tec.linutronix.de>
References: <20190718080308.48381-1-luferry@163.com> <alpine.DEB.2.21.1907181007340.1778@nanos.tec.linutronix.de> <5f5fbd7.1073c.16c0446ea63.Coremail.luferry@163.com> <alpine.DEB.2.21.1907181122240.1984@nanos.tec.linutronix.de>
 <20190718160601.GP3402@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019, Peter Zijlstra wrote:
> On Thu, Jul 18, 2019 at 11:58:47AM +0200, Thomas Gleixner wrote:
> 
> As we discussed on IRC, it is worse, we can only use these functions
> from task/process context. We need something like the below.

Indeed that's better defined.

Thanks,

	tglx
