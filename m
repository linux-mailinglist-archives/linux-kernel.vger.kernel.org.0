Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11B551487D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jan 2020 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgAXOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jan 2020 09:25:06 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61223 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392271AbgAXOV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:21:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579875716; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jiI1uJZF61zF9q0RLqAiLf10/keLiT+nvZg6ovSERgc=;
 b=vzClSq3PzlOv4BtnZbI4b+7ECCXlP7zeMBDvnk/sJB+9YiesLUsOdI4iOye9MvZ/A4bWR5Gn
 2cPU9Aur64x+IVE+NM0iNbH+0ptgTCrDMYHyH3HqcP3SjX7ZgdnO0LHI49yioxFK/Iqot2y/
 i+KJ5pwLgeMH9Zvx/RiBDwMYrgw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2afd81.7f97f26c5c00-smtp-out-n03;
 Fri, 24 Jan 2020 14:21:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6752C447B1; Fri, 24 Jan 2020 14:21:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5B7F4C433CB;
        Fri, 24 Jan 2020 14:21:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jan 2020 19:51:49 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     James Morse <james.morse@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org, baicar@os.amperecomputing.com
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC
In-Reply-To: <312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a3259-eee09e9e-e99a-40f1-ab1c-63e58a42615c-000000@us-west-2.amazonses.com>
 <312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com>
Message-ID: <3c3b1d8107a26bbbf8daca3a6c43caca@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 2020-01-16 00:18, James Morse wrote:
> Hi Sai,
> 
> (CC: +Tyler)
> 
> On 05/12/2019 09:53, Sai Prakash Ranjan wrote:
>> This adds DT bindings for Kryo EDAC implemented with RAS
>> extensions on KRYO{3,4}XX CPU cores for reporting of cache
>> errors.
> 
> KRYO{3,4}XX isn't the only SoC with the RAS extensions. The DT needs
> to convey the range
> of ways this armv8 RAS extensions stuff can be wired up.
> 

Right, but I was going for Kryo specific implementation and hence the 
binding as such.

> The folk who look after the ACPI specs have made a start:
> https://static.docs.arm.com/den0085/a/DEN0085_RAS_ACPI_1.0_BETA_1.pdf
> 
> (I suspect that isn't the latest version, I'll try and find out)
> 

That would be helpful, thanks.

> I'd like the ACPI table and DT to convey the same information so that
> we don't need to
> convert or infer things in the driver. If something is missing, we
> should get it added!
> 

Sure, I think it is decided now that kernel first RAS implementation 
will be generic.

> 
>> diff --git 
>> a/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml 
>> b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>> new file mode 100644
>> index 000000000000..1a39429a73b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/edac/qcom-kryo-edac.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/edac/qcom-kryo-edac.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Kryo Error Detection and Correction(EDAC)
>> +
>> +maintainers:
>> +  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> +
>> +description: |
>> +  Kryo EDAC is defined to describe on-chip error detection and 
>> correction
>> +  for the Kryo CPU cores which implement RAS extensions.
> 
> Please don't make this Kryo specific, otherwise this binding becomes
> an extra thing we
> need to support with a 'v8.2 RAS' driver.
> 
> What I'd like is a single 'armv82_ras' edac driver that handles faults
> and errors reported
> by interrupts, and interacts with the arch code's handling of
> 'external aborts'. This
> should work for all platforms using v8.2 RAS and later.
> 
> 

Ok sure.

>> +  It will report
>> +  all Single Bit Errors and Double Bit Errors found in L1/L2 caches 
>> in
>> +  in two registers ERXSTATUS_EL1 and ERXMISC0_EL1. L3-SCU cache 
>> errors
>> +  are reported in ERR1STATUS and ERR1MISC0 registers.
>> +    ERXSTATUS_EL1 - Selected Error Record Primary Status Register, 
>> EL1
>> +    ERXMISC0_EL1 - Selected Error Record Miscellaneous Register 0, 
>> EL1
>> +    ERR1STATUS - Error Record Primary Status Register
>> +    ERR1MISC0 - Error Record Miscellaneous Register 0
>> +  Current implementation of Kryo ECC(Error Correcting Code) mechanism 
>> is
>> +  based on interrupts.
> 
> Your SoC picked the system registers as the interface to these
> component's registers.
> The binding would need to specify which index the 'l1-l2' records
> start at, and how many
> there are. The same for the 'l3-scu'. You can't hard code these, they
> are different on
> other platforms.
> 

Ok will keep this in mind for the next version.

> There is also an MMIO interface which needs a base address, along with
> the index and
> ranges. (which may be different). The same component may use both the
> system register and
> the MMIO interface.
> 

I have some doubts here, Where do I get this info? Will this be 
implementation specific?

> This stuff is likely to vary on big/little systems, so you need a way
> of describing which
> CPUs the settings refer to. This probably isn't something the ACPI
> tables capture as ACPI
> machines are typically homogenous.
> 

Our SoCs are based on big.LITTLE arch, so this will be needed.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
