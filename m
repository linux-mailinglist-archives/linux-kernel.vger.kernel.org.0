Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D169311DB13
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfLMAXH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Dec 2019 19:23:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731360AbfLMAXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 19:23:07 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBD0JgDF119409;
        Thu, 12 Dec 2019 19:22:25 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t7qknq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 19:22:25 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBD0MOvs129272;
        Thu, 12 Dec 2019 19:22:24 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wu4t7qkna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 19:22:24 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBD0KENL011326;
        Fri, 13 Dec 2019 00:22:24 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02wdc.us.ibm.com with ESMTP id 2wr3q72gsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 00:22:24 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBD0MMDR47251960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 00:22:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE83D6E04C;
        Fri, 13 Dec 2019 00:22:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A73D46E054;
        Fri, 13 Dec 2019 00:22:22 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 13 Dec 2019 00:22:22 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, Ram Pai <linuxram@us.ibm.com>
From:   Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <ad63a352-bdec-08a8-2fd0-f64b9579da6c@ozlabs.ru>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        paulus@ozlabs.org, hch@lst.de, andmike@us.ibm.com,
        sukadev@linux.vnet.ibm.com, mst@redhat.com, ram.n.pai@gmail.com,
        cai@lca.pw, tglx@linutronix.de, bauerman@linux.ibm.com,
        linux-kernel@vger.kernel.org, leonardo@linux.ibm.com
References: <1575681159-30356-1-git-send-email-linuxram@us.ibm.com>
 <1575681159-30356-2-git-send-email-linuxram@us.ibm.com>
 <ed0f048c-bb40-c6c6-887c-ef68c9e411a2@ozlabs.ru>
 <20191210051244.GB5702@oc0525413822.ibm.com>
 <c4b48f55-e4e3-222a-0aa0-9b4783e19584@ozlabs.ru>
 <20191210153542.GB5709@oc0525413822.ibm.com>
 <90f6019b-d756-7f33-21b0-bb49c1c842da@ozlabs.ru>
 <157609629270.3810.9676234389583169255@sif>
 <ad63a352-bdec-08a8-2fd0-f64b9579da6c@ozlabs.ru>
Message-ID: <157619653837.3810.9657617422595030033@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] powerpc/pseries/iommu: Share the per-cpu TCE page with
 the hypervisor.
Date:   Thu, 12 Dec 2019 18:22:18 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=8
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexey Kardashevskiy (2019-12-11 16:47:30)
> 
> 
> On 12/12/2019 07:31, Michael Roth wrote:
> > Quoting Alexey Kardashevskiy (2019-12-11 02:15:44)
> >>
> >>
> >> On 11/12/2019 02:35, Ram Pai wrote:
> >>> On Tue, Dec 10, 2019 at 04:32:10PM +1100, Alexey Kardashevskiy wrote:
> >>>>
> >>>>
> >>>> On 10/12/2019 16:12, Ram Pai wrote:
> >>>>> On Tue, Dec 10, 2019 at 02:07:36PM +1100, Alexey Kardashevskiy wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 07/12/2019 12:12, Ram Pai wrote:
> >>>>>>> H_PUT_TCE_INDIRECT hcall uses a page filled with TCE entries, as one of
> >>>>>>> its parameters.  On secure VMs, hypervisor cannot access the contents of
> >>>>>>> this page since it gets encrypted.  Hence share the page with the
> >>>>>>> hypervisor, and unshare when done.
> >>>>>>
> >>>>>>
> >>>>>> I thought the idea was to use H_PUT_TCE and avoid sharing any extra
> >>>>>> pages. There is small problem that when DDW is enabled,
> >>>>>> FW_FEATURE_MULTITCE is ignored (easy to fix); I also noticed complains
> >>>>>> about the performance on slack but this is caused by initial cleanup of
> >>>>>> the default TCE window (which we do not use anyway) and to battle this
> >>>>>> we can simply reduce its size by adding
> >>>>>
> >>>>> something that takes hardly any time with H_PUT_TCE_INDIRECT,  takes
> >>>>> 13secs per device for H_PUT_TCE approach, during boot. This is with a
> >>>>> 30GB guest. With larger guest, the time will further detoriate.
> >>>>
> >>>>
> >>>> No it will not, I checked. The time is the same for 2GB and 32GB guests-
> >>>> the delay is caused by clearing the small DMA window which is small by
> >>>> the space mapped (1GB) but quite huge in TCEs as it uses 4K pages; and
> >>>> for DDW window + emulated devices the IOMMU page size will be 2M/16M/1G
> >>>> (depends on the system) so the number of TCEs is much smaller.
> >>>
> >>> I cant get your results.  What changes did you make to get it?
> >>
> >>
> >> Get what? I passed "-m 2G" and "-m 32G", got the same time - 13s spent
> >> in clearing the default window and the huge window took a fraction of a
> >> second to create and map.
> > 
> > Is this if we disable FW_FEATURE_MULTITCE in the guest and force the use
> > of H_PUT_TCE everywhere?
> 
> 
> Yes. Well, for the DDW case FW_FEATURE_MULTITCE is ignored but even when
> fixed (I have it in my local branch), this does not make a difference.
> 
> 
> > 
> > In theory couldn't we leave FW_FEATURE_MULTITCE in place so that
> > iommu_table_clear() can still use H_STUFF_TCE (which I guess is basically
> > instant),
> 
> PAPR/LoPAPR "conveniently" do not describe what hcall-multi-tce does
> exactly. But I am pretty sure the idea is that either both H_STUFF_TCE
> and H_PUT_TCE_INDIRECT are present or neither.

