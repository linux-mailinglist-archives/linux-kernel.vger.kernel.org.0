Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E12A14D177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jan 2020 20:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgA2TzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jan 2020 14:55:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgA2TzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:55:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D072067C;
        Wed, 29 Jan 2020 19:55:10 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:55:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v3 04/12] tracing: Add dynamic event command creation
 interface
Message-ID: <20200129145508.6947fff8@gandalf.local.home>
In-Reply-To: <1580324572.2757.2.camel@kernel.org>
References: <cover.1579904761.git.zanussi@kernel.org>
        <4a38478f56b9e831803500f82af896bda92a5370.1579904761.git.zanussi@kernel.org>
        <20200129130018.230cef12@gandalf.local.home>
        <1580324572.2757.2.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2020 13:02:52 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> 
> OK, I can send a follow-on patch that does this.

Thanks!

> 
> Note that I just sent a v4 series which moves most of the code in this
> patch to trace_dynevent.{c,h} as requested by Masami.  No other changes
> from v3 were made other than adding acks.

Luckily, I had a meeting and stopped at patch 5. I reverted and started
again with your v4 series, and did the swap again too.

-- Steve
