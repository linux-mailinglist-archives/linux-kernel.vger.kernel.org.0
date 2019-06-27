Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B12E5833E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2019 15:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfF0NRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 09:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfF0NRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:17:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6F02084B;
        Thu, 27 Jun 2019 13:17:41 +0000 (UTC)
Date:   Thu, 27 Jun 2019 09:17:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: Fix spurious mcount entries on powerpc
Message-ID: <20190627091739.15a51a35@gandalf.local.home>
In-Reply-To: <8736jvtvvg.fsf@concordia.ellerman.id.au>
References: <20190626183801.31247-1-naveen.n.rao@linux.vnet.ibm.com>
        <8736jvtvvg.fsf@concordia.ellerman.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 15:55:47 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Steve are you OK if I merge this via the powerpc tree? I'll reword the
> commit message so that it makes sense coming prior to the commit
> mentioned above.

Yes, please add:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks,

-- Steve
