Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58241733
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 23:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407749AbfFKVwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 17:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407165AbfFKVwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 17:52:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3A1720866;
        Tue, 11 Jun 2019 21:52:39 +0000 (UTC)
Date:   Tue, 11 Jun 2019 17:52:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Preisner <linux@tpreisner.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: add simple oneshot function tracer
Message-ID: <20190611175237.0ea4fa4f@gandalf.local.home>
In-Reply-To: <20190611203312.13653-1-linux@tpreisner.de>
References: <20190529104552.146fa97c@oasis.local.home>
        <20190611203312.13653-1-linux@tpreisner.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 22:33:11 +0200
Thomas Preisner <linux@tpreisner.de> wrote:

> However, due to there not being any mechanism (that I am aware of) to
> activate such stat tracers via kernel commandline this oneshot profiler
> is now always active when selected. Therefore, it is no longer possible
> to disable this tracer during runtime and thus, allocated memory is no
> longer freed.

What do you mean? The function profile has its own file to enable it:

 echo 1 > /sys/kernel/tracing/function_profile_enabled

And disable it:

 echo 0 > /sys/kernel/tracing/function_profile_enabled

-- Steve

