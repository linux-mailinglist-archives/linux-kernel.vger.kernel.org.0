Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60DF6DBB3A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2019 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407144AbfJRBKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 21:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392283AbfJRBKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 21:10:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A912420820;
        Fri, 18 Oct 2019 01:10:23 +0000 (UTC)
Date:   Thu, 17 Oct 2019 21:10:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH 4/4] parport: daisy: use new parport device model
Message-ID: <20191017211022.4247d821@gandalf.local.home>
In-Reply-To: <20191016144540.18810-4-sudipm.mukherjee@gmail.com>
References: <20191016144540.18810-1-sudipm.mukherjee@gmail.com>
        <20191016144540.18810-4-sudipm.mukherjee@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 15:45:40 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Modify parport daisy driver to use the new parallel port device model.
> 
> Last attempt was '1aec4211204d ("parport: daisy: use new parport device
> model")' which failed as daisy was also trying to load the low level
> driver and that resulted in a deadlock.
> 
> Cc: Michal Kubecek <mkubecek@suse.cz>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> Steven, Michal,
> Can you please test this series in your test environment and verify that
> I am not breaking anything this time.
> 
>

I checked out 1aec4211204d~1 (just before the broken commit), and
applied these four patches. It booted with the config that wouldn't
boot with the broken commit.

Tested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
