Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD3151A42
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 13:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBDMDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 07:03:20 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:46937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgBDMDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:03:20 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48BjyF4dRPzB3ww; Tue,  4 Feb 2020 23:03:17 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6ec20aa2e510b6297906c45f009aa08b2d97269a
In-Reply-To: <f48244e9485ada0a304ed33ccbb8da271180c80d.1579866752.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] powerpc/32s: Fix bad_kuap_fault()
Message-Id: <48BjyF4dRPzB3ww@ozlabs.org>
Date:   Tue,  4 Feb 2020 23:03:17 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-24 at 11:54:40 UTC, Christophe Leroy wrote:
> At the moment, bad_kuap_fault() reports a fault only if a bad access
> to userspace occurred while access to userspace was not granted.
> 
> But if a fault occurs for a write outside the allowed userspace
> segment(s) that have been unlocked, bad_kuap_fault() fails to
> detect it and the kernel loops forever in do_page_fault().
> 
> Fix it by checking that the accessed address is within the allowed
> range.
> 
> Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
> Cc: stable@vger.kernel.org # v5.2+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://lore.kernel.org/r/1e07c7de4ffdd9cda35d1ffe8258af75579d3e91.1579715466.git.christophe.leroy@c-s.fr

Patches 2-7 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6ec20aa2e510b6297906c45f009aa08b2d97269a

cheers
