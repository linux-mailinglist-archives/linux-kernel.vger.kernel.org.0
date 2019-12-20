Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6D06127AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Dec 2019 13:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTMUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Dec 2019 07:20:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727211AbfLTMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576844453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIVo2crlVc/txi8VIButrgzZivg7HgIELD3HSqFbFMs=;
        b=crSTtJZ3qSuWo3CmlmEX84NAJP3zbQ8QEJ9khr1zVtc2wyGQ5u9Pl9qL9PQrw/1QM/rfJy
        AlXqEiqShI1pvyO2t0DhJOVzAr/VFk4kR4O6CeBu8R+kQd2P9ChcJrfwr5oN9dXEGVzlpZ
        KP1OZeHcIms2jjibVUtc5ELTbJ5auKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-KjExN_K5PJeZFLWaH5Dnig-1; Fri, 20 Dec 2019 07:20:46 -0500
X-MC-Unique: KjExN_K5PJeZFLWaH5Dnig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45DE7801E66;
        Fri, 20 Dec 2019 12:20:45 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 487485DA75;
        Fri, 20 Dec 2019 12:20:41 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
Cc:     andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20191220111833.1422-1-yuzenghui@huawei.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c469bc11-9cd0-531a-9bd3-46d070ec0e72@redhat.com>
Date:   Fri, 20 Dec 2019 13:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191220111833.1422-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/19 12:18 PM, Zenghui Yu wrote:
> Although guest will hardly read and use the PTZ (Pending Table Zero)
> bit in GICR_PENDBASER, let us emulate the architecture strictly.
> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
nit
s/filed/field in the commit title

Eric
> ---
> 
> Noticed when checking all fields of GICR_PENDBASER register.
> But _not_ sure whether it's worth a fix, as Linux never sets
> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
> 
> And I wonder under which scenarios can this bit be written as 1.
> It seems difficult for software to determine whether the pending
> table contains all zeros when writing this bit.
> 
>  virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> index 7dfd15dbb308..ebc218840fc2 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -414,8 +414,11 @@ static unsigned long vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>  					     gpa_t addr, unsigned int len)
>  {
>  	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
> +	u64 value = vgic_cpu->pendbaser;
>  
> -	return extract_bytes(vgic_cpu->pendbaser, addr & 7, len);
> +	value &= ~GICR_PENDBASER_PTZ;
> +
> +	return extract_bytes(value, addr & 7, len);
>  }
>  
>  static void vgic_mmio_write_pendbase(struct kvm_vcpu *vcpu,
> 

