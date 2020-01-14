Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6FB13A151
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 08:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgANHHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jan 2020 02:07:42 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:51880 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgANHHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 02:07:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578985661; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qGSpKHg1v3GaypfXacRfBUcb5HjtNoP8w3KMAy4Kc04=;
 b=IqN2y9b3Z/XGdD/7LDWW/EaxdJ8q5kfGcLdr85dNcCOedKL6Fr5uziPy/pzeGXqOCMRZMfq9
 zigi6IDYHtEAK0ssNWbOitsfeYDhsTDzlggVltJEtukjOcRA+UFn422Ug4YFGYCA6NBNJ485
 Hwv0+yqPBan5F4NBI6ssO/QyOwM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1d68bb.7f2d3ff186c0-smtp-out-n01;
 Tue, 14 Jan 2020 07:07:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 894D2C433A2; Tue, 14 Jan 2020 07:07:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sthella)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD8DBC43383;
        Tue, 14 Jan 2020 07:07:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jan 2020 12:37:38 +0530
From:   sthella@codeaurora.org
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: add binding for QTI SPMI SDAM
In-Reply-To: <CAL_JsqLZN9F9=1sqFkoaWpwNKDOUAgOMrc9cqk-iohMxkeM-8A@mail.gmail.com>
References: <1577165532-28772-1-git-send-email-sthella@codeaurora.org>
 <20200108163943.GA26863@bogus>
 <8aeb91730552357db340f8bfb21e6d15@codeaurora.org>
 <CAL_JsqL5Gh2A3KfCgRFv+B50Y4PPF1b+qq8vY6yKhbea6KPAkw@mail.gmail.com>
 <b4f2fcc0d0a6724d77947f917f114d80@codeaurora.org>
 <CAL_JsqLZN9F9=1sqFkoaWpwNKDOUAgOMrc9cqk-iohMxkeM-8A@mail.gmail.com>
Message-ID: <b15e274e9134b159fadb41de6cd5ea89@codeaurora.org>
X-Sender: sthella@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-13 21:12, Rob Herring wrote:
> On Fri, Jan 10, 2020 at 2:54 AM <sthella@codeaurora.org> wrote:
>> 
>> On 2020-01-09 21:01, Rob Herring wrote:
>> > On Thu, Jan 9, 2020 at 4:57 AM <sthella@codeaurora.org> wrote:
>> >>
>> >> On 2020-01-08 22:09, Rob Herring wrote:
>> >> > On Tue, Dec 24, 2019 at 11:02:12AM +0530, Shyam Kumar Thella wrote:
>> >> >> QTI SDAM allows PMIC peripherals to access the shared memory that is
>> >> >> available on QTI PMICs. Add documentation for it.
>> >> >>
>> >> >> Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
>> >> >> ---
>> >> >>  .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  | 79
>> >> >> ++++++++++++++++++++++
>> >> >>  1 file changed, 79 insertions(+)
>> >> >>  create mode 100644
>> >> >> Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
>> >> >>
>> >> >> diff --git
>> >> >> a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
>> >> >> b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
>> >> >> new file mode 100644
>> >> >> index 0000000..8961a99
>> >> >> --- /dev/null
>> >> >> +++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
>> >> >> @@ -0,0 +1,79 @@
>> >> >> +# SPDX-License-Identifier: GPL-2.0
>> >> >
>> >> > Dual license new bindings:
>> >> >
>> >> > (GPL-2.0-only OR BSD-2-Clause)
>> >> >
>> >> > Please spread the word in QCom.
>> >> Sure. I will add Dual license in next patchset.
>> >> >
>> >> >> +%YAML 1.2
>> >> >> +---
>> >> >> +$id: http://devicetree.org/schemas/nvmem/qcom,spmi-sdam.yaml#
>> >> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> >> +
>> >> >> +title: Qualcomm Technologies, Inc. SPMI SDAM DT bindings
>> >> >> +
>> >> >> +maintainers:
>> >> >> +  - Shyam Kumar Thella <sthella@codeaurora.org>
>> >> >> +
>> >> >> +description: |
>> >> >> +  The SDAM provides scratch register space for the PMIC clients. This
>> >> >> +  memory can be used by software to store information or communicate
>> >> >> +  to/from the PBUS.
>> >> >> +
>> >> >> +allOf:
>> >> >> +  - $ref: "nvmem.yaml#"
>> >> >> +
>> >> >> +properties:
>> >> >> +  compatible:
>> >> >> +    enum:
>> >> >> +      - qcom,spmi-sdam
>> >> >> +
>> >> >> +  reg:
>> >> >> +    maxItems: 1
>> >> >> +
>> >> >> +  "#address-cells":
>> >> >> +    const: 1
>> >> >> +
>> >> >> +  "#size-cells":
>> >> >> +    const: 1
>> >> >
>> >> > ranges? The child addresses should be translateable I assume.
>> >> The addresses are not memory mapped on the CPU's address domain. They
>> >> are the SPMI addresses which can be accessed over SPMI controller.
>> >
>> > Doesn't have to be a CPU address. Are the child offsets within the
>> > range defined in the parent 'reg'? If so, then it should have
>> > 'ranges'.
>> Yes the child offsets fall within parent reg's address space.
>> I will add ranges in the next patch set.
>> >
>> >> >
>> >> >> +
>> >> >> +required:
>> >> >> +  - compatible
>> >> >> +  - reg
>> >> >> +
>> >> >> +patternProperties:
>> >> >> +  "^.*@[0-9a-f]+$":
>> >> >> +    type: object
>> >> >> +
>> >> >> +    properties:
>> >> >> +      reg:
>> >> >> +        maxItems: 1
>> >> >> +        description:
>> >> >> +          Offset and size in bytes within the storage device.
>> >> >> +
>> >> >> +      bits:
>> >> >
>> >> > Needs a type reference.
>> >> Yes. I will add a reference in the next patch set.
>> >> >
>> >> >> +        maxItems: 1
>> >> >> +        items:
>> >> >> +          items:
>> >> >> +            - minimum: 0
>> >> >> +              maximum: 7
>> >> >> +              description:
>> >> >> +                Offset in bit within the address range specified by
>> >> >> reg.
>> >> >> +            - minimum: 1
>> >> >
>> >> > max is 7?
>> >> I don't think it is limited to 7 as it is the size within the address
>> >> range specified by reg. If the address range is more than a byte size
>> >> can be more.
>> >
>> > Then why is the maximum offset 7?
>> I see. Offset can be more than 7 within the address range specified in
>> case
>> of data cells with more than a byte. I will remove maximum in the next
>> patch set.
> 
> That's the wrong thing to do though. If the offset is more than 7, you
> should just increase 'reg' value. IOW, 'bits' should only be used to
> express bit position up to the minimum alignment of 'reg'. I guess you
> could have an unaligned multi-byte field, so I guess this is fine
> as-is.
> 
> Rob
Okay.

Regards,
Shyam
