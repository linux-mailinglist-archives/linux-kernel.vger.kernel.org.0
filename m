Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF43C317E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2019 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfEaX1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 May 2019 19:27:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45546 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfEaX1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 19:27:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 990036077A; Fri, 31 May 2019 23:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559345232;
        bh=G6EhyJ9g00tRI9kO08bdec8G8ptEPWdzLzRXpkaiZXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HMQpuwDh+9qbjOD9qj9hSuH2aXcDmskIgDowXZJDqywcWgZvC1RqLZx9nJ9gv9AXR
         H07wULWdcUsZp0LBitfh+zVPDnEwPrt7PxHoDX4PRpqYJHiqqaauAZAlEN2z/+5vBt
         aL5UfGkLBiLcNp30zXM+4XZRVDuqoBfM1qQeGsuQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.46.160.165] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: collinsd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A8F06077A;
        Fri, 31 May 2019 23:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559345231;
        bh=G6EhyJ9g00tRI9kO08bdec8G8ptEPWdzLzRXpkaiZXw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=doB6uQl3pZKr/0HKUsp3oIm2bbLAQuFpIodFciHO1mvq7+h6AO6ZX6at2vfdu/H4c
         F8ii5eDekCQvRM2oKjEtlbvENU7FKhqQIEaB6vbzALmqrcXBgIKW5zxdlHJUlO29ph
         A/uU4qYw8+0YnbQiDX6J3vb55XLOMGxHFLey0a3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A8F06077A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v1 0/5] Solve postboot supplier cleanup and optimize probe
 ordering
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20190524010117.225219-1-saravanak@google.com>
From:   David Collins <collinsd@codeaurora.org>
Message-ID: <bddb15c9-0195-13ca-e829-0a511595c84e@codeaurora.org>
Date:   Fri, 31 May 2019 16:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524010117.225219-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

On 5/23/19 6:01 PM, Saravana Kannan wrote:
...
> Having functional dependencies explicitly called out in DT and
> automatically added before the devices are probed, provides the
> following benefits:
...
> - Supplier devices like clock providers, regulators providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
This benefit provided by the sync_state() callback function introduced in
this series gives us a mechanism to solve a specific problem encountered
on Qualcomm Technologies, Inc. (QTI) boards when booting with drivers
compiled as modules.  QTI boards have a regulator that powers the PHYs for
display, camera, USB, UFS, and PCIe.  When these boards boot up, the boot
loader enables this regulator along with other resources in order to
display a splash screen image.  The regulator must remain enabled until
the Linux display driver has probed and made a request with the regulator
framework to keep the regulator enabled.  If the regulator is disabled
prematurely, then the screen image is corrupted and the display hardware
enters a bad state.

We have observed that when the camera driver probes before the display
driver, it performs this sequence: regulator_enable(), camera register IO,
regulator_disable().  Since it is the first consumer of the shared
regulator, the regulator is physically disabled (even though display
hardware still requires it to be enabled).  We have solved this problem
when compiling drivers statically with a downstream regulator
proxy-consumer driver.  This proxy-consumer is able to make an enable
request for the shared regulator before any other consumer.  It then
removes its request at late_initcall_sync.

Unfortunately, when drivers are compiled as modules instead of compiled
statically into the kernel image, late_initcall_sync is not a meaningful
marker of driver probe completion.  This means that our existing proxy
voting system will not work when drivers are compiled as modules.  The
sync_state() callback resolves this issue by providing a notification that
is guaranteed to arrive only after all consumers of the shared regulator
have probed.

QTI boards have other cases of shared resources such as bus bandwidth
which must remain at least at a level set by boot loaders in order to
properly support hardware blocks that are enabled before the Linux kernel
starts booting.

Take care,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
