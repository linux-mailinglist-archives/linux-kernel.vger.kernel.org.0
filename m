Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED5138A17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jan 2020 05:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgAMEAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jan 2020 23:00:18 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:55596 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMEAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 23:00:17 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id C461E327;
        Mon, 13 Jan 2020 12:00:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.22.134] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P18165T140049830598400S1578887992586893_;
        Mon, 13 Jan 2020 12:00:09 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9eb7b5f055a92b996cd0284f5589556f>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: robin.murphy@arm.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5E1BEB37.2010904@rock-chips.com>
Date:   Mon, 13 Jan 2020 11:59:51 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Robin Murphy <robin.murphy@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1] arch_topology: Adjust initial CPU capacities with
 current freq
References: <20200109075214.31943-1-jeffy.chen@rock-chips.com> <20200110113711.GB39451@bogus> <5475692c-e72b-74c1-bd6e-95278703249b@arm.com> <15ab46e5-a2b4-eb96-1217-2b2ef8827f64@arm.com> <5E193828.1070000@rock-chips.com> <5fa797f8-3ba5-7e18-4eed-2d39904b2f72@arm.com>
In-Reply-To: <5fa797f8-3ba5-7e18-4eed-2d39904b2f72@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 01/11/2020 11:12 PM, Robin Murphy wrote:
>>
>
> Actually, last time I looked both the BSP U-Boot and mainline do contain
> equivalent code to initialise both PLLs to (IIRC) 600MHz and apparently
> adjust a couple of other things set by the maskrom. The trap is that
> mainline does it in the SPL - thus the unfortunately common combination
> of using the upstream main stage with the miniloader ends up missing out
> that step entirely. In comparison, I'm now using the full upstream
> TPL/SPL flow on my RK3399 board (NanoPC-T4) and even a full generic
> distro kernel is acceptably quick:
>
> [    2.315378] Trying to unpack rootfs image as initramfs...
> [    2.781747] Freeing initrd memory: 7316K
> ...
> [    4.239990] Freeing unused kernel memory: 1984K
> [    4.247829] Run /init as init process

Oops, sorry for the noise, i've checked in the wrong u-boot code base...

Will ask miniloader team to check that, thanks :)

>
> Robin.



