Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0860B9DE90
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2019 09:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfH0HSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 03:18:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:40460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbfH0HSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:18:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C36DBAF37;
        Tue, 27 Aug 2019 07:18:22 +0000 (UTC)
Date:   Tue, 27 Aug 2019 09:18:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Perform a bounds check in arch_add_memory
Message-ID: <20190827071821.GS7538@dhcp22.suse.cz>
References: <20190827052047.31547-1-alastair@au1.ibm.com>
 <20190827062844.GQ7538@dhcp22.suse.cz>
 <ea9e43fff6b6531af0620f9df62e015af66d4535.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea9e43fff6b6531af0620f9df62e015af66d4535.camel@au1.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-08-19 16:39:56, Alastair D'Silva wrote:
> On Tue, 2019-08-27 at 08:28 +0200, Michal Hocko wrote:
> > On Tue 27-08-19 15:20:46, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > It is possible for firmware to allocate memory ranges outside
> > > the range of physical memory that we support (MAX_PHYSMEM_BITS).
> > 
> > Doesn't that count as a FW bug? Do you have any evidence of that in
> > the
> > field? Just wondering...
> > 
> 
> Not outside our lab, but OpenCAPI attached LPC memory is assigned
> addresses based on the slot/NPU it is connected to. These addresses
> prior to:
> 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2PB")
> were inaccessible and resulted in bogus sections - see our discussion
> on 'mm: Trigger bug on if a section is not found in __section_nr'.

Please document this in the changelog

-- 
Michal Hocko
SUSE Labs
