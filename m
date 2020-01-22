Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF11F144DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAVIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jan 2020 03:31:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVIbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:31:35 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iuBQA-0004NX-6D; Wed, 22 Jan 2020 09:31:30 +0100
Date:   Wed, 22 Jan 2020 09:31:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>, Scott Wood <swood@redhat.com>
Subject: Re: [PATCH RT 24/32] sched: migrate_enable: Use stop_one_cpu_nowait()
Message-ID: <20200122083130.kuu3yppckhyjrr4u@linutronix.de>
References: <20200117174111.282847363@goodmis.org>
 <20200117174131.019724236@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117174131.019724236@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-17 12:41:35 [-0500], Steven Rostedt wrote:
> 4.19.94-rt39-rc1 stable review patch.
> If anyone has any objections, please let me know.

I don't know how much of this patch and the previous is classified as
"new feature" vs "bug fix". This patch requires patch 31 (of this series)
as bug fix.
I'm not against it, just pointing out.

Sebastian
