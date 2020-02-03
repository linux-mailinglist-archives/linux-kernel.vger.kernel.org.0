Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B35081510E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 21:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBCUT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 15:19:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42805 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgBCUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:19:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so10614065lfl.9;
        Mon, 03 Feb 2020 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9GXJ+7r6oiE/L24yszgp1Pie8R7EQEZ8furWhzEtKIk=;
        b=s8G/UjN6/Iggd3V7YYei6RXf4vXI2Jj2Jd9wlbbaFcBkjtKIph8VvxRkG+njnQdjHT
         sPK4Fbtmb08yfyvcb9STkYPkuFcOWUfRwN+k7JLRCWAaP3Mnm8pmEmK4JLE5xmn0YQt3
         FAjbFsz4E8y6vCQRCYlhJp44FjPd7hfGBH6Tgx4K1fc5MAs/5P0UyBBUEgaVn/h0srmX
         qMCyfYzt2XiRLrggy/kOMG0ls5i+GE/d+uUvJIr0wogUDluYJe1+JVc9PKPFcBpi7JFR
         /MLYzCV1lWewB+3w6xqFX2XLOxr02yuWi8s1q0kLPcp+LSNS6cmed5/qe+ELInKkeWic
         RQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9GXJ+7r6oiE/L24yszgp1Pie8R7EQEZ8furWhzEtKIk=;
        b=T+upgFtngKMtBGsPHD+G3jMlF/3vMSJGjj6IcKLjNhAUDkMh13CeSXKRtlJfkCt+vu
         GcJ4uEVIwbqyAEeQY1cxPP61QvTFaa3B6Up14sDmQtsTbwHqmpsMBbruI2z1oKDCT+CI
         jUwI9uW5Hz9iOEe9f9YevYu56pNV3n4xe0ON0dn/vQ10F4WOT2r4MU/m9WrurXc3nVuH
         fHsGELX63BO0PLuV3mS/fnSYYItNFODzB1nacmj8kha06wpZG92bykSMPuNXZ4y4FOIZ
         43dMlCNU36YOQCsONX31ge9hx9CsYmhvPki7sM7fdRJzdC14RrbJA3t7IJpMUAmtQQcM
         rTcw==
X-Gm-Message-State: APjAAAUkU3veYC8LZRpt7KSu9GcwWZYFaABNP6RQqskSxHzVQZWHvrqC
        Z6sggYMqkoQfBjtJ+iQd6WY=
X-Google-Smtp-Source: APXvYqwzpgdvLMjIj20yWb5w3ZfeDuvBaMreduxxHsa9a72L0x/lbj7UgdSdmQVXk1ab61jn6P20Sg==
X-Received: by 2002:a19:c192:: with SMTP id r140mr12870058lff.113.1580761166596;
        Mon, 03 Feb 2020 12:19:26 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r12sm10298001ljh.105.2020.02.03.12.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 12:19:25 -0800 (PST)
Subject: Re: [PATCH v2 1/9] dt-bindings: sound: tegra: add DT binding for AHUB
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-2-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <32d6c62d-0ac4-54e0-2efb-9f9a8cf2d271@gmail.com>
Date:   Mon, 3 Feb 2020 23:19:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-2-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

30.01.2020 13:33, Sameer Pujar пишет:
...
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          const: nvidia,tegra210-i2s
> +      - items:
> +          - enum:
> +              - nvidia,tegra194-i2s
> +              - nvidia,tegra186-i2s
> +          - enum:
> +              - nvidia,tegra210-i2s

Couldn't this be something like this:

properties:
  compatible:
    - enum:
      - nvidia,tegra210-i2s
      - nvidia,tegra186-i2s
      - nvidia,tegra194-i2s
