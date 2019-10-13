Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6CD57F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2019 22:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfJMUDH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Oct 2019 16:03:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfJMUDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 16:03:07 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4899020673;
        Sun, 13 Oct 2019 20:03:06 +0000 (UTC)
Date:   Sun, 13 Oct 2019 16:03:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 08/11] recordmcount: Fix nop_mcount()
 function
Message-ID: <20191013160304.200622a4@gandalf.local.home>
In-Reply-To: <20191013155337.6b87c16a@gandalf.local.home>
References: <20191013174342.381019558@goodmis.org>
        <20191013174419.228868312@goodmis.org>
        <20191013145743.6fdef005@gandalf.local.home>
        <20191013191407.vg7wnfvlhae5dugq@pengutronix.de>
        <20191013155337.6b87c16a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2019 15:53:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> The original looked like this:
> 
> Reported-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>
> Tested-by: Uwe Kleine-KÃ¶nig <u.kleine-koenig@pengutronix.de>

And if you are wondering what the git history has, you can see it here:

https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?h=trace-v5.4-rc2&id=7f8557b88d6aa5bf31f25f6013d81355a1b1d48d

-- Steve
