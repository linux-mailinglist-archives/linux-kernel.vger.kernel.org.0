Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98049184A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Mar 2020 16:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCMPQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Mar 2020 11:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMPQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:16:22 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 089C620724;
        Fri, 13 Mar 2020 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584112581;
        bh=3xbchtKOWoAjnFyWfky9yMnBu3jNSBXc4wnCwqkrJok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B18QreqfOdRb+qITgLb7HS2ydnP4N+VBz1zKJ7Pvjp0wP0x6cv9ON/jCH8A4VEStM
         OG2KW15/byR4VhZ2St1kjjPH1VdD5JSr+C3E4PQ4siElCjjUHVawAASQ5PTADnVT0C
         Mk+5eKaYOqS4cORYEkIaOrlZVTK9BgaYKCeYxFrE=
Date:   Fri, 13 Mar 2020 16:16:19 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-II V2 07/13] x86/entry: Move irq tracing on syscall
 entry to C-code
Message-ID: <20200313151618.GB32144@lenoir>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.621492144@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308222609.621492144@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 11:24:06PM +0100, Thomas Gleixner wrote:
> Now that the C entry points are safe, move the irq flags tracing code into
> the entry helper.
>

The consolidation is most welcome but the changelog is still a bit
misleading. The fact that the C entry points are now safe doesn't
make irq flags tracing safe itself.

Thanks.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
