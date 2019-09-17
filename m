Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3B4B4BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfIQKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 06:24:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfIQKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:24:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iAAez-0001jn-8C; Tue, 17 Sep 2019 12:24:37 +0200
Date:   Tue, 17 Sep 2019 12:24:37 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        sebastian@breakpoint.cc, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] rt-tests: backfire: Don't include asm/uaccess.h directly
Message-ID: <20190917102436.tn2faq3hcdadybgw@linutronix.de>
References: <20190903191321.6762-1-sultan@kerneltoast.com>
 <alpine.LFD.2.21.1909162356500.10273@planxty>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1909162356500.10273@planxty>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-16 23:57:32 [+0200], John Kacur wrote:
> Signed-off-by: John Kacur <jkacur@redhat.com>

Hmmm. I remember this thing came up years ago in the Debian BTS and then
that backfire module got removed from the Debian package because there
was no need for it.
Just to clarify: is there any need to keep this module or do I mix up
things?

Sebastian
