Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28C01D3406
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2019 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfJJWjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 18:39:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:33890 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJJWjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:39:07 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A30A02BD;
        Thu, 10 Oct 2019 22:39:06 +0000 (UTC)
Date:   Thu, 10 Oct 2019 16:39:05 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: misc: xilinx_sdfec: Actually add documentation
Message-ID: <20191010163905.70a4d6e1@lwn.net>
In-Reply-To: <201910101535.1804FC6@keescook>
References: <201910021000.5E421A6F8F@keescook>
        <201910101535.1804FC6@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 15:35:41 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Wed, Oct 02, 2019 at 10:03:55AM -0700, Kees Cook wrote:
> > From: Derek Kiernan <derek.kiernan@xilinx.com>
> > 
> > Add SD-FEC driver documentation.
> > 
> > Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
> > Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
> > Link: https://lore.kernel.org/r/1560274185-264438-11-git-send-email-dragan.cvetic@xilinx.com
> > [kees: extracted from v7 as it was missing in the commit for v8]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > As mentioned[1], this file went missing and causes a warning in ReST
> > parsing, so I've extracted the patch and am sending it directly to Jon.
> > [1] https://lore.kernel.org/lkml/201909231450.4C6CF32@keescook/
> > ---  
> 
> friendly ping! :)
> 
> -Kees

It's sitting in my queue.  I was hoping to hear from Derek that it was OK
to add...Derek are you out there?

Thanks,

jon
