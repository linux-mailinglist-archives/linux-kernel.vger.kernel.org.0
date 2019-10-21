Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68FDF1DB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2019 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJUPoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Oct 2019 11:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfJUPoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:44:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E7C20873;
        Mon, 21 Oct 2019 15:44:07 +0000 (UTC)
Date:   Mon, 21 Oct 2019 11:44:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        kaushalk@codeaurora.org, Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] trace: fix race in perf_trace_buf initialization
Message-ID: <20191021114406.15b6ee88@gandalf.local.home>
In-Reply-To: <59d02ee4-5329-5cfd-1fc2-790d99fe4b0d@codeaurora.org>
References: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
        <20191018171216.3e446f1e@gandalf.local.home>
        <59d02ee4-5329-5cfd-1fc2-790d99fe4b0d@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 10:12:43 +0530
Prateek Sood <prsood@codeaurora.org> wrote:

> Hi Song,
> 
> Could you please help in this query.

I have it ready to go to Linus. I'll wait a few hours, and if I don't
hear anything I'll send it out.

-- Steve
