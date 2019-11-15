Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29A81FE4EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2019 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfKOSXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Nov 2019 13:23:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfKOSXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:23:37 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVgFq-0005L4-VL; Fri, 15 Nov 2019 19:23:35 +0100
Date:   Fri, 15 Nov 2019 19:23:29 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>
cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: Add request_irq() documentation
In-Reply-To: <20191004163955.14419-3-corbet@lwn.net>
Message-ID: <alpine.DEB.2.21.1911151922430.28787@nanos.tec.linutronix.de>
References: <20191004163955.14419-1-corbet@lwn.net> <20191004163955.14419-3-corbet@lwn.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2019, Jonathan Corbet wrote:

> While checking the results of the :c:func: removal, I noticed that there
> was no documentation for request_irq(), and request_threaded_irq() was not
> mentioned at all.  Add a kerneldoc comment for request_irq() and add
> request_threaded_irq() to the list of functions.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Which reminds me that this documentation really needs some thorough
rewrite ...
