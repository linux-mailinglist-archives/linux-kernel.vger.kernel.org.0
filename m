Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DFCCFB61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2019 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJHNdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Oct 2019 09:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730301AbfJHNdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:33:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 522E320673;
        Tue,  8 Oct 2019 13:33:41 +0000 (UTC)
Date:   Tue, 8 Oct 2019 09:33:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@kernel.org>,
        sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
        linux-mm@kvack.org, john.ogness@linutronix.de,
        akpm@linux-foundation.org, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191008093339.7092313b@gandalf.local.home>
In-Reply-To: <1570541032.5576.297.camel@lca.pw>
References: <1570228005-24979-1-git-send-email-cai@lca.pw>
        <20191007143002.l37bt2lzqtnqjqxu@pathway.suse.cz>
        <1570460350.5576.290.camel@lca.pw>
        <20191007151237.GP2381@dhcp22.suse.cz>
        <1570462407.5576.292.camel@lca.pw>
        <20191008081510.ptwmb7zflqiup5py@pathway.suse.cz>
        <20191008091349.6195830d@gandalf.local.home>
        <1570541032.5576.297.camel@lca.pw>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Oct 2019 09:23:52 -0400
Qian Cai <cai@lca.pw> wrote:

> I feel like that is what I trying to do, but there seems a lot of resistances
> with that approach where pragmatism met with perfectionism.

It's the way it came across. It sounded as if you were proposing
"the solution". I'm coming out and explicitly saying that this may be a
"temporary solution", as having "printk_deferred()" we can easily
remove them when that becomes the default operation.

-- Steve

