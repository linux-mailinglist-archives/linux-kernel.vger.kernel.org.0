Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D63159F93
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2020 04:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgBLDkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 22:40:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727602AbgBLDkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 22:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581478813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S1E0Z0wase8qOv1Belxsp5ny7Z5FV1upA2C64aN98yQ=;
        b=QiZXcQk8KQqFpS9K79aVdYfmyMyQ3kDb/zjJapiTElPD0h+hcqpTwCFYR7ELaEmvG1TXKN
        Fax1VffugEcO9Kv82DB94Oy/xmGW9zBe14X8fDl5jqwN0lIpnrstT6/4GfEe+0QNZMq0os
        epfc1Ja49kNPF4GF5YmBLqW9Ulb13OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-keUBMm_SOAKZuWyVQWB5tA-1; Tue, 11 Feb 2020 22:40:08 -0500
X-MC-Unique: keUBMm_SOAKZuWyVQWB5tA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481CC1005502;
        Wed, 12 Feb 2020 03:40:07 +0000 (UTC)
Received: from [10.72.13.111] (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8C0F8ED1B;
        Wed, 12 Feb 2020 03:39:56 +0000 (UTC)
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Zha Bin <zhabin@linux.alibaba.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, chao.p.peng@linux.intel.com,
        gerry@linux.alibaba.com
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
Date:   Wed, 12 Feb 2020 11:39:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200211062205-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
> On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
>> From: Liu Jiang<gerry@linux.alibaba.com>
>>
>> The standard virtio-mmio devices use notification register to signal
>> backend. This will cause vmexits and slow down the performance when we
>> passthrough the virtio-mmio devices to guest virtual machines.
>> We proposed to update virtio over MMIO spec to add the per-queue
>> notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
>> configure notify location for each queue.
>>
>> [1]https://lkml.org/lkml/2020/1/21/31
>>
>> Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
>> Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
>> Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
>> Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
>> Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
>> Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
>> Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> Hmm. Any way to make this static so we don't need
> base and multiplier?


E.g page per vq?

Thanks

