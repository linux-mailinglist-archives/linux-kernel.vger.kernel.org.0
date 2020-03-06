Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF617B2E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Mar 2020 01:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCFA14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 19:27:56 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgCFA1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:48 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3Q5BwTz9sSr; Fri,  6 Mar 2020 11:27:46 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 860286cf33963fa8a0fe542995bdec2df5cb3abb
In-Reply-To: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH 1/6] powerpc: kernel: no need to check return value of debugfs_create functions
Message-Id: <48YT3Q5BwTz9sSr@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:46 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-09 at 10:58:56 UTC, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/860286cf33963fa8a0fe542995bdec2df5cb3abb

cheers
