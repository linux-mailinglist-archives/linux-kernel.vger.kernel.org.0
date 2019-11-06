Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D60F0F18
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 07:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfKFGoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 01:44:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfKFGoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 01:44:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 65FE961186; Wed,  6 Nov 2019 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573022640;
        bh=42CLJ/ww7+uXdAJLfPh+1+RfcFXtImJ/OlVgtayzZSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bV12NHnSPbKxJQnDPKfiOT9WTaTGypL6VHkHfSrcvOm58+TDrUBjrNTo1epGGfI0W
         JTlJbm4l6TJ1oi1La19/zARbulmbukTtgptFCKe4df6fKjlu9EQytvoeT6vAFDq8oA
         872vHOSkYEUpyodLNrURQJ6XdebIuB+YVglbF1J4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4E1AB60D7B;
        Wed,  6 Nov 2019 06:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573022639;
        bh=42CLJ/ww7+uXdAJLfPh+1+RfcFXtImJ/OlVgtayzZSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dU0u4vis36ZClO+i9NY9xZZGqM4y4lDCfen1VGz5xT0jvdRyxkFTV6qhM9ur4gPfa
         zkxukND5EjfcrfD8H31AMVvxUC1WRPJc8kuhB1PfhmX/7EtbVUjPnXvh+Z0by7mXj0
         Kb/LakGkE1mhUPoYKoVZcZLfn09tjCZ8/BK/pSJM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Nov 2019 12:13:59 +0530
From:   kgunda@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        lee.jones@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH V2] mfd: qcom-spmi-pmic: Add support for pm6150 and
 pm6150l
In-Reply-To: <5dc1cb4c.1c69fb81.af253.0b8a@mx.google.com>
References: <1572931309-16250-1-git-send-email-kgunda@codeaurora.org>
 <5dc1cb4c.1c69fb81.af253.0b8a@mx.google.com>
Message-ID: <c4cee81775c6d82024ca05250290f603@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-06 00:49, Stephen Boyd wrote:
> Quoting Kiran Gunda (2019-11-04 21:21:49)
>> Add the compatibles and PMIC ids for pm6150 and pm6150l PMICs
>> found on SC7180 based platforms.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  - Changes from V1:
>>    Sorted the macros and compatibles.
> 
> I don't see anything sorted though.
> 
Sorry .. I might have misunderstood your comment. Let me know if my 
understanding is correct.

>>>> And compatible here.
>>> And on macro name here.

This means you want to sort all the existing compatible and macros in 
alpha numeric order ?

>>>> Please sort on compatible string
This means you want sort in the order how the compatibles are defined ?

>> 
>>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 2 ++
>>  drivers/mfd/qcom-spmi-pmic.c                             | 4 ++++
>>  2 files changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt 
>> b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>> index 1437062..b5fc64e 100644
>> --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>> @@ -32,6 +32,8 @@ Required properties:
>>                     "qcom,pm8998",
>>                     "qcom,pmi8998",
>>                     "qcom,pm8005",
>> +                  "qcom,pm6150",
>> +                  "qcom,pm6150l",
> 
> And this looks badly tabbed or something?
> 
My bad, I used tabs. Will correct it in next post.
>>                     or generalized "qcom,spmi-pmic".
>>  - reg:             Specifies the SPMI USID slave address for this 
>> device.
>>                     For more information see:
>> diff --git a/drivers/mfd/qcom-spmi-pmic.c 
>> b/drivers/mfd/qcom-spmi-pmic.c
>> index e8fe705..74b7980 100644
>> --- a/drivers/mfd/qcom-spmi-pmic.c
>> +++ b/drivers/mfd/qcom-spmi-pmic.c
>> @@ -34,6 +34,8 @@
>>  #define PM8998_SUBTYPE         0x14
>>  #define PMI8998_SUBTYPE                0x15
>>  #define PM8005_SUBTYPE         0x18
>> +#define PM6150_SUBTYPE         0x28
>> +#define PM6150L_SUBTYPE                0x27
>> 
>>  static const struct of_device_id pmic_spmi_id_table[] = {
>>         { .compatible = "qcom,spmi-pmic", .data = (void 
>> *)COMMON_SUBTYPE },
>> @@ -53,6 +55,8 @@
>>         { .compatible = "qcom,pm8998",    .data = (void 
>> *)PM8998_SUBTYPE },
>>         { .compatible = "qcom,pmi8998",   .data = (void 
>> *)PMI8998_SUBTYPE },
>>         { .compatible = "qcom,pm8005",    .data = (void 
>> *)PM8005_SUBTYPE },
>> +       { .compatible = "qcom,pm6150",    .data = (void 
>> *)PM6150_SUBTYPE },
>> +       { .compatible = "qcom,pm6150l",   .data = (void 
>> *)PM6150L_SUBTYPE },
>>         { }
>>  };
>> 
