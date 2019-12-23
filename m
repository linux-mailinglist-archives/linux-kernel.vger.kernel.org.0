Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9FAE12974A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 15:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfLWOZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 09:25:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726763AbfLWOZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577111147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nTyEDFusLKumYW0h03qshyTMkbaeVnlSIDHnGUWtv+s=;
        b=VhXXQ7VWfTY1g5I5vAvKSVfaf07BwiCpmrL4/vV/o8Kjc6qAkwlVRzG0e/yT9+5m1XruQL
        fPc7h43StF4Urk9HB6TAdYDQ73q0jmQHOPoqizpKxLGY800HzT4+xN8ZlKHOB4++KJGd7x
        rWry44MErpple9KQVrkpA69WXvhPBCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-eooe5S9dObea5djAYhn2sA-1; Mon, 23 Dec 2019 09:25:43 -0500
X-MC-Unique: eooe5S9dObea5djAYhn2sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D36A11005502;
        Mon, 23 Dec 2019 14:25:41 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E7860BF4;
        Mon, 23 Dec 2019 14:25:37 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm/arm64: vgic: Handle GICR_PENDBASER.PTZ filed as
 RAZ
From:   Auger Eric <eric.auger@redhat.com>
To:     Zenghui Yu <yuzenghui@huawei.com>, maz@kernel.org
Cc:     andre.przywara@arm.com, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <20191220111833.1422-1-yuzenghui@huawei.com>
 <3a729559-d0eb-e042-d6bd-b69bacb0dd23@huawei.com>
 <fd6ec914-0940-a4bd-fc06-f1c211eba5ee@redhat.com>
Message-ID: <4817b05f-1822-7fc7-99a5-e7d5deae1055@redhat.com>
Date:   Mon, 23 Dec 2019 15:25:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fd6ec914-0940-a4bd-fc06-f1c211eba5ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui, Marc,
On 12/23/19 3:19 PM, Auger Eric wrote:
> Hi Zenghui,
>=20
> On 12/23/19 2:43 PM, Zenghui Yu wrote:
>> On 2019/12/20 19:18, Zenghui Yu wrote:
>>> Although guest will hardly read and use the PTZ (Pending Table Zero)
>>> bit in GICR_PENDBASER, let us emulate the architecture strictly.
>>> As per IHI 0069E 9.11.30, PTZ field is WO, and reads as 0.
>>>
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>>
>>> Noticed when checking all fields of GICR_PENDBASER register.
>>> But _not_ sure whether it's worth a fix, as Linux never sets
>>> the PTZ bit before enabling LPI (set GICR_CTLR_ENABLE_LPIS).
>>>
>>> And I wonder under which scenarios can this bit be written as 1.
>>> It seems difficult for software to determine whether the pending
>>> table contains all zeros when writing this bit.
>>>
>>> =C2=A0 virt/kvm/arm/vgic/vgic-mmio-v3.c | 5 ++++-
>>> =C2=A0 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> index 7dfd15dbb308..ebc218840fc2 100644
>>> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
>>> @@ -414,8 +414,11 @@ static unsigned long
>>> vgic_mmio_read_pendbase(struct kvm_vcpu *vcpu,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 gpa_t addr, unsigned int len)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vgic_cpu *vgic_cpu =3D &vcpu->a=
rch.vgic_cpu;
>>> +=C2=A0=C2=A0=C2=A0 u64 value =3D vgic_cpu->pendbaser;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return extract_bytes(vgic_cpu->pendbaser, =
addr & 7, len);
>>> +=C2=A0=C2=A0=C2=A0 value &=3D ~GICR_PENDBASER_PTZ;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return extract_bytes(value, addr & 7, len);
>>> =C2=A0 }
>>> =C2=A0 =C2=A0 static void vgic_mmio_write_pendbase(struct kvm_vcpu *v=
cpu,
>>>
>>
>> I noticed there is no userspace access callbacks for GICR_PENDBASER,
>> so this patch will make the PTZ field also 'Read As Zero' by userspace=
.
>> Should we consider adding a uaccess_read callback for GICR_PENDBASER
>> which just returns the unchanged vgic_cpu->pendbaser to userspace?
>> (Though this is really not a big deal. We now always emulate the PTZ
>> field to guest as RAZ. And 'vgic_cpu->pendbaser & GICR_PENDBASER_PTZ'
>> only indicates whether KVM will optimize the LPI enabling process,
>> where Read As Zero indicates never optimize..)
> You're right. If we start a migration when the PTZ has just been set by
> the SW, then we will miss it on the destination side.
>=20
> So for instance in the last KVM unit test of my series
> (https://lore.kernel.org/kvmarm/20191216140235.10751-17-eric.auger@redh=
at.com/),
> in test_its_pending_migration(), if you kick the migration before
> enabling LPI's at redist level, you shouldn't see any LPI hitting on th=
e
> target which is theoretically wrong. So implementing a uaccess_read()
> would be better I think.
>=20
> Thanks
>=20
> Eric
>=20
> +	ptr =3D gicv3_data.redist_base[nr_cpus - 1] + GICR_PENDBASER;
> +	pendbaser =3D readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
> +
> +	ptr =3D gicv3_data.redist_base[nr_cpus - 2] + GICR_PENDBASER;
> +	pendbaser =3D readq(ptr);
> +	writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
That's a clear actually. So Marc is right, forget what I have just said.
This will work on destination size as we will write 0.

Sorry for the noise

Hopefully Christmas break is coming ;-)

Best Regards

Eric
>=20
> +	puts("Now migrate the VM, then press a key to continue...\n");
> +	(void)getchar();
> +	report(true, "Migration complete");
> +
> +	gicv3_rdist_ctrl_lpi(nr_cpus - 1, true);
> +	gicv3_rdist_ctrl_lpi(nr_cpus - 2, true);
> +
>>
>>
>> Thanks,
>> Zenghui
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>

