Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E28711CDC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 14:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbfLLNFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 08:05:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfLLNFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 08:05:42 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifO9z-0003rz-Vu; Thu, 12 Dec 2019 14:05:40 +0100
Date:   Thu, 12 Dec 2019 14:05:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
Message-ID: <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
References: <20191211232345.24810-1-robh@kernel.org>
 <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-11 17:48:54 [-0600], Rob Herring wrote:
> > -       if (phandle_cache) {
> > -               if (phandle_cache[masked_handle] &&
> > -                   handle == phandle_cache[masked_handle]->phandle)
> > -                       np = phandle_cache[masked_handle];
> > -               if (np && of_node_check_flag(np, OF_DETACHED)) {
> > -                       WARN_ON(1); /* did not uncache np on node removal */
> > -                       of_node_put(np);
> > -                       phandle_cache[masked_handle] = NULL;
> > -                       np = NULL;
> > -               }
> > +       if (phandle_cache[handle_hash] &&
> > +           handle == phandle_cache[handle_hash]->phandle)
> > +               np = phandle_cache[handle_hash];
> > +       if (np && of_node_check_flag(np, OF_DETACHED)) {
> > +               WARN_ON(1); /* did not uncache np on node removal */
> 
> BTW, I don't think this check is even valid. If we failed to detach
> and remove the node from the cache, then we could be accessing np
> after freeing it.

this is kmalloc()ed memory which is always valid. If the memory is
already re-used then
	handle == phandle_cache[handle_hash]->phandle

will fail (the check, not the memory access itself). If the check
remains valid then you can hope for the OF_DETACHED flag to trigger the
warning.

> Rob

Sebastian
