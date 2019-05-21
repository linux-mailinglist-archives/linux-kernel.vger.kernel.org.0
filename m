Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D324F95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUND5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 09:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEUND4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 09:03:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D0E21773;
        Tue, 21 May 2019 13:03:55 +0000 (UTC)
Date:   Tue, 21 May 2019 09:03:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        Rich Felker <dalias@libc.org>,
        Luis de Bethencourt <luisbg@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: linux-next: removed trees
Message-ID: <20190521090353.7f5e24b4@gandalf.local.home>
In-Reply-To: <20190521093743.5afaaadf@canb.auug.org.au>
References: <20190521093743.5afaaadf@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019 09:37:43 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> kconfig

Hmm, there hasn't been any updates to "make localmodconfig" recently.
Don't know about the future. But if there is, I'll need to reinstate it.

-- Steve
