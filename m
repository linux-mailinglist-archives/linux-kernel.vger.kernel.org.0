Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1564F133EBE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jan 2020 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgAHJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 04:58:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43455 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgAHJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578477504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sycsqZJGVnQw+EqUeY+kh0XYMo8ue/f6Kld1hcvxz8=;
        b=d7bDlf641fthW2KYfWr2bq1BONQGNJNoc9gJ3j6jAMT2VZEhUzvXlkfHwvB1Y3CjGxKBzw
        lc51ch227gYJeOf6iT+/oxuYUL0XXbLr+LSg5coWHRZmiJCQS4i5vDZbUN4HjJuWdaM8G7
        8p1nQ+9lejzQWrq6ALvJ0Vq3qed7CnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-Hy-c3osQPSqa5RsUENJZtg-1; Wed, 08 Jan 2020 04:58:23 -0500
X-MC-Unique: Hy-c3osQPSqa5RsUENJZtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15834800D54;
        Wed,  8 Jan 2020 09:58:22 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D59E5C241;
        Wed,  8 Jan 2020 09:58:17 +0000 (UTC)
Subject: Re: discuss about pvpanic
To:     Paolo Bonzini <pbonzini@redhat.com>,
        zhenwei pi <pizhenwei@bytedance.com>
Cc:     "yelu@bytedance.com" <yelu@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        "libvir-list@redhat.com" <libvir-list@redhat.com>
References: <2feff896-21fe-2bbe-6f68-9edfb476a110@bytedance.com>
 <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
From:   Michal Privoznik <mprivozn@redhat.com>
Message-ID: <d0c57f84-a25c-9984-560b-2419807444e1@redhat.com>
Date:   Wed, 8 Jan 2020 10:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <dd8e46c4-eac4-046a-82ec-7ae17df75035@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/20 10:36 AM, Paolo Bonzini wrote:
> On 08/01/20 09:25, zhenwei pi wrote:
>> Hey, Paolo
>>
>> Currently, pvpapic only supports bit 0(PVPANIC_PANICKED).
>> We usually expect that guest writes ioport (typical 0x505) in panic_notifier_list callback
>> during handling panic, then we can handle pvpapic event PVPANIC_PANICKED in QEMU.
>>
>> On the other hand, guest wants to handle the crash by kdump-tools, and reboots without any
>> panic_notifier_list callback. So QEMU only knows that guest has rebooted (because guest
>> write 0xcf9 ioport for RCR request), but QEMU can't identify why guest resets.
>>
>> In production environment, we hit about 100+ guest reboot event everyday, sadly we
>> can't separate the abnormal reboot from normal operation.
>>
>> We want to add a new bit for pvpanic event(maybe PVPANIC_CRASHLOADED) to represent the guest has crashed,
>> and the panic is handled by the guest kernel. (here is the previous patch https://lkml.org/lkml/2019/12/14/265)
>>
>> What do you think about this solution? Or do you have any other suggestions?
> 
> Hi Zhenwei,
> 
> the kernel-side patch certainly makes sense.  I assume that you want the
> event to propagate up from QEMU to Libvirt and so on?  The QEMU patch
> would need to declare a new event (qapi/misc.json) and send it in
> handle_event (hw/misc/pvpanic.c).  For Libvirt I'm not familiar, so I'm
> adding the respective list.

Adding an event is fairly easy, if everything you want libvirt to do is 
report the event to upper layers. I volunteer to do it. Question is, how 
qemu is going to report this, whether some attributes to GUEST_PANICKED 
event or some new event. But more important is to merge the change into 
kernel.

Michal

