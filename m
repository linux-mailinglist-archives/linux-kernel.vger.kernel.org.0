Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57BD100C63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKRTsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 14:48:01 -0500
Received: from ms.lwn.net ([45.79.88.28]:60632 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfKRTsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:48:01 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B259C9A8;
        Mon, 18 Nov 2019 19:48:00 +0000 (UTC)
Date:   Mon, 18 Nov 2019 12:47:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: Add request_irq() documentation
Message-ID: <20191118124759.5096a15f@lwn.net>
In-Reply-To: <alpine.DEB.2.21.1911151922430.28787@nanos.tec.linutronix.de>
References: <20191004163955.14419-1-corbet@lwn.net>
        <20191004163955.14419-3-corbet@lwn.net>
        <alpine.DEB.2.21.1911151922430.28787@nanos.tec.linutronix.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 19:23:29 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 4 Oct 2019, Jonathan Corbet wrote:
> 
> > While checking the results of the :c:func: removal, I noticed that there
> > was no documentation for request_irq(), and request_threaded_irq() was not
> > mentioned at all.  Add a kerneldoc comment for request_irq() and add
> > request_threaded_irq() to the list of functions.
> > 
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>  

Heh...I'd forgotten about this one...

> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks, I'll go ahead and apply it.

jon
