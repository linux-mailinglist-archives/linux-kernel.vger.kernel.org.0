Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3FBFC22C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKNJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:08:23 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfKNJIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:08:21 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFy90198z9sSZ; Thu, 14 Nov 2019 20:08:16 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7d8212747435c534c8d564fbef4541a463c976ff
In-Reply-To: <20191031142933.10779-2-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     David Hildenbrand <david@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 01/12] powerpc/pseries: CMM: Implement release() function for sysfs device
Message-Id: <47DFy90198z9sSZ@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:08:16 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-31 at 14:29:22 UTC, David Hildenbrand wrote:
> When unloading the module, one gets
> [  548.188594] ------------[ cut here ]------------
> [  548.188596] Device 'cmm0' does not have a release() function, it is brok=
> en and must be fixed. See Documentation/kobject.txt.
> [  548.188622] WARNING: CPU: 0 PID: 19308 at drivers/base/core.c:1244 .devi=
> ce_release+0xcc/0xf0
> ...
> 
> We only have on static fake device. There is nothing to do when
> releasing the device (via cmm_exit).
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Allison Randal <allison@lohutok.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arun KS <arunks@codeaurora.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Patches 1-10 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7d8212747435c534c8d564fbef4541a463c976ff

cheers
