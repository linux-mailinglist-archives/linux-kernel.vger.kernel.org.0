Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEA6D218
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2019 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfGRQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jul 2019 12:37:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfGRQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:37:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F33BB217F4;
        Thu, 18 Jul 2019 16:37:44 +0000 (UTC)
Date:   Thu, 18 Jul 2019 12:37:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eiichi Tsukata <devel@etsukata.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@redhat.com
Subject: Re: [PATCH] tracing: Fix user stack trace "??" output
Message-ID: <20190718123743.3aa5d697@gandalf.local.home>
In-Reply-To: <1789efd4-1108-64e8-a6aa-39ca5d5595dc@etsukata.com>
References: <20190630085438.25545-1-devel@etsukata.com>
        <1789efd4-1108-64e8-a6aa-39ca5d5595dc@etsukata.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2019 10:23:19 +0900
Eiichi Tsukata <devel@etsukata.com> wrote:

> Hello Steven
> 
> Would you review the patch?

Thanks for reminding me. Looks good, I'll apply it now and start
testing it.

-- Steve

