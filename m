Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E275CE1F0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2019 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGMk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Oct 2019 08:40:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfJGMk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 08:40:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id y35so8172357pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=o1MuM4w6nZQj3YYsyjZt1J3u5QROZgoxO/xrK/RzJMI=;
        b=JjC4fdxPZPkA3Nw9t4f3P3/2H9g7ocjoojpPZh4AkYfyXrUyCA85UZa+JP0DplXe7g
         TPmC2zCfeNdDi7Vicm85y/RP2pcwkqoREGvKrbVQvyYNmWzVgIxX/m2k7rSAFrA0ucan
         5iLwhGD+V27YNQd/gZwtUJg19Q/uDX2f4z46G8yM5aPQvT45yIzNYIxtYK9azpIua/hd
         KvLBZZwqjOzNYuygWFhDlvGwcEqdtjQ0up4WirOONG+HXircyNT4wDpc0JnsB5lJe8C5
         jm7jHSVm7RWi2RdknNrKjK0q5XJ0fF1XT3J5uMZwmePYz/Y8O1Ghkhc2Z/j5LziZBHaS
         V7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=o1MuM4w6nZQj3YYsyjZt1J3u5QROZgoxO/xrK/RzJMI=;
        b=BfgyjSF9RXbcr1KEu8G9+oJRMWbVIHdBZS7ZLyqhiij9PjVAKIIeiu4u+LP2dyenM9
         Z1zgpE6jtJW6RaoScQBjZkzELnWRfoITGupFersgJokKhuhOjsnaNJrrFh1l0Xahzsck
         7qGM6oGUAc4f+n4dtxXon+iMmev0iBlfmDu4xV+RAd07IaJReaTqzaMzuCXFa83zNWSQ
         qMqkobdwDqqJwRtM8MUpzk34ZY/eYV3eyMHV1XLw4tjyxJJOW5mcdJ3cr/cvW4x1RGpj
         BGpiVFiNSIJcARDCer8TzmxIZ4Xp+I6wu2vQffPPY+daGr2NNCoqg5bP3w0EVTuFsxKR
         7WNw==
X-Gm-Message-State: APjAAAUQ5flfvIHftijH/ujvoXeLlGgYRfQKJLmx6qYVrtOqwPQA3R26
        PETeDPIjRpPBkF2P6YOlfvKx
X-Google-Smtp-Source: APXvYqx29oMFzb0lUaEgpdkVH0kexcEoZJP3ixdNTaxpS0rvl/830cXYdtaNMO2S1ZCsPHNbN7J2FQ==
X-Received: by 2002:a63:1f1a:: with SMTP id f26mr9115015pgf.2.1570452058127;
        Mon, 07 Oct 2019 05:40:58 -0700 (PDT)
Received: from ?IPv6:2409:4072:638b:f55:fd38:63ef:5172:157e? ([2409:4072:638b:f55:fd38:63ef:5172:157e])
        by smtp.gmail.com with ESMTPSA id m22sm14177583pgj.29.2019.10.07.05.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 05:40:57 -0700 (PDT)
Date:   Mon, 07 Oct 2019 18:10:50 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <a60fb9ea8922c1eb532e0b7ef0a69abcc9306255.camel@analog.com>
References: <20191007101027.8383-1-manivannan.sadhasivam@linaro.org> <20191007101027.8383-2-manivannan.sadhasivam@linaro.org> <a60fb9ea8922c1eb532e0b7ef0a69abcc9306255.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add binding for ADUX1020
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <4EC23AB5-B8BE-4E45-8E5B-FCCD5B1508BA@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ardelean,=20

On 7 October 2019 3:51:16 PM IST, "Ardelean, Alexandru" <alexandru=2EArdel=
ean@analog=2Ecom> wrote:
>On Mon, 2019-10-07 at 15:40 +0530, Manivannan Sadhasivam wrote:
>> [External]
>>=20
>> Add devicetree binding for Analog Devices ADUX1020 Photometric
>> sensor=2E
>>=20
>
>Hey,
>
>Thanks for the patches=2E
>
>This dt-binding docs is in text format=2E
>dt-binding docs now need to be in YAML format=2E
>

Sure=2E I can convert to YAML binding=2E=20

>Also, patches for dt-bindings docs usually come after the driver is
>added=2E
>So, this patch should be the second in the series, not the first=2E
>

I don't think so=2E The convention is to put dt-bindings patch upfront for=
 all subsystems=2E Not sure if IIO differs here=2E=20

Thanks,=20
Mani
>Alex
>
>> Signed-off-by: Manivannan Sadhasivam
><manivannan=2Esadhasivam@linaro=2Eorg>
>> ---
>>  =2E=2E=2E/bindings/iio/light/adux1020=2Etxt           | 22
>+++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/iio/light/adux1020=2Etxt
>>=20
>> diff --git a/Documentation/devicetree/bindings/iio/light/adux1020=2Etxt
>> b/Documentation/devicetree/bindings/iio/light/adux1020=2Etxt
>> new file mode 100644
>> index 000000000000=2E=2Ee896dda30e36
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/adux1020=2Etxt
>> @@ -0,0 +1,22 @@
>> +Analog Devices ADUX1020 Photometric sensor
>> +
>> +Link to datasheet:=20
>>
>https://www=2Eanalog=2Ecom/media/en/technical-documentation/data-sheets/A=
DUX1020=2Epdf
>> +
>> +Required properties:
>> +
>> + - compatible: should be "adi,adux1020"
>> + - reg: the I2C address of the sensor
>> +
>> +Optional properties:
>> +
>> + - interrupts: interrupt mapping for IRQ as documented in
>> + =20
>Documentation/devicetree/bindings/interrupt-controller/interrupts=2Etxt
>> +
>> +Example:
>> +
>> +adux1020@64 {
>> +	compatible =3D "adi,adux1020";
>> +	reg =3D <0x64>;
>> +	interrupt-parent =3D <&msmgpio>;
>> +	interrupts =3D <24 IRQ_TYPE_LEVEL_HIGH>;
>> +};

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
