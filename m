Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DDB15882B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 03:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBKCTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 21:19:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbgBKCTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 21:19:53 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8174C2072C;
        Tue, 11 Feb 2020 02:19:52 +0000 (UTC)
Date:   Mon, 10 Feb 2020 21:19:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     zzyiwei@google.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add gpu memory tracepoints
Message-ID: <20200210211951.1633c7d0@rorschach.local.home>
In-Reply-To: <20200211011631.7619-1-zzyiwei@google.com>
References: <20200211011631.7619-1-zzyiwei@google.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 17:16:31 -0800
zzyiwei@google.com wrote:

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

What exactly is this, and why is it being put in the tracing
infrastructure code?

-- Steve
