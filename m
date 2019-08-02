Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63D7FBE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392273AbfHBOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 10:16:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32972 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbfHBOQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:16:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so1572621wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VDDZkNoGjBHzfk/3qVVuF7BbecezKv+BHiCbXcdhoC0=;
        b=TuHuJ6lPEwf33OjXIE9OyePvq6M4VT9I6gVIPovd4eWX0BgxURoww4krQ8F9nzfZvF
         Z+YdbzXMJ+YgEAws2CURNyb5q6v0k4rExePgS3OXqMgcuCZXt/PuFUw1lGO2sBcqGVlU
         Da/dCDRUgg/Gp//Ur1XjoZD/vvW9lxmks98MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VDDZkNoGjBHzfk/3qVVuF7BbecezKv+BHiCbXcdhoC0=;
        b=OlH9ooq+LGXp4r6SKfE5FRcEKVmdnlKyDjyPEfX2w9f4g/+/0094xVEjl1f5kHLkGw
         fbVAhBSpTNOHXR0BrDjvTBEmM/WVc59JPYgTSa4z5N1BMShzCW3UeO0yaK58rX8eisx5
         HzwxMmzkk5rWqUqudnHbNTVRy+3sBLkwEvGsLKS7Yh0Hn1Ia8+oZMjVUcxzrhFH6OqyZ
         XnPvc07/qj57IEBm/52VeVDFJF8h5vs28v9FdTQ97D1zbDUQ1y9Ph6MPToNCwEYnzeXc
         6fXJTDZLRyHiqEM8DvvPzah/XIhspIMtfLE8E4XKzdAw5BEmrD1N6vAPzbG51aMUx5Y3
         zSRA==
X-Gm-Message-State: APjAAAU3Il85UmhIpq8xLdqB7lEMRaS7sD0Ks69/e73t8oCmG0bhbd6j
        XgYjR7Pz6RcgwdO9q/e1+vzf7g==
X-Google-Smtp-Source: APXvYqxPYYaP1hxY5nwOp+yUMF4ydtrh+mQpZgwUeoYWylD48qeuRuzxTa9OTjfDN/T4ngNQqv1GIQ==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr4752518wmk.97.1564755387548;
        Fri, 02 Aug 2019 07:16:27 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id f2sm71007337wrq.48.2019.08.02.07.16.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:16:26 -0700 (PDT)
Subject: Re: [net-next,rfc] net: bridge: mdb: Extend with multicast LLADDR
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>, idosch@mellanox.com,
        andrew@lunn.ch, davem@davemloft.net, roopa@cumulusnetworks.com,
        petrm@mellanox.com, tglx@linutronix.de, fw@strlen.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux-foundation.org
References: <1564663840-27721-1-git-send-email-horatiu.vultur@microchip.com>
 <f758fdbf-4e0a-57b3-f13d-23e893ba7458@cumulusnetworks.com>
 <20190802140655.ngbok2ubprhivlhy@lx-anielsen.microsemi.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <fcb0e526-778f-5451-9934-e6c2421e4eb3@cumulusnetworks.com>
Date:   Fri, 2 Aug 2019 17:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802140655.ngbok2ubprhivlhy@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2019 17:07, Allan W. Nielsen wrote:
> The 08/01/2019 17:07, Nikolay Aleksandrov wrote:
>>> To create a group for two of the front ports the following entries can
>>> be added:
>>> bridge mdb add dev br0 port eth0 grp 01:00:00:00:00:04 permanent vid 1
>>> bridge mdb add dev br0 port eth1 grp 01:00:00:00:00:04 permanent vid 1
>>>
>>> Now the entries will be display as following:
>>> dev br0 port eth0 grp 01:00:00:00:00:04 permanent offload vid 1
>>> dev br0 port eth1 grp 01:00:00:00:00:04 permanent offload vid 1
>>>
>>> This requires changes to iproute2 as well, see the follogin patch for that.
>>>
>>> Now if frame with dmac '01:00:00:00:00:04' will arrive at one of the front
>>> ports. If we have HW offload support, then the frame will be forwarded by
>>> the switch, and need not to go to the CPU. In a pure SW world, the frame is
>>> forwarded by the SW bridge, which will flooded it only the ports which are
>>> part of the group.
>>>
>>> So far so good. This is an important part of the problem we wanted to solve.
>>>
>>> But, there is one drawback of this approach. If you want to add two of the
>>> front ports and br0 to receive the frame then I can't see a way of doing it
>>> with the bridge mdb command. To do that it requireds many more changes to
>>> the existing code.
>>>
>>> Example:
>>> bridge mdb add dev br0 port eth0 grp 01:00:00:00:00:04 permanent vid 1
>>> bridge mdb add dev br0 port eth1 grp 01:00:00:00:00:04 permanent vid 1
>>> bridge mdb add dev br0 port br0 grp 01:00:00:00:00:04 permanent vid 1 // This looks wrong.
>>>
>>> We believe we come a long way by re-using the facilities in MDB (thanks for
>>> convincing us in doing this), but we are still not completely happy with
>>> the result.
>> Just add self argument for the bridge mdb command, no need to specify it twice.
> Like this:
> bridge mdb add dev br0 port eth1 grp 01:00:00:00:00:04 permanent vid self

