Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD7A41588A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 04:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBKDRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 22:17:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48027 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727530AbgBKDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581391072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Nf36Pd4q2AVY4oKU24K8vx0+ORsf2vbbJBRG1witbM=;
        b=bwAyrzreQ8Yql56DYVIgWJokv1j48Pp1ppTjbDShUnb1/NvV/ydmZeAt63DhLsg956roKE
        QEL7UNOZx1GA2cFjbY2WeFPrLo7onnu+bOlUrxCgWOUqkPCRu4mRW5+7Hx5RpFoQycaw+H
        wkS2fCuzUFWKdJsZ/5UgQgcr6A7mL7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ryGiD3WYO_iQ5R0AcXlykw-1; Mon, 10 Feb 2020 22:17:48 -0500
X-MC-Unique: ryGiD3WYO_iQ5R0AcXlykw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72832184AEB0;
        Tue, 11 Feb 2020 03:17:47 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 859ED83861;
        Tue, 11 Feb 2020 03:17:39 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt feature support
To:     Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com,
        jing2.liu@linux.intel.com, qemu-devel@nongnu.org,
        chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
Date:   Tue, 11 Feb 2020 11:17:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
> From: Liu Jiang<gerry@linux.alibaba.com>
>
> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
> virtio over mmio devices as a lightweight machine model for modern
> cloud. The standard virtio over MMIO transport layer only supports one
> legacy interrupt, which is much heavier than virtio over PCI transport
> layer using MSI. Legacy interrupt has long work path and causes specifi=
c
> VMExits in following cases, which would considerably slow down the
> performance:
>
> 1) read interrupt status register
> 2) update interrupt status register
> 3) write IOAPIC EOI register
>
> We proposed to add MSI support for virtio over MMIO via new feature
> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>
> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
> uses msi_sharing[1] to indicate the event and vector mapping.
> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
> Bit 1 is 1: device uses sharing mode and dynamic mapping.


I believe dynamic mapping should cover the case of fixed vector?

Thanks


