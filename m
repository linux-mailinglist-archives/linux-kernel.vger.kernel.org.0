Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067E5175163
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 01:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCBAgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Mar 2020 19:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgCBAgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:36:51 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6391246B7;
        Mon,  2 Mar 2020 00:36:50 +0000 (UTC)
Date:   Sun, 1 Mar 2020 19:36:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] trace: Export anonymous tracing
Message-ID: <20200301193649.71da6747@oasis.local.home>
In-Reply-To: <158310134594.5508.5362429296192213548@skylake-alporthouse-com>
References: <20200301155248.4132645-1-chris@chris-wilson.co.uk>
        <20200301131816.277dd398@oasis.local.home>
        <158310134594.5508.5362429296192213548@skylake-alporthouse-com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Mar 2020 22:22:25 +0000
Chris Wilson <chris@chris-wilson.co.uk> wrote:

> > I'm curious to why we need it to be anonymous. Why not allow them to be
> > visible from the tracing directory. This could allow for easier
> > debugging. Note, the trace instances have ref counters thus they can't
> > be removed if something has a reference to it.  
> 
> Do you really want a few thousand (or even tens) i915-client-%d? That
> does not particularly seem like it adds ease-of-use, and would need to be
> restricted to the client [or root]. The intent is for the client to have
> a private channel for detailed debug/error reporting of its own calls
> into the kernel.

Wow! I didn't expect this to have that many anonymous users. What is
the use case for again?

-- Steve
