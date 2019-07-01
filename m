Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB39D151F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2019 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfEFQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 May 2019 12:53:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:46602 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEFQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:53:40 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x46GrE4M001810;
        Mon, 6 May 2019 11:53:14 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x46GrEon001809;
        Mon, 6 May 2019 11:53:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 6 May 2019 11:53:14 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, Scott Wood <oss@buserror.net>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Remove memory clobber asm constraint on dcbX() functions
Message-ID: <20190506165314.GC8599@gate.crashing.org>
References: <20180109065759.4E54B6C73D@localhost.localdomain> <e482662f-254c-4ab7-b0a8-966a3159d705@c-s.fr> <20190503181508.GQ8599@gate.crashing.org> <c2391ff5-ae01-5a3c-ad87-9cbda82b36ab@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2391ff5-ae01-5a3c-ad87-9cbda82b36ab@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, May 06, 2019 at 04:31:38PM +0000, Christophe Leroy wrote:
> However, I've tried your suggestion below and get unnexpected result.

> >you can do
> >
> >	__asm__ __volatile__ ("dcbf %0" : : "Z"(addr) : "memory");
> >
> >to save some insns here and there. ]

This should be "dcbf %y0".  Sorry.  And not addr -- it needs a mem there,
so deref addr as usual.


Segher
