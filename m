Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7886819AC15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 14:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbgDAMxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 08:53:19 -0400
Received: from ozlabs.org ([203.11.71.1]:35845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDAMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMX3rdHz9sTF; Wed,  1 Apr 2020 23:53:12 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 41b8426fdb59218f56a6e3b3facd43a82816e3eb
In-Reply-To: <20200215053637.280880-1-leonardo@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, desnesn@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] powerpc/cputable: Remove unnecessary copy of cpu_spec->oprofile_type
Message-Id: <48smMX3rdHz9sTF@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:12 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-15 at 05:36:37 UTC, Leonardo Bras wrote:
> Before checking for cpu_type == NULL, this same copy happens, so doing
> it here will just write the same value to the t->oprofile_type
> again.
> 
> Remove the repeated copy, as it is unnecessary.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/41b8426fdb59218f56a6e3b3facd43a82816e3eb

cheers
