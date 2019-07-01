Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF358FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 03:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfF1BhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 21:37:02 -0400
Received: from ozlabs.org ([203.11.71.1]:35853 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfF1BhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:37:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45ZfWb3Br6z9s7h;
        Fri, 28 Jun 2019 11:36:58 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount: Fix spurious mcount entries on powerpc
In-Reply-To: <20190627091739.15a51a35@gandalf.local.home>
References: <20190626183801.31247-1-naveen.n.rao@linux.vnet.ibm.com> <8736jvtvvg.fsf@concordia.ellerman.id.au> <20190627091739.15a51a35@gandalf.local.home>
Date:   Fri, 28 Jun 2019 11:36:58 +1000
Message-ID: <87zhm2sd6t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Thu, 27 Jun 2019 15:55:47 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Steve are you OK if I merge this via the powerpc tree? I'll reword the
>> commit message so that it makes sense coming prior to the commit
>> mentioned above.
>
> Yes, please add:
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks.

cheers
