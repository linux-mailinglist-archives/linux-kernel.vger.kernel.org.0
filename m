Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D62185A41
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Mar 2020 06:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgCOFXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Mar 2020 01:23:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbgCOFXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 01:23:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id x7so7583412pgh.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 22:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wR8nFRPEBNLxmIrRh2XX942TMuucAJ5R0/7i6Fo9p5k=;
        b=rT4FsdqjKQBVFo3+uu3fzLfB762MuezwSN1LOBD3ukiXZTdXlSwwQK0uPYMfrGKpBw
         HStP0LAwyHUgCf+9x10UYRCF9UJunuqcsp28aLez8GE2hFDyi0ofXM8Dr154ZCspaaDE
         VtH1KqHCF1ohopOvbBe7ipKJhL7UEUPpzwYNws75GT7CW6MhGKCWLuE60W0BotyCDLvo
         r4veXdZGi+c7XAXXCQaraojq3143FgIV7X78c33GlZQNlXCKwXQtmByc8TvqoSmTlHRH
         Cgon8IVWrL7L1XDgxXdvlKuzPupzlbR94v3hnlq4+LXltc9bPmrXUZb2Ky4pFUwuc1FI
         26Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wR8nFRPEBNLxmIrRh2XX942TMuucAJ5R0/7i6Fo9p5k=;
        b=c9+29s5E3tU+JyPYm7FVQBbxiRCNDLJyLwJB9+/2qWhOP2cVF2mF73y6gaI/2o7CT3
         z/4jQLH+fFFYuXHZDw+JofzTiHOHcA9SyXTBTQXc9+/VSLvAvZEFU9y68jJgoXc6kv1P
         6yqYgxdGEhw88vBIxU+vlPmMP+jdKTvLvlE6VNRLWdYKnnaKg/1e6o8jT3vy+qd3MsUx
         rPKrXj+ZXWedAjzM0CcmFYBZkrY1fpdJPLDgxDXNWZP5wFq7yOkMyr6Gy9xk4aZqt6Tj
         MTyFZBPFTmtjFTN4fQgp2Azatg8kAkIvYm7cbc1bORPX7skvwk+eoiMlqL0JnYoYQTFP
         2g7g==
X-Gm-Message-State: ANhLgQ1Hd/Vqc1PUoNZo0HFpcts8cxGk5Ctulq6nGLaDPskl9Ss2zoH5
        aV29qKf1mNbtyuQXGhJpfYal8g==
X-Google-Smtp-Source: ADFU+vs5W6pKhDasxst/A96FZNjz5ZlLsLbn4MZHDngTRdMpMnXsBjfTrhf9HXmupeey+hIoU1207w==
X-Received: by 2002:a63:514f:: with SMTP id r15mr20218986pgl.432.1584249822088;
        Sat, 14 Mar 2020 22:23:42 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s12sm33303143pgi.38.2020.03.14.22.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 22:23:41 -0700 (PDT)
Date:   Sat, 14 Mar 2020 22:23:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: qcom: sdm845: add audio support
Message-ID: <20200315052339.GH1098305@builder>
References: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Mar 07:30 PDT 2020, Srinivas Kandagatla wrote:

> This patchset adds analog audio support for sdm845 based boards.
> 
> 
> Changes since v1:
> 	- various trival cleanups done as suggested by Bjorn
> 	- added compressed audio dai for db845c
> 

Thanks Srini!

I fixed up the sort order per Vinod's feedback and applied these, with
Vinod's acks.

Regards,
Bjorn

> Srinivas Kandagatla (5):
>   arm64: dts: qcom: sdm845: add slimbus nodes
>   arm64: dts: qcom: sdm845: add apr nodes
>   arm64: dts: qcom: c630: Enable audio support
>   arm64: dts: qcom: sdm845: add pinctrl nodes for quat i2s
>   arm64: dts: qcom: db845c: add analog audio support
> 
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 159 ++++++++++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 281 ++++++++++++++++++
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 113 +++++++
>  3 files changed, 553 insertions(+)
> 
> -- 
> 2.21.0
> 
