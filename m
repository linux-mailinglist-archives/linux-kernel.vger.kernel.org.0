Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46612648A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 15:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfLSOWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 09:22:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:38992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfLSOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:22:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F40DB13C;
        Thu, 19 Dec 2019 14:22:36 +0000 (UTC)
Date:   Thu, 19 Dec 2019 15:22:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix exclusive_console replaying
Message-ID: <20191219142235.4zpabzlyhav6d3cd@pathway.suse.cz>
References: <20191219115322.31160-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219115322.31160-1-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-12-19 12:59:22, John Ogness wrote:
> Commit f92b070f2dc8 ("printk: Do not miss new messages when replaying
> the log") introduced a new variable @exclusive_console_stop_seq to
> store when an exclusive console should stop printing. It should be
> set to the @console_seq value at registration. However, @console_seq
> is previously set to @syslog_seq so that the exclusive console knows
> where to begin. This results in the exclusive console immediately
> reactivating all the other consoles and thus repeating the messages
> for those consoles.
> 
> Set @console_seq after @exclusive_console_stop_seq has stored the
> current @console_seq value.
> 
> Fixes: f92b070f2dc8 ("printk: Do not miss new messages when replaying the log")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Grr, it was an ugly mistake. I am surprised that it has stayed there
for more then one year without noticing. Thanks a lot for fixing.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
