Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957B2D57A4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfJMTOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Oct 2019 15:14:11 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38667 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMTOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:14:10 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iJjJg-0000GW-VF; Sun, 13 Oct 2019 21:14:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iJjJg-0004Dk-0V; Sun, 13 Oct 2019 21:14:08 +0200
Date:   Sun, 13 Oct 2019 21:14:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 08/11] recordmcount: Fix nop_mcount() function
Message-ID: <20191013191407.vg7wnfvlhae5dugq@pengutronix.de>
References: <20191013174342.381019558@goodmis.org>
 <20191013174419.228868312@goodmis.org>
 <20191013145743.6fdef005@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191013145743.6fdef005@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 02:57:43PM -0400, Steven Rostedt wrote:
> One problem with quilt, is that it doesn't like non-ASCII characters
> (I'm looking at you Kleine-K�nig!)
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The removal of the longjmp code in recordmcount.c mistakenly made the
> return of make_nop() being negative an exit of nop_mcount(). It should
> not exit the routine, but instead just not process that part of the
> code. By exiting with an error code, it would cause the update of
> recordmcount to fail some files which would fail the build if ftrace
> function tracing was enabled.
> 
> Link: http://lkml.kernel.org/r/20191009110538.5909fec6@gandalf.local.home
> 
> Reported-by: Uwe Kleine-�nig <u.kleine-koenig@pengutronix.de>
> Tested-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>

And now it seems to have problems with plain ASCII-K, but only once out
of two :-|

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
