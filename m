Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4850BA8495
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 15:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfIDNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 09:35:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:38221 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730305AbfIDNfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 09:35:45 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x84DZ8EK027511;
        Wed, 4 Sep 2019 08:35:09 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x84DZ6Rj027508;
        Wed, 4 Sep 2019 08:35:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 4 Sep 2019 08:35:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, Qian Cai <cai@lca.pw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
Message-ID: <20190904133506.GO9749@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com> <20190903052407.16638-4-alastair@au1.ibm.com> <44b8223d-52d9-e932-4bb7-b7590ea11a03@c-s.fr> <c15c26963663b8de3102fd08df614fc5a8b3ecc2.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c15c26963663b8de3102fd08df614fc5a8b3ecc2.camel@au1.ibm.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 01:23:36PM +1000, Alastair D'Silva wrote:
> > Maybe also add "msr" in the clobbers.
> > 
> Ok.

There is no known register "msr" in GCC.


Segher
