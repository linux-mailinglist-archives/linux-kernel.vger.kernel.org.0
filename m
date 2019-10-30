Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67708E98B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 10:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfJ3JC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 05:02:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:7949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfJ3JC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:02:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 02:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,246,1569308400"; 
   d="scan'208";a="225264093"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 30 Oct 2019 02:02:51 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] usb: dwc3: Rework clock initialization to be more flexible
In-Reply-To: <CALAqxLXcD8V1o01yMrHpeoqU2MfJ=8d3dbzC8T-+aoovDUd8kA@mail.gmail.com>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-6-john.stultz@linaro.org> <87k18nj4mj.fsf@gmail.com> <CALAqxLXcD8V1o01yMrHpeoqU2MfJ=8d3dbzC8T-+aoovDUd8kA@mail.gmail.com>
Date:   Wed, 30 Oct 2019 11:02:51 +0200
Message-ID: <87h83qhah0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

John Stultz <john.stultz@linaro.org> writes:
> On Tue, Oct 29, 2019 at 2:14 AM Felipe Balbi <balbi@kernel.org> wrote:
>> John Stultz <john.stultz@linaro.org> writes:
>>
>> > The dwc3 core binding specifies three clocks:
>> >   ref, bus_early, and suspend
>> >
>> > which are all controlled in the driver together.
>> >
>> > However some variants of the hardware my not have all three clks
>>                                         ^^
>>                                         may
>>
>> In fact *all* platforms have all three clocks. It's just that in some
>> cases clock pins are shorted together (or take input from same clock).
>>
> ...
>> another option would be to pass three clocks with the same phandle. That
>> would even make sure that clock usage counts are correct, no?
>
> Hey Felipe!
>
> So I actually had done that initially (and it seemed to work), but Rob
> suggested this way instead.
> I'm fine with either, as long as having multiple references to the
> same clk in the enable/disable paths doesn't cause trouble.
>
> Thanks so much for the review here!

same as the other patch, if we're supposed to describe the HW, then we
should describe what's actually happening.

-- 
balbi
