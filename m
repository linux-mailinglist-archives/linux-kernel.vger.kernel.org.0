Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87F414F4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 23:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgAaWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 17:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgAaWnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:43:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D49214D8;
        Fri, 31 Jan 2020 22:43:46 +0000 (UTC)
Date:   Fri, 31 Jan 2020 17:43:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     artem.bityutskiy@linux.intel.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing: Consolidate some synth_event_trace code
Message-ID: <20200131174344.5606d154@gandalf.local.home>
In-Reply-To: <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
References: <cover.1580506712.git.zanussi@kernel.org>
        <d1c8d8ad124a653b7543afe801d38c199ca5c20e.1580506712.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 15:55:31 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> +++ b/kernel/trace/trace_events_hist.c
> @@ -2053,24 +2053,72 @@ int synth_event_trace_start(struct trace_event_file *file,
>  }
>  EXPORT_SYMBOL_GPL(synth_event_trace_start);
>  
> -static int save_synth_val(struct synth_field *field, u64 val,
> +int __synth_event_add_val(const char *field_name, u64 val,

Hmm, shouldn't __synth_event_add_val() still be static?

-- Steve

>  			  struct synth_event_trace_state *trace_state)
>  {
> -	struct synth_trace_event *entry = trace_state->entry;
> +	struct synth_field *field = NULL;
> +	struct synth_trace_event *entry;
> +	struct synth_event *event;
> +	int i, ret = 0;
> +
