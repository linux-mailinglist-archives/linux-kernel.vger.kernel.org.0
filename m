Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3126FC21E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:07:52 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfKNJHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxb485gz9sR5; Thu, 14 Nov 2019 20:07:47 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 42484d2c0f82b666292faf6668c77b49a3a04bc0
In-Reply-To: <20190912194633.12045-1-msuchanek@suse.de>
To:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/perf: remove current_is_64bit()
Message-Id: <47DFxb485gz9sR5@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:47 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 19:46:33 UTC, Michal Suchanek wrote:
> Since commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> current_is_64bit() is quivalent to !is_32bit_task().
> Remove the redundant function.
> 
> Link: https://github.com/linuxppc/issues/issues/275
> Link: https://lkml.org/lkml/2019/9/12/540
> 
> Fixes: linuxppc#275
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/42484d2c0f82b666292faf6668c77b49a3a04bc0

cheers
