Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6916FBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfGVIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 04:53:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGVIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:53:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hpU4h-0001w3-Ec; Mon, 22 Jul 2019 10:53:39 +0200
Date:   Mon, 22 Jul 2019 10:53:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cao jin <caoj.fnst@cn.fujitsu.com>
cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@kernel.org
Subject: Re: [PATCH] x86/irq/64: fix the missing update on comment
In-Reply-To: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <alpine.DEB.2.21.1907221051580.1782@nanos.tec.linutronix.de>
References: <20190719081635.26528-1-caoj.fnst@cn.fujitsu.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cao,

On Fri, 19 Jul 2019, Cao jin wrote:

> Commit e6401c130931 ("x86/irq/64: Split the IRQ stack into its own pages")
> missed to update one piece of comment as it did to its peer in Xen, which
> will confuse people who still need to read comment.
> 
> A bonus fix to identation in ZO's linker script: spaces -> tab.

Please don't add 'bonus' changes. A patch which fixes a stale comment has
nothing to do with a indentation change in an unrelated file.

Thanks,

	tglx

