Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE80158917
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBKEDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 23:03:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728004AbgBKEDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 23:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581393785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQwP5yBQiPBYF1dt476zTOkcra/qaHWjGFa0BnYAY9Y=;
        b=S387MwabuRkNC4AH8yjImNeQ57YdR1JU0AcRme3vGdPrAQaH+u8DrhqRTFcV7ncz5RqF5d
        YRX24vaT9Anurp6iO4QDBuVT0eNhDBnxACN/dxQuqOfw5Tl9pPaDUr+M0TR4ul1R5BcEvl
        9001ulGuBRVAjB/KZk8dpk7x1oT0hsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-kMVZNqVNOdyeGT4OBNfS1Q-1; Mon, 10 Feb 2020 23:03:02 -0500
X-MC-Unique: kMVZNqVNOdyeGT4OBNfS1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1F418A8C81;
        Tue, 11 Feb 2020 04:03:00 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD54589F24;
        Tue, 11 Feb 2020 04:02:51 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
Date:   Tue, 11 Feb 2020 12:02:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>
> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>
>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>
>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
>>> virtio over mmio devices as a lightweight machine model for modern
>>> cloud. The standard virtio over MMIO transport layer only supports on=
e
>>> legacy interrupt, which is much heavier than virtio over PCI transpor=
t
>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>> specific
>>> VMExits in following cases, which would considerably slow down the
>>> performance:
>>>
>>> 1) read interrupt status register
>>> 2) update interrupt status register
>>> 3) write IOAPIC EOI register
>>>
>>> We proposed to add MSI support for virtio over MMIO via new feature
>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>
>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>> Bit 1 is 0: device uses non-sharing and fixed vector per event mappin=
g.
>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>
>>
>> I believe dynamic mapping should cover the case of fixed vector?
>>
> Actually this bit *aims* for msi sharing or msi non-sharing.
>
> It means, when msi sharing bit is 1, device doesn't want vector per que=
ue
>
> (it wants msi vector sharing as name) and doesn't want a high=20
> interrupt rate.
>
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>
> So they are opposite not superset.
>
> Thanks!
>
> Jing


I think you need add more comments on the command.

E.g if I want to map vector 0 to queue 1, how do I need to do?

write(1, queue_sel);
write(0, vector_sel);

?

Thanks


>
>
>> Thanks
>>
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>