What ?! No, that is not what I meant.
bridge mdb add dev br0 grp 01:00:00:00:00:04 permanent vid self
bridge mdb del dev br0 grp 01:00:00:00:00:04 permanent vid self

Similar to fdb. You don't need no-self..
I don't mind a different approach, this was just a suggestion. But please
without "no-self" :)

> 
> Then if I want to remove br0 rom the group, should I then have a no-self, and
> then it becomes even more strange what to write in the port.
> 
> bridge mdb add dev br0 port ?? grp 01:00:00:00:00:04 permanent vid no-self
>                             ^^
> And, what if it is a group with only br0 (the traffic should go to br0 and
> not any of the slave interfaces)?
> 
> Also, the 'self' keyword has different meanings in the 'bridge vlan' and the
> 'bridge fdb' commands where it refres to if the offload rule should be install
> in HW - or only in the SW bridge.

No, it shouldn't. Self means act on the device, in this case act on the bridge,
otherwise master is assumed.

> 
> The proposed does not look pretty bad, but at least it will be possible to
> configured the different scenarios:
> 
> bridge mdb add dev br0 port br0 grp 01:00:00:00:00:04 permanent vid 1
> bridge mdb del dev br0 port br0 grp 01:00:00:00:00:04 permanent vid 1
> 

That works too, but the "port" part is redundant.

> The more I look at the "bridge mdb { add | del } dev DEV port PORT" command, the
> less I understand why do we have both 'dev' and 'port'? The implementation will
> only allow this if 'port' has become enslaved to the switch represented by
> 'dev'. Anyway, what is done is done, and we need to stay backwards compatible,
> but we could make it optional, and then it looks a bit less strange to allow the
> port to specify a br0.
> 
> Like this:
> 
> bridge mdb { add | del } [dev DEV] port PORT grp GROUP [ permanent | temp ] [ vid VID ]
> 
> bridge mdb add port eth0 grp 01:00:00:00:00:04 permanent vid 1
> bridge mdb add port eth1 grp 01:00:00:00:00:04 permanent vid 1
> bridge mdb add port br0  grp 01:00:00:00:00:04 permanent vid 1 // Add br0 to the gruop
> bridge mdb del port br0  grp 01:00:00:00:00:04 permanent vid 1 // Delete it again
> 

br0 is not a port, thus the "self" or just dev or whatever you choose..

> Alternative we could also make the port optional:
> 
> bridge mdb { add | del } dev DEV [port PORT] grp GROUP [ permanent | temp ] [ vid VID ]
> 
> bridge mdb add dev br0 port eth0 grp 01:00:00:00:00:04 permanent vid 1
> bridge mdb add dev br0 port eth1 grp 01:00:00:00:00:04 permanent vid 1
> bridge mdb add dev br0           grp 01:00:00:00:00:04 permanent vid 1 // Add br0 to the gruop
> bridge mdb del dev br0           grp 01:00:00:00:00:04 permanent vid 1 // Delete it again
> 

Right. I read this one later. :)

> Any preferences?
> 

Not really, up to you. Any of the above seem fine to me.

> /Allan
> 
> 

