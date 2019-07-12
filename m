Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7A66490
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2019 04:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfGLCqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jul 2019 22:46:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbfGLCqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 22:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CE9lRDNR3rg1yz6aah5KMfonhpsYj2jNZxnH84MyUXA=; b=Wwvuit121V9ZexPPxKanwzYwi
        ddflUWN9v4CPX9+H9bPbsvo6jxG2wAC3BBUGG9cauFnrXCTSOlPmcxTfJ4cy1SoI/qV0rZFfQ8wXK
        twKXl0uRqWh6MZCEQ4HqlEM/PWywXXcbt23O50K/7l8UCi6eUz+0WWlTABE3X/EmQ8vMCNgrdJOUI
        XmrxItz1Xzoi+k4KF8fMeEEpmheizoVHxyVD+cHZm12cjh4pB42mf75Kc1mH4q1gaP9QIS4uoV1m1
        wCsORVvxaufFYS8GiSdvH5t76Q0DsCgP2JngRttI2f6/InFGOA/gWbNVKK/mNSfIwMK1nlVEdHuym
        hVorcePaw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hllYv-0001rK-Qf; Fri, 12 Jul 2019 02:45:29 +0000
Date:   Thu, 11 Jul 2019 19:45:29 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hoan Tran OS <hoan@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v2 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20190712024529.GU32320@bombadil.infradead.org>
References: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 11:25:44PM +0000, Hoan Tran OS wrote:
> In NUMA layout which nodes have memory ranges that span across other nodes,
> the mm driver can detect the memory node id incorrectly.
> 
> For example, with layout below
> Node 0 address: 0000 xxxx 0000 xxxx
> Node 1 address: xxxx 1111 xxxx 1111
> 
> Note:
>  - Memory from low to high
>  - 0/1: Node id
>  - x: Invalid memory of a node
> 
> When mm probes the memory map, without CONFIG_NODES_SPAN_OTHER_NODES
> config, mm only checks the memory validity but not the node id.
> Because of that, Node 1 also detects the memory from node 0 as below
> when it scans from the start address to the end address of node 1.
> 
> Node 0 address: 0000 xxxx xxxx xxxx
> Node 1 address: xxxx 1111 1111 1111
> 
> This layout could occur on any architecture. This patch enables
> CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA to fix this issue.

How do you know it could occur on any architecture?  Surely you should
just enable this for the architecture where you've noticed the problem.
