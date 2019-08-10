Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6988AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2019 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfHJKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Aug 2019 06:20:43 -0400
Received: from ozlabs.org ([203.11.71.1]:40149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfHJKUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 06:20:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 465J5r1JLQz9sNk; Sat, 10 Aug 2019 20:20:32 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9616dda1aaddb2080122aaeab96ad7fc064e36b4
In-Reply-To: <20190801225251.17864-1-leonardo@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Nathan Lynch <nathanl@linux.ibm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] pseries/hotplug-memory.c: Replace nested ifs by switch-case
Message-Id: <465J5r1JLQz9sNk@ozlabs.org>
Date:   Sat, 10 Aug 2019 20:20:32 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 22:52:51 UTC, Leonardo Bras wrote:
> I noticed these nested ifs can be easily replaced by switch-cases,
> which can improve readability.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9616dda1aaddb2080122aaeab96ad7fc064e36b4

cheers
