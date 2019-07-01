Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E484519D37
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2019 14:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEJM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 May 2019 08:27:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfEJM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:27:22 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hP4c6-0006Ls-Id; Fri, 10 May 2019 14:26:58 +0200
Date:   Fri, 10 May 2019 14:26:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Corey Minyard <minyard@acm.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190510122657.4oj6g4xws7ooszyo@linutronix.de>
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
 <20190510120824.GL16145@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510120824.GL16145@minyard.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-10 07:08:24 [-0500], Corey Minyard wrote:
> Thanks a bunch.  Do I need to do anything for backports?  I'm pretty
> sure this goes back to 4.4.

No, you don't. I plan to release a new 5.0-RT today. Then the stable
maintainer will pick it at once they get to it.
4.4 is maintained by Daniel Wagner.

> -corey

Sebastian
