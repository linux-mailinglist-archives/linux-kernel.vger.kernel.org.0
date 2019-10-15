Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80FD7C14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2019 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfJOQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 12:40:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45157 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfJOQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:40:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKPs3-0003m0-2t; Tue, 15 Oct 2019 18:40:27 +0200
Date:   Tue, 15 Oct 2019 18:40:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Frank Rowand <frank.rowand@am.sony.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Revert "ARM: Initialize split page table locks for
 vector page"
Message-ID: <20191015164026.6lfu4meeclpijxar@linutronix.de>
References: <20191014160238.enawbbfcxnbdrlch@linutronix.de>
 <20191015162609.GH32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191015162609.GH32665@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-15 09:26:09 [-0700], Matthew Wilcox wrote:
> Did your test build have ALLOC_SPLIT_PTLOCKS defined?

I tried to explain that ptlock_ptr() returns NULL for the page before
the ctor invocation and non-NULL afterwards which means that
USE_SPLIT_PTE_PTLOCKS and ALLOC_SPLIT_PTLOCKS was defined.

Sebastian
