Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BFCA7AB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2019 07:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfIDF0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Sep 2019 01:26:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbfIDF0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 01:26:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x845NTFO106483
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 01:26:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ut5vw20uc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 01:26:07 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 4 Sep 2019 06:26:04 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 06:26:00 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x845PxUO27197504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 05:25:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF7115204F;
        Wed,  4 Sep 2019 05:25:59 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1DA5152052;
        Wed,  4 Sep 2019 05:25:59 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B77E2A0147;
        Wed,  4 Sep 2019 15:25:55 +1000 (AEST)
Subject: Re: [PATCH] powerpc: Perform a bounds check in arch_add_memory
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 15:25:55 +1000
In-Reply-To: <5ce9f700-8e70-c669-32fa-9598a01eb8ba@redhat.com>
References: <20190827052047.31547-1-alastair@au1.ibm.com>
         <20190827062844.GQ7538@dhcp22.suse.cz>
         <ea9e43fff6b6531af0620f9df62e015af66d4535.camel@au1.ibm.com>
         <1f2d967a-57a1-d3a3-4eb7-306b43709fee@redhat.com>
         <7e8e34ece6386bd3b0703f218a3b4688c83886d7.camel@au1.ibm.com>
         <5ce9f700-8e70-c669-32fa-9598a01eb8ba@redhat.com>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090405-4275-0000-0000-00000360DDD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090405-4276-0000-0000-00003873218D
Message-Id: <6823c187257b5033bca8905dda17b6c79a4944a6.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-04_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-02 at 09:28 +0200, David Hildenbrand wrote:
> On 02.09.19 01:54, Alastair D'Silva wrote:
> > On Tue, 2019-08-27 at 09:13 +0200, David Hildenbrand wrote:
> > > On 27.08.19 08:39, Alastair D'Silva wrote:
> > > > On Tue, 2019-08-27 at 08:28 +0200, Michal Hocko wrote:
> > > > > On Tue 27-08-19 15:20:46, Alastair D'Silva wrote:
> > > > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > > > 
> > > > > > It is possible for firmware to allocate memory ranges
> > > > > > outside
> > > > > > the range of physical memory that we support
> > > > > > (MAX_PHYSMEM_BITS).
> > > > > 
> > > > > Doesn't that count as a FW bug? Do you have any evidence of
> > > > > that
> > > > > in
> > > > > the
> > > > > field? Just wondering...
> > > > > 
> > > > 
> > > > Not outside our lab, but OpenCAPI attached LPC memory is
> > > > assigned
> > > > addresses based on the slot/NPU it is connected to. These
> > > > addresses
> > > > prior to:
> > > > 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory
> > > > to
> > > > 2PB")
> > > > were inaccessible and resulted in bogus sections - see our
> > > > discussion
> > > > on 'mm: Trigger bug on if a section is not found in
> > > > __section_nr'.
> > > > Doing this check here was your suggestion :)
> > > > 
> > > > It's entirely possible that a similar problem will occur in the
> > > > future,
> > > > and it's cheap to guard against, which is why I've added this.
> > > > 
> > > 
> > > If you keep it here, I guess this should be wrapped by a
> > > WARN_ON_ONCE().
> > > 
> > > If we move it to common code (e.g., __add_pages() or
> > > add_memory()),
> > > then
> > > probably not. I can see that s390x allows to configure
> > > MAX_PHYSMEM_BITS,
> > > so the check could actually make sense.
> > > 
> > 
> > I couldn't see a nice platform indepedent way to determine the
> > allowable address range, but if there is, then I'll move this to
> > the
> > generic code instead.
> > 
> 
> At least on the !ZONE_DEVICE path we have
> 
> __add_memory() -> register_memory_resource() ...
> 
> return ERR_PTR(-E2BIG);
> 
> 
> I was thinking about something like
> 
> int add_pages()
> {
> 	if ((start + size - 1) >> MAX_PHYSMEM_BITS)
> 		return -E2BIG;	
> 
> 	return arch_add_memory(...)
> }
> 
> And switching users of arch_add_memory() to add_pages(). However, x86
> already has an add_pages() function, so that would need some more
> thought.
> 
> Maybe simply renaming the existing add_pages() to arch_add_pages().
> 
> add_pages(): Create virtual mapping
> __add_pages(): Don't create virtual mapping
> 
> arch_add_memory(): Arch backend for add_pages()
> arch_add_pages(): Arch backend for __add_pages()
> 
> It would be even more consistent if we would have arch_add_pages()
> vs.
> __arch_add_pages().

Looking a bit further, I think a good course of action would be to add
the check to memory_hotplug.c:check_hotplug_memory_range().

This would be the least invasive, and could check both
MAX_POSSIBLE_PHYSMEM_BITS and MAX_PHYSMEM_BITS.

With that in mind, we can drop this patch.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

