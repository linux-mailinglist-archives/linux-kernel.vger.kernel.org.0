Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B205B18D32B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCTPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:43:20 -0400
Received: from ms.lwn.net ([45.79.88.28]:42314 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgCTPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:43:20 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7CE382E4;
        Fri, 20 Mar 2020 15:43:19 +0000 (UTC)
Date:   Fri, 20 Mar 2020 09:43:18 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
Message-ID: <20200320094318.7390e5e5@lwn.net>
In-Reply-To: <87h7yj59m0.fsf@nanos.tec.linutronix.de>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
        <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
        <87h7yj59m0.fsf@nanos.tec.linutronix.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 16:28:23 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> >   * For shared mappings (when @fshared), the key is:
> > - *   ( inode->i_sequence, page->index, offset_within_page )
> > + * ( inode->i_sequence, page->index, offset_within_page )  
> 
> Sigh. Is there no better way to make this look sane both in the file and
> in the docs?

I'd do:

  * For shared mappings (when @fshared), the key is::
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *

jon
