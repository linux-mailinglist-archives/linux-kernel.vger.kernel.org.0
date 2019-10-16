Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678A0D8CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392056AbfJPJpF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Oct 2019 05:45:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49462 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfJPJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:45:04 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKfrb-0001o6-0h; Wed, 16 Oct 2019 11:45:03 +0200
Date:   Wed, 16 Oct 2019 11:45:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Grall <julien.grall@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, tglx@linutronix.de
Subject: Re: [PATCH REPOST] lib/ubsan: Don't seralize UBSAN report
Message-ID: <20191016094502.hnou4qtgqecm2cla@linutronix.de>
References: <20191010163616.qon4ppmhf74l4fix@linutronix.de>
 <20191016103248.3d5f1d4f@donnerap.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191016103248.3d5f1d4f@donnerap.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-16 10:32:48 [+0100], Andre Przywara wrote:
> On Thu, 10 Oct 2019 18:36:16 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> Hi,
Hi,

> you seem to be me missing the "From:" line here, to keep Julien as the author. If you have this patch in a git repo, you could use:
> $ git commit --amend --author "Julien Grall <julien.grall@arm.com>"
> so that git keeps the authorship, which should be translated into the proper email form (From: ...) by git send-email.

I accidentally deleted it while sending it. I have it properly in my
stash.

> And what is the reason for the repost anyway?

I haven't seen applied by anyone but now I is in -next so it is all
good. Le me update my notes…

> Cheers,
> Andre.

Sebastian
