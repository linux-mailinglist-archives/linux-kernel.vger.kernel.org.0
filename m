Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD71F199F13
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 21:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbgCaT3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Mar 2020 15:29:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37584 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgCaT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:29:35 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so20627115ilr.4;
        Tue, 31 Mar 2020 12:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObOJq1WzFHtkZgBcoc/TF7vJW09KReKL6cLNV8fdqDM=;
        b=jIHwIeUUZ0njjkh39zuBhHE0/lmzN2bkvb+lvvG0DZ6qzGoe2SoWqt0gOPTX4J4ts/
         i75mxgc2E9MjLWosdV5b/tfJM//S10YdkEYQPHg8kvU5BmdIBPEAKA3E8gmlot0tTpbB
         W+Z7AaSz37j5YOXRhDo1MzFqy0h7jLUWL3fakS7BPmNau9mAeQVateovINICiVYChJid
         RbVK/n7FSuqL+3jD2v2xzwXRYR/5dt0j4iC12zvAXQ2Oz7Ci4GNu3tMoasS8SkeF3fgV
         skTYBm6e8wjUhODKeZucPxH2Zfql4U9pHEUjgfKEx2BFl9Cf8gvPxqqVj6MVsItV6DvE
         5fBQ==
X-Gm-Message-State: ANhLgQ3NhX19crcXPj5aYgoFw3KO1Gz6AdSU74PQsPVDvG2L6lvZr2Mx
        MSpqkaiYEvvh8CfHtKq0YQ==
X-Google-Smtp-Source: ADFU+vveQIAPsuGoqvWA/0abYxzmeN+7ZOGjnLvYH/Pd7ZBX8SjDAS/lpIBwApsgmlv7Har/ZIo7TQ==
X-Received: by 2002:a92:3a0b:: with SMTP id h11mr18574962ila.4.1585682974301;
        Tue, 31 Mar 2020 12:29:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n6sm5174931iod.9.2020.03.31.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:29:33 -0700 (PDT)
Received: (nullmailer pid 26832 invoked by uid 1000);
        Tue, 31 Mar 2020 19:29:32 -0000
Date:   Tue, 31 Mar 2020 13:29:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kun Yi <kunyi@google.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, joel@jms.id.au,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v2 3/3] dt-bindings: (hwmon/sbtsi_tmep)
 Add SB-TSI hwmon driver bindings
Message-ID: <20200331192932.GA22905@bogus>
References: <20200323233354.239365-1-kunyi@google.com>
 <20200323233354.239365-4-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323233354.239365-4-kunyi@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:33:54PM -0700, Kun Yi wrote:
> Document device tree bindings for AMD SB-TSI emulated temperature
> sensor.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>
> Change-Id: Ife3285afa4cf8d410cb7bee1eb930dc0717084f9
> ---
>  .../devicetree/bindings/hwmon/sbtsi_temp.txt       | 14 ++++++++++++++

Convert to DT schema format and use the compatible string as the 
filename.

>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> new file mode 100644
> index 000000000000..4020f075699e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> @@ -0,0 +1,14 @@
> +*AMD SoC SB-TSI hwmon driver.

Bindings are for hardware, not drivers.

Please give a better explanation of what this h/w.

> +
> +Required properties:
> +- compatible: manufacturer and chip name, should be
> +	"amd,sbtsi",
> +
> +- reg: I2C bus address of the device
> +
> +Example:
> +
> +sbtsi@4c {
> +	compatible = "amd,sbtsi";
> +	reg = <0x4c>;
> +};
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
