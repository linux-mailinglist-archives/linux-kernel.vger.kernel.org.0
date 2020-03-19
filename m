Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F6618B94E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 15:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCSOY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 10:24:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32935 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgCSOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:24:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jEw6O-0002to-4v; Thu, 19 Mar 2020 15:24:52 +0100
Date:   Thu, 19 Mar 2020 15:24:52 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Graziadei <thomas.graziadei@omicronenergy.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] powerpc: Fix lazy preemption for powerpc 32bit
Message-ID: <20200319142452.dqmkuruts3i6wjyt@linutronix.de>
References: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c91d808-b077-408c-b120-99e806efaeb5@EXC03-ATKLA.omicron.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 21:26:40 [+0100], Thomas Graziadei wrote:
> From: Thomas Graziadei <thomas.graziadei@omicronenergy.com>
> 
> The 32bit powerpc assembler implementation of the lazy preemption
> set the _TIF_PERSYSCALL_MASK on the low word. This could lead to
> modprobe segfaults and a kernel panic - not syncing: Attempt to
> kill init! issue.
> 
> Fixed by shifting the mask by 16 bit using andis and lis.

bah. Thank you for catching this.
Still e500 based powerpc I assume?

> Signed-off-by: Thomas Graziadei <thomas.graziadei@omicronenergy.com>

Sebastian
