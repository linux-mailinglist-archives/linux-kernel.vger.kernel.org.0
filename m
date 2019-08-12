Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B84AD896C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 07:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfHLF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 01:27:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:37449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfHLF1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:27:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 22:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,376,1559545200"; 
   d="scan'208";a="259676344"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2019 22:27:12 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [EXT] Re: [PATCH v1] usb: dwc3: remove the call trace of USBx_GFLADJ
In-Reply-To: <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
References: <20190729064607.8131-1-yinbo.zhu@nxp.com> <875zn8nt31.fsf@gmail.com> <VI1PR04MB41580DBF1A0C2DC143EE9CE3E9D30@VI1PR04MB4158.eurprd04.prod.outlook.com>
Date:   Mon, 12 Aug 2019 08:27:11 +0300
Message-ID: <87h86nvtqo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Yinbo Zhu <yinbo.zhu@nxp.com> writes:
>> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c index
>> > 98bce85c29d0..a133d8490322 100644
>> > --- a/drivers/usb/dwc3/core.c
>> > +++ b/drivers/usb/dwc3/core.c
>> > @@ -300,8 +300,7 @@ static void dwc3_frame_length_adjustment(struct
>> > dwc3 *dwc)
>> >
>> >       reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
>> >       dft = reg & DWC3_GFLADJ_30MHZ_MASK;
>> > -     if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
>> > -         "request value same as default, ignoring\n")) {
>> > +     if (dft != dwc->fladj) {
>> 
>> if the value isn't different, why do you want to change it?
>> 
>> --
>> Balbi
> Hi Balbi,
>
> I don't change any value. I was remove that call trace.

Sure you do. The splat only shows when you request a FLADJ value that's
the same as the one already in the register. The reason you see the
splat is because your requested value is what's already in the HW.

So, again, why are you adding this device tree property if the value is
already the correct one?

> In addition that GFLADJ_30MHZ value intial value is 0, and it's value
> must be 0x20, if not, usb will not work.

it's not zero, otherwise the splat wouldn't trigger. You're requesting
the value that's already in your register by default.

-- 
balbi
