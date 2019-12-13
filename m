Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAA5C11E23B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2019 11:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLMKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 05:43:24 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:54434 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfLMKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:43:24 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifiPq-0003kl-75; Fri, 13 Dec 2019 11:43:22 +0100
To:     Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] KVM: arm/arm64: vgic-its: Fix restoration of unmapped  collections
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 13 Dec 2019 10:43:22 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <eric.auger.pro@gmail.com>, <linux-kernel@vger.kernel.org>,
        <kvmarm@lists.cs.columbia.edu>
In-Reply-To: <20191213094237.19627-1-eric.auger@redhat.com>
References: <20191213094237.19627-1-eric.auger@redhat.com>
Message-ID: <2634d1361ac3d5518b3bea62dc40ab06@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2019-12-13 09:42, Eric Auger wrote:
> Saving/restoring an unmapped collection is a valid scenario. For
> example this happens if a MAPTI command was sent, featuring an
> unmapped collection. At the moment the CTE fails to be restored.
> Only compare against the number of online vcpus if the rdist
> base is set.
>
> Cc: stable@vger.kernel.org # v4.11+
> Fixes: ea1ad53e1e31a ("KVM: arm64: vgic-its: Collection table 
> save/restore")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/virt/kvm/arm/vgic/vgic-its.c 
> b/virt/kvm/arm/vgic/vgic-its.c
> index 98c7360d9fb7..17920d1b350a 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -2475,7 +2475,8 @@ static int vgic_its_restore_cte(struct vgic_its
> *its, gpa_t gpa, int esz)
>  	target_addr = (u32)(val >> KVM_ITS_CTE_RDBASE_SHIFT);
>  	coll_id = val & KVM_ITS_CTE_ICID_MASK;
>
> -	if (target_addr >= atomic_read(&kvm->online_vcpus))
> +	if (target_addr != COLLECTION_NOT_MAPPED &&
> +	    target_addr >= atomic_read(&kvm->online_vcpus))
>  		return -EINVAL;
>
>  	collection = find_collection(its, coll_id);

Looks good to me. Out of curiosity, how was this spotted?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