That was my interpretation (or maybe I just went by what your
implementation did :), but just because they are available doesn't mean
the guest has to use them. I agree it's ugly to condition it on
is_secure_guest(), but to me that seems better than sharing memory
uncessarily, or potentially leaving stale mappings into default IOMMU.

Not sure if that are other alternatives though.

> 
> 
> > and then force H_PUT_TCE for new mappings via something like:
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 6ba081dd61c9..85d092baf17d 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -194,6 +194,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
> >         unsigned long flags;
> >  
> >         if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE)) {
> > +       if ((npages == 1) || !firmware_has_feature(FW_FEATURE_MULTITCE) || is_secure_guest()) {
> 
> 
> Nobody (including myself) seems to like the idea of having
> is_secure_guest() all over the place.
> 
> And with KVM acceleration enabled, it is pretty fast anyway. Just now we
> do not have H_PUT_TCE in KVM/UV for secure guests but we will have to
> fix this for secure PCI passhtrough anyway.
> 
> 
> >                 return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
> >                                            direction, attrs);
> >         }
> > 
> > That seems like it would avoid the extra 13s.
> 
> Or move around iommu_table_clear() which imho is just the right thing to do.
> 
> 
> > If we take the additional step of only mapping SWIOTLB range in
> > enable_ddw() for is_secure_guest() that might further improve things
> > (though the bigger motivation with that is the extra isolation it would
> > grant us for stuff behind the IOMMU, since it apparently doesn't affect
> > boot-time all that much)
> 
> 
> Sure, we just need to confirm how many of these swiotlb banks we are
> going to have (just one or many and at what location). Thanks,
> 
> 
> 
> > 
> >>
> >>
> >>>>>>
> >>>>>> -global
> >>>>>> spapr-pci-host-bridge.dma_win_size=0x4000000
> >>>>>
> >>>>> This option, speeds it up tremendously.  But than should this option be
> >>>>> enabled in qemu by default?  only for secure VMs? for both VMs?
> >>>>
> >>>>
> >>>> As discussed in slack, by default we do not need to clear the entire TCE
> >>>> table and we only have to map swiotlb buffer using the small window. It
> >>>> is a guest kernel change only. Thanks,
> >>>
> >>> Can you tell me what code you are talking about here.  Where is the TCE
> >>> table getting cleared? What code needs to be changed to not clear it?
> >>
> >>
> >> pci_dma_bus_setup_pSeriesLP()
> >>         iommu_init_table()
> >>                 iommu_table_clear()
> >>                         for () tbl->it_ops->get()
> >>
> >> We do not really need to clear it there, we only need it for VFIO with
> >> IOMMU SPAPR TCE v1 which reuses these tables but there are
> >> iommu_take_ownership/iommu_release_ownership to clear these tables. I'll
> >> send a patch for this.
> > 
> > 
> >>
> >>
> >>> Is the code in tce_buildmulti_pSeriesLP(), the one that does the clear
> >>> aswell?
> >>
> >>
> >> This one does not need to clear TCEs as this creates a window of known
> >> size and maps it all.
> >>
> >> Well, actually, it only maps actual guest RAM, if there are gaps in RAM,
> >> then TCEs for the gaps will have what hypervisor had there (which is
> >> zeroes, qemu/kvm clears it anyway).
> >>
> >>
> >>> But before I close, you have not told me clearly, what is the problem
> >>> with;  'share the page, make the H_PUT_INDIRECT_TCE hcall, unshare the page'.
> >>
> >> Between share and unshare you have a (tiny) window of opportunity to
> >> attack the guest. No, I do not know how exactly.
> >>
> >> For example, the hypervisor does a lot of PHB+PCI hotplug-unplug with
> >> 64bit devices - each time this will create a huge window which will
> >> share/unshare the same page.  No, I do not know how exactly how this can
> >> be exploited either, we cannot rely of what you or myself know today. My
> >> point is that we should not be sharing pages at all unless we really
> >> really have to, and this does not seem to be the case.
> >>
> >> But since this seems to an acceptable compromise anyway,
> >>
> >> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>
> >>
> >>
> >>
> >>
> >>> Remember this is the same page that is earmarked for doing
> >>> H_PUT_INDIRECT_TCE, not by my patch, but its already earmarked by the
> >>> existing code. So it not some random buffer that is picked. Second 
> >>> this page is temporarily shared and unshared, it does not stay shared
> >>> for life.  It does not slow the boot. it does not need any
> >>> special command line options on the qemu.
> >>>> Shared pages technology was put in place, exactly for the purpose of
> >>> sharing data with the hypervisor.  We are using this technology exactly
> >>> for that purpose.  And finally I agreed with your concern of having
> >>> shared pages staying around.  Hence i addressed that concern, by
> >>> unsharing the page.  At this point, I fail to understand your concern.
> >>
> >>
> >>
> >>
> >> -- 
> >> Alexey
> 
> -- 
> Alexey
