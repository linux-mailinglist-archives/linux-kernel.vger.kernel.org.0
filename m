Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC66162944
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2020 16:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBRPSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Feb 2020 10:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbgBRPS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:18:28 -0500
Received: from tzanussi-mobl9 (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB3C24655;
        Tue, 18 Feb 2020 15:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582039108;
        bh=bBPJ+mRnzEMMdJSuxuJOrXFYtWZeyUv5H3TE5t6entU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AnZd926r9ie692W1fiQLF0vApHxSV//bCa0NfejllD+h+2/V5e93e68AHoBzUa/ka
         eKJRx9BX4+cW4KIhZ9Xqnj2B4SYn5gMOktzE1z5B5oHxPaOxP3ryyXNxlg7mHpjuLo
         OaEfRU9nF9F3pnOhaKUUz1sWv3wufVDxxvm5/0dU=
Message-ID: <1582039106.18307.1.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix synthetic event generation API and test
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     artem.bityutskiy@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 18 Feb 2020 09:18:26 -0600
In-Reply-To: <158193313870.8868.10793333111731425487.stgit@devnote2>
References: <158193313870.8868.10793333111731425487.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, 2020-02-17 at 18:52 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here is a couple of patches to fix 2 issues LKP and I found on
> synthetic event generation test.
> 
> [1/2] is for fixing warnings on smp_processor_id() without
> disabling preemption, and [2/2] is for fixing a bug on the API
> itself which LKP reported.
> 
> Thank you,

Thank you for fixing these.

For both,

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


Tom

> 
> ---
> 
> Masami Hiramatsu (2):
>       tracing: Fix synth event test to avoid using smp_processor_id()
>       tracing: Clear trace_state when starting trace
> 
> 
>  kernel/trace/synth_event_gen_test.c |   23 +++++++++++++++++------
>  kernel/trace/trace_events_hist.c    |    4 ++--
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
