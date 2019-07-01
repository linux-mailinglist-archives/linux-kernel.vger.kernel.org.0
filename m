Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2695624F56
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbfEUMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 08:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEUMz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 08:55:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19A8521773;
        Tue, 21 May 2019 12:55:27 +0000 (UTC)
Date:   Tue, 21 May 2019 08:55:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rdunlap@infradead.org
Subject: Re: [PATCH] [linux-next] docs: tracing: Fix typos in histogram.rst
Message-ID: <20190521085525.2963c10f@gandalf.local.home>
In-Reply-To: <20190521123000.24544-1-standby24x7@gmail.com>
References: <20190521123000.24544-1-standby24x7@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 21:30:00 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes some spelling typos in histogram.rst

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Jon,

Care to take this in your tree?

-- Steve

> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
