Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E5E487E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 12:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409571AbfJYKV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 06:21:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:52381 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409177AbfJYKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:21:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 03:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="210348774"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 03:21:56 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue Bindings to YAML schemas
In-Reply-To: <CAFBinCBOEG6GT=dp5XQ3+nC18axSodPbgMfE6F7eHLE3gZfSoA@mail.gmail.com>
References: <20191021132322.25256-1-narmstrong@baylibre.com> <875zkhdye5.fsf@gmail.com> <CAFBinCBOEG6GT=dp5XQ3+nC18axSodPbgMfE6F7eHLE3gZfSoA@mail.gmail.com>
Date:   Fri, 25 Oct 2019 13:21:55 +0300
Message-ID: <87sgnh2kho.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
> Hi Felipe,
>
> On Tue, Oct 22, 2019 at 9:39 AM Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>>
>>
>> Hi,
>>
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>
>> > Now that we have the DT validation in place, let's convert the device tree
>> > bindings for the Amlogic G12A DWC3 Glue Bindings over to a YAML schemas,
>> > the AXG and GXL glue bindings will be converted later.
>> >
>> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Is this a thing now? Why do we need a new format?
> this is a 2019 thing now, see an initial announcement from Rob from a
> year ago: [0]
>
> the new yaml schemas allow validation of the actual .dts
> this can be used for verifying that the example in the dt-bindings is
> correct, as well as for verifying the actual .dts file (so they match
> the actual dt-binding)
> (Rob's old mail - linked above - still has these two on the TODO list,
> nowadays this works fine)
>
> Neil is working towards full yaml schema based validation for all IP
> blocks used on Amlogic SoCs.
> with this patch we get a bit closer to that goal

cool, thanks for the background :-)

-- 
balbi
