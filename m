Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEB180453
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:05:56 -0400
Received: from ms.lwn.net ([45.79.88.28]:43944 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCJRF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:05:56 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DF53C537;
        Tue, 10 Mar 2020 17:05:55 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:05:54 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        swood@redhat.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, mingo@kernel.org, kernel@gpiccoli.net
Subject: Re: [PATCH] Documentation: Better document the softlockup_panic
 sysctl
Message-ID: <20200310110554.1fc016ad@lwn.net>
In-Reply-To: <20200310151503.11589-1-gpiccoli@canonical.com>
References: <20200310151503.11589-1-gpiccoli@canonical.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 12:15:03 -0300
"Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:

> Commit 9c44bc03fff4 ("softlockup: allow panic on lockup") added the
> softlockup_panic sysctl, but didn't add information about it to the file
> Documentation/admin-guide/sysctl/kernel.rst (which in that time certainly
> wasn't rst and had other name!).
> 
> This patch just adds the respective documentation and references it from
> the corresponding entry in Documentation/admin-guide/kernel-parameters.txt.
> 
> This patch was strongly based on Scott Wood's commit d22881dc13b6
> ("Documentation: Better document the hardlockup_panic sysctl").
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

So this doesn't even come close to applying; could you respin it against
docs-next, please?

>  Documentation/admin-guide/kernel-parameters.txt |  6 +++---
>  Documentation/admin-guide/sysctl/kernel.rst     | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..adf77ead02c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4515,9 +4515,9 @@
>  
>  			A nonzero value instructs the soft-lockup detector
>  			to panic the machine when a soft-lockup occurs. This
> -			is also controlled by CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC
> -			which is the respective build-time switch to that
> -			functionality.
> +			is also controlled by kernel.softlockup_panic sysctl

..and while you're at it, make it "*the* kernel.softlockup_panic sysctl" :)

Thanks,

jon
