Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42E515B136
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 20:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgBLThy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Feb 2020 14:37:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLThx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:37:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE251206D7;
        Wed, 12 Feb 2020 19:37:52 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:37:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yiwei Zhang <zzyiwei@google.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
Message-ID: <20200212143751.0114fe78@gandalf.local.home>
In-Reply-To: <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
References: <20200211011631.7619-1-zzyiwei@google.com>
        <20200210211951.1633c7d0@rorschach.local.home>
        <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com>
        <20200210221521.59928416@rorschach.local.home>
        <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 11:26:08 -0800
Yiwei Zhang <zzyiwei@google.com> wrote:

> Hi Steven,
> 
> I can move the stuff out from the kernel/trace. Then can we still
> leave include/trace/events/gpu_mem.h where it is right now? Or do we
> have to move that out as well? Because we would need a non-drm common
> header place for the tracepoint so that downstream drivers can find
> the tracepoint definition.
> 

You can leave the header there. The include/trace/events/ is the place
to put trace event headers for common code.

It just did not belong in kernel/trace/

Thanks!

-- Steve
