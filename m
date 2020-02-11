Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596C01587D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 02:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgBKBRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 20:17:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41402 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBKBRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:17:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so5733421lfp.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 17:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KQpclvcs1wj3CWaHgTdVioyERSUX6iMqo5oCTfbZLU=;
        b=WGAUPbIE9b9uN9VEH7eKV8qMTuSm4niITnWE9/4I9zQza9GQwRifHiFBdKdWXLfUo5
         YPUKiJoY0CkvtSpPjv1+bF+lGobS4GmwWc9mwja2s9hq5RDFARP5JEinX43zTV0D4inQ
         ElgANsQTWrYKTsWkNmf6LlpnyGq+gvCg7uAUBv/vpXSqludgIL58P9ijB5TIz7WEN43/
         RARm8Z8tIqMSpri//EEcw0/+lj7k9bLJ95Bs0sMFEXqKgz7i/a8J1VygLXPtjCvL8+4o
         NHGIwqrEOhj3/Q8jh8g1hGZXNle+guivAEfavvt7KSIzUlFaYKq6z8tP5IBPO5htQc1S
         RflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KQpclvcs1wj3CWaHgTdVioyERSUX6iMqo5oCTfbZLU=;
        b=at5gCuI/a6mfPi39AjLPzlvn1vQD5yvS0YgJw7yNxVZw0y9JbWOrjJ4gDdGN5npmVS
         TxC1BZqZLY13ekc/i1lFVULEdGhCo3aNQ3l9g+LhG3O8WwwLN/zezLAGVbjkIzYBS3Wg
         jrgL4MYLzuD7bkz0P44WK2s5h9mt4ockijYM90oeBPDKEOxNxB6jUyiRAudAeHVPJSZc
         jxUg71DQGM2VI9CytiJVuP6O68mZR+IoJHppbWLuTQCKSUVK4DiMDh0f146KgNJbcU0u
         hofROr75omcLKbGMLUhheJZc50aMu+J+zvElUZy+S5HD2kttAXKw2k2rH5QtisoiKXPe
         R5Xg==
X-Gm-Message-State: APjAAAV0AcLEManDBOIM9rETUGz8jKUk3kqDa9UCgPu5em+DEy/2z6lK
        yzrq559ZuFzFowS5SIpkxwHSNzNC6lZVOS3gZ+S3
X-Google-Smtp-Source: APXvYqybbu7Ru+Nh5+RJ+1tsXpwOY5l2DH0FSysckuUQCMKqgfSUR8XUqKVrpb+EVX9OdFpM6Yd++fdX6s/KSOiJCUA=
X-Received: by 2002:ac2:58c1:: with SMTP id u1mr2129644lfo.57.1581383838753;
 Mon, 10 Feb 2020 17:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20200211011631.7619-1-zzyiwei@google.com>
In-Reply-To: <20200211011631.7619-1-zzyiwei@google.com>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Mon, 10 Feb 2020 17:17:07 -0800
Message-ID: <CAKT=dDm=qdrWCN2TVfZaaMijEX5gn_VpjA+8NaW0x9TNDf+A-A@mail.gmail.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Prahlad Kilambi <prahladk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 5:16 PM <zzyiwei@google.com> wrote:
>
> From: Yiwei Zhang <zzyiwei@google.com>
>
> This change adds the below gpu memory tracepoint:
> gpu_mem/gpu_mem_total: track global or process gpu memory total counters
>
> Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
> ---
>  include/trace/events/gpu_mem.h | 64 ++++++++++++++++++++++++++++++++++
>  kernel/trace/Kconfig           |  3 ++
>  kernel/trace/Makefile          |  1 +
>  kernel/trace/trace_gpu_mem.c   | 13 +++++++
>  4 files changed, 81 insertions(+)
>  create mode 100644 include/trace/events/gpu_mem.h
>  create mode 100644 kernel/trace/trace_gpu_mem.c
>
> diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> new file mode 100644
> index 000000000000..3b632a2b5100
> --- /dev/null
> +++ b/include/trace/events/gpu_mem.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * GPU memory trace points
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM gpu_mem
> +
> +#if !defined(_TRACE_GPU_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_GPU_MEM_H
> +
> +#include <linux/tracepoint.h>
> +
> +/*
> + * The gpu_memory_total event indicates that there's an update to either the
> + * global or process total gpu memory counters.
> + *
> + * This event should be emitted whenever the kernel device driver allocates,
> + * frees, imports, unimports memory in the GPU addressable space.
> + *
> + * @gpu_id: This is the gpu id.
> + *
> + * @pid: Put 0 for global total, while positive pid for process total.
> + *
> + * @size: Virtual size of the allocation in bytes.
> + *
> + */
> +TRACE_EVENT(gpu_mem_total,
> +       TP_PROTO(
> +               uint32_t gpu_id,
> +               uint32_t pid,
> +               uint64_t size
> +       ),
> +       TP_ARGS(
> +               gpu_id,
> +               pid,
> +               size
> +       ),
> +       TP_STRUCT__entry(
> +               __field(uint32_t, gpu_id)
> +               __field(uint32_t, pid)
> +               __field(uint64_t, size)
> +       ),
> +       TP_fast_assign(
> +               __entry->gpu_id = gpu_id;
> +               __entry->pid = pid;
> +               __entry->size = size;
> +       ),
> +       TP_printk(
> +               "gpu_id=%u "
> +               "pid=%u "
> +               "size=%llu",
> +               __entry->gpu_id,
> +               __entry->pid,
> +               __entry->size
> +       )
> +);
> +
> +#endif /* _TRACE_GPU_MEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 91e885194dbc..cb404755b0a6 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -85,6 +85,9 @@ config EVENT_TRACING
>  config CONTEXT_SWITCH_TRACER
>         bool
>
> +config TRACE_GPU_MEM
> +       bool
> +
>  config RING_BUFFER_ALLOW_SWAP
>         bool
>         help
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f9dcd19165fa..267985313dca 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_PREEMPTIRQ_DELAY_TEST) += preemptirq_delay_test.o
>  obj-$(CONFIG_SYNTH_EVENT_GEN_TEST) += synth_event_gen_test.o
>  obj-$(CONFIG_KPROBE_EVENT_GEN_TEST) += kprobe_event_gen_test.o
>  obj-$(CONFIG_CONTEXT_SWITCH_TRACER) += trace_sched_switch.o
> +obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
>  obj-$(CONFIG_FUNCTION_TRACER) += trace_functions.o
>  obj-$(CONFIG_PREEMPTIRQ_TRACEPOINTS) += trace_preemptirq.o
>  obj-$(CONFIG_IRQSOFF_TRACER) += trace_irqsoff.o
> diff --git a/kernel/trace/trace_gpu_mem.c b/kernel/trace/trace_gpu_mem.c
> new file mode 100644
> index 000000000000..01e855897b6d
> --- /dev/null
> +++ b/kernel/trace/trace_gpu_mem.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GPU memory trace points
> + *
> + * Copyright (C) 2020 Google, Inc.
> + */
> +
> +#include <linux/module.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/gpu_mem.h>
> +
> +EXPORT_TRACEPOINT_SYMBOL(gpu_mem_total);
> --
> 2.25.0.341.g760bfbb309-goog
>
