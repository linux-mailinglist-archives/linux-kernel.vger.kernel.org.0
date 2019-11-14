Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A774FC21D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 04:07:49 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfKNJHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 04:07:47 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 47DFxW5FGsz9sPh; Thu, 14 Nov 2019 20:07:43 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b948aaaf3e39cc475e45fea727638f191a5cb1b4
In-Reply-To: <20190802133914.30413-1-leonardo@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 1/1] powerpc/pseries/hotplug-memory.c: Change rc variable to bool
Message-Id: <47DFxW5FGsz9sPh@ozlabs.org>
Date:   Thu, 14 Nov 2019 20:07:42 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-02 at 13:39:15 UTC, Leonardo Bras wrote:
> Changes the return variable to bool (as the return value) and
> avoids doing a ternary operation before returning.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b948aaaf3e39cc475e45fea727638f191a5cb1b4

cheers
