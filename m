Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0326818325C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Mar 2020 15:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCLOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Mar 2020 10:06:16 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45790 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCLOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:06:15 -0400
Received: by mail-il1-f195.google.com with SMTP id p1so5537668ils.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
        b=zssgGwlH8/VmLMRtLhaCwqZbq9RREsK0T5bf6PIvtt1VGFFLfPPnQnZejqOTYcE66h
         YC0y2su0NF5zACw1HZZsr7rjtUkogTsWqTu6Vm6/ie+LuGi85xrZGApcNLASkl90rCNH
         N3iKNDAKYS9oq8i9IEow8BJeJKPxUsJrlebRdwIF5eJPTF0cAwRj9ggXLmAxIDhdEZuG
         PvnpPrEInwbqPNIjvL3PzflYawxDa3mZi2TgaKLvf7ECZzHSxJx3KAoa2ry7Pf7aKJ1S
         y7gpjNa2PHKgoNp0XyIc9HwCBIQjRNDXD+/sV+kacNjm7ivwd82D7IAXuee/0UJ8BEOm
         eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pji13eSFjIMldkU9BYdIbo4HI44T8oed33naqFgVd6s=;
        b=rQzng+XSHj2PiJgCQRj1db1jeZsvFymCjPsAgv4Ql7COA0U6gbnwijn6F/XNb5f5yQ
         GwwgJJpRrSXf1+PkeBseWfc0H8bhuDWozYwHCDWruBCjoBo4pKe8myjOVYlDVwZSx8am
         0efOyeLm4Z/5RnE6RGLLt0T3e16fmpIFIXM3FEglMRxX2TLlC+9Rw1QDqpQfR7c/aJjG
         8x8rAISoe/pZ+dThtvBOlQNnrCwFkfx/HWKFpU8Knnb7OHt274VSr5vBOYh4zn8Y+rv9
         pIxZUdC0/yLpAAznUNyGtis4rTL/4SOxNY1am7VFpQMxb7B28dirRQTl3t0guSNEmNiF
         76dQ==
X-Gm-Message-State: ANhLgQ1gYU9JzFinRCbABSUhamE5IZmOKAojS2rcd+VNIC/zS2UAzvRU
        OLoj63EESfCo9lajEX/h9gzU8w==
X-Google-Smtp-Source: ADFU+vu/XM+0n/FArOrrpYRuqpoofr0nhTgegl8nM9GcEZ0Y35AWlXD9wYups+i8jASk7u1s54i1cw==
X-Received: by 2002:a92:c904:: with SMTP id t4mr959353ilp.209.1584021973514;
        Thu, 12 Mar 2020 07:06:13 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d1sm6126275ilq.9.2020.03.12.07.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:06:12 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Add support for block disk resize notification
To:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "hch@lst.de" <hch@lst.de>,
        "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "mst@redhat.com" <mst@redhat.com>
References: <20200225200129.6687-1-sblbir@amazon.com>
 <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05bb1606-4cf1-dba3-22a0-5f8624b43767@kernel.dk>
Date:   Thu, 12 Mar 2020 08:06:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f2b805c1a420a07aa9449ee0ef77766a10e9ff20.camel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 9:03 PM, Singh, Balbir wrote:
> On Tue, 2020-02-25 at 20:01 +0000, Balbir Singh wrote:
>> Allow block/genhd to notify user space about disk size changes using a
>> new helper set_capacity_revalidate_and_notify(), which is a wrapper
>> on top of set_capacity(). set_capacity_revalidate_and_notify() will only
>> notify
>> iff the current capacity or the target capacity is not zero and the
>> capacity really changes.
>>
>> Background:
>>
>> As a part of a patch to allow sending the RESIZE event on disk capacity
>> change, Christoph (hch@lst.de) requested that the patch be made generic
>> and the hacks for virtio block and xen block devices be removed and
>> merged via a generic helper.
>>
>> This series consists of 5 changes. The first one adds the basic
>> support for changing the size and notifying. The follow up patches
>> are per block subsystem changes. Other block drivers can add their
>> changes as necessary on top of this series. Since not all devices
>> are resizable, the default was to add a new API and let users
>> slowly convert over as needed.
>>
>> Testing:
>> 1. I did some basic testing with an NVME device, by resizing it in
>> the backend and ensured that udevd received the event.
>>
>>
>> Changelog v2:
>> - Rename disk_set_capacity to set_capacity_revalidate_and_notify
>> - set_capacity_revalidate_and_notify can call revalidate disk
>>   if needed, a new bool parameter is passed (suggested by Bob Liu)
>>
> 
> Ping? It's not an urgent patchset, I am happy to wait if nothing else is
> needed.

It doesn't apply to the 5.7 branches, can you resend against for-5.7/block?

-- 
Jens Axboe

