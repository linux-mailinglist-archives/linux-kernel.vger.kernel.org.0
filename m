Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0F866D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 18:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfHHQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 12:20:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34985 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:20:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so44392995pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=rpT1/n0MtDKR55gc7Xe/1ERiGiwTe4vZMPU9Bfy10FI=;
        b=Y7o7tDsMydMyUuzGRnboQKe/5DZGF0GAAcTEKQ3TnqBW9YBJW+NKiPXSdtZCCYObN8
         AtJrE90vxGnVWdwPAxzaJhl9IPp4pUP4BUo49u+TH7K9mJ7N7xJ5Ne1r/mTSLgfDqOqe
         KMeAzvYaE5+sipQTmnJqT9BRA14XUcjFtqt14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=rpT1/n0MtDKR55gc7Xe/1ERiGiwTe4vZMPU9Bfy10FI=;
        b=aHpswDJ4BM03kI7Hk6HE5+aWa21U6RVJ9mhUW71P1mOU86M2KDqgzNRUg2La7MieJ+
         69io1TakOSJwI5t6jG4GZ/uKhCOfBlsFVLyAzsReQAgGga8arY8p8C+UFmnrnQLbe7TZ
         earAUNv9PJy85SgDiCUlb78PhNvtvuA4NrIdFzYjqDTkMBAu9ZL1CPLwRcs+IBiVv5v5
         BH/+2CkAygRZ0hakV8xlRrkk9ZJ0P7ig5oUO7zoT/PAtL0RG+VmAOYFJPUHdcQHNyUVF
         HwimjDRAOeze71DRnjGUqYJ2vJi0g8/yL+0r4NDVsaKuDr/NyuzHlRUEkQJrQYiEGZ3z
         ifjQ==
X-Gm-Message-State: APjAAAUfL3I5TugdL5X1US0KTjdIZn5WPc98PhYbulxnZ11uKSGy5rZq
        FEtWeXdI9upo/FgnwaGSJEubAFuiRAo=
X-Google-Smtp-Source: APXvYqwrRIJFaN3/EOnl4mURCxYQeFmoB2bV4p9L6PhJ6mv+tvNN2NH1QgEbMDZXoHTTiaqtDYC/uQ==
X-Received: by 2002:a17:90a:c58e:: with SMTP id l14mr4875532pjt.104.1565281206991;
        Thu, 08 Aug 2019 09:20:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j6sm3065998pjd.19.2019.08.08.09.20.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 09:20:06 -0700 (PDT)
Message-ID: <5d4c4bb6.1c69fb81.db640.7518@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190808061228.16573-2-mkshah@codeaurora.org>
References: <20190808061228.16573-1-mkshah@codeaurora.org> <20190808061228.16573-2-mkshah@codeaurora.org>
Subject: Re: [PATCH 1/2] dt-bindings: Introduce soc sleep stats bindings for Qualcomm SoCs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, mkshah@codeaurora.org,
        devicetree@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Thu, 08 Aug 2019 09:20:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2019-08-07 23:12:27)
> Add device binding documentation for Qualcomm Technology Inc's (QTI)
> SoC sleep stats driver. The driver is used for displaying SoC sleep
> statistic maintained by Always On Processor or Resource Power Manager.
>=20
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Your SoB chain is odd. The author is Mahesh? Otherwise, use the
Co-Developed-by tag.

> ---
>  .../bindings/soc/qcom/soc-sleep-stats.txt     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-=
stats.txt
>=20
> diff --git a/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.t=
xt b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
> new file mode 100644
> index 000000000000..ee40687ded34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
> @@ -0,0 +1,36 @@
> +* SoC Sleep Stats
> +
> +Always On Processor/Resource Power Manager maintains statistics of the S=
oC
> +sleep modes involving lowering or powering down of the backbone rails - =
Cx

What is a 'backbone' rail?

> +and Mx and the oscillator clock, XO.

Drop the comma? XO is the oscillator clock.

> +
> +Statistics includes SoC sleep mode type, number of times low power mode =
were
> +entered, time of last entry, time of last exit and accumulated sleep dur=
ation.
> +SoC Sleep Stats driver provides sysfs interface to display this informat=
ion.

Can this document be YAML? Then it can be validated.

> +
> +PROPERTIES
> +
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Should be "qcom,rpmh-sleep-stats" or "qcom,rpm-sleep-=
stats".
> +
> +- reg:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: The base address on the Always On Processor or Resour=
ce Power
> +                   Manager from where the stats are read.
> +
> +EXAMPLE 1:
> +
> +       rpmh_sleep_stats: soc-sleep-stats@c3f0000 {
> +               compatible =3D "qcom,rpmh-sleep-stats";
> +               reg =3D <0 0xc3f0000 0 0x400>;

Is this memory region in DDR? Or some specific IMEM location? I wonder
if it would be better to just have a pointer from the RPM node to this
memory region and then populate some stats if so.

> +       };
> +
