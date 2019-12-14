Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2511EE8F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2019 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfLMXa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Dec 2019 18:30:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43642 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLMXa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 18:30:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so1024288oth.10;
        Fri, 13 Dec 2019 15:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtY2+T1ox0A8va554qxncCqvVnnEac9GVhKoxQz2brU=;
        b=ns1Cl2YKnjYhrNT0mnFaujDQeAnBgF0pKxUu3q84eZ3xem6q1t2XAwAUG3SSumchGD
         tdc9kCJhqDEsdDyjKwgPuP+2apeYRLioxj+v7kYIY4l9wcOGwlmTIJQrLSODuME6dD8y
         lbs3Tq3ATBjinmmQlItrXKBdioAbhLC80MV2xAnnfw9S3NUhFeN/yfAp5nlk8Vf4WtsC
         U6FpZxxYT4laBZJx1vY3x3As0X5EjEtVkHKZEZyqeum6zRY0/OFCrlxDCtuIZ058/IVL
         G80F5DMEyPC+vb9i4ulHuawT7GT9+K0SI1cfM7HVl+rFZAnhjQ7M2QoVcNEwc665a7vX
         Q5jA==
X-Gm-Message-State: APjAAAVTkOxjxL7+4xsKiS+NyJ/xQQb63cPH4iSeWSXCi0iZXEegD0bg
        TtSdSx9TlcIuW5S9Li1dKQ==
X-Google-Smtp-Source: APXvYqw2C389pcvF1+lJ2N1jxwZzZt9i/M4bE79s8BprnibexkABp7GRtQp/76wBTLLcKD0z28qDVA==
X-Received: by 2002:a9d:7f11:: with SMTP id j17mr18076404otq.281.1576279856058;
        Fri, 13 Dec 2019 15:30:56 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j43sm3920091ota.59.2019.12.13.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 15:30:55 -0800 (PST)
Date:   Fri, 13 Dec 2019 17:30:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     kernel@puri.sm, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: Re: [PATCH 2/2] ASoC: gtm601: add the broadmobi interface
Message-ID: <20191213233054.GA28177@bogus>
References: <20191202174831.13638-1-angus@akkea.ca>
 <20191202174831.13638-3-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202174831.13638-3-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Dec 2019 10:48:31 -0700, "Angus Ainslie (Purism)" wrote:
> The Broadmobi BM818 uses a different sample rate and channels from the
> option modem.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/sound/gtm601.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
